
<#
.Synopsis
     The function to return installed modules

.DESCRIPTION
    The function return information about all modules on the host.
    'Get-PSInstalledModule' default returns modules in CurrentUser scope.

    Available scope: CurrentUser and AllUsers

.EXAMPLE
    PS C:\> Get-PSInstalledModule

    Name                           LatestVersion        Count      Scope                SpaceUsedMb
    ----                           -------------        -----      -----                -----------
    Az.Accounts                    2.1.0                4          CurrentUser          73,02
    Az.Advisor                     1.1.1                1          CurrentUser          0,34
    Az.Aks                         2.0.0                4          CurrentUser          5,06
    Az.AnalysisServices            1.1.4                3          CurrentUser          1,72
    Az.ApiManagement               2.1.0                3          CurrentUser          18,02
    Az.ApplicationInsights         1.1.0                2          CurrentUser          1,58

.EXAMPLE
    PS C:\> Get-PSInstalledModule PSHTML -Scope AllUsers | Select *

    Name          : PSHTML
    LatestVersion : 0.8.0
    Count         : 2
    Modules       : {@{Name=PSHTML; Version=0.8.0; Scope=AllUsers; ModuleBase=C:\Program Files\WindowsPowerShell\Modules\PSHTML\0.8.0; SpaceUsed=1465159; PowerShellVersion=5.0}, @{Name=PSHTML; Version=0.5.19; Scope=AllUsers; M
                    oduleBase=C:\Program Files\WindowsPowerShell\Modules\PSHTML\0.5.19; SpaceUsed=587854; PowerShellVersion=3.0}}
    Scope         : AllUsers
    SpaceUsedMb   : 1,96
    Description   : Cross platform PowerShell module to generate HTML markup language and create awesome web pages!
    Author        : StĂ©phane van Gulick
    CompanyName   : District

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name PSReadLine

    Name                           LatestVersion        Count      Scope                SpaceUsedMb
    ----                           -------------        -----      -----                -----------
    PSReadLine                     2.2.0                2          CurrentUser          0,93

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name dba*

    Name                           LatestVersion        Count      Scope                SpaceUsedMb
    ----                           -------------        -----      -----                -----------
    dbachecks                      2.0.3                1          CurrentUser          2,68
    dbatools                       1.0.113              1          CurrentUser          99,48


.EXAMPLE
    PS C:\> Get-PSInstalledModule -Scope AllUsers

    Name                           LatestVersion        Count      Scope                SpaceUsedMb
    ----                           -------------        -----      -----                -----------
    ALTools                        0.0.2                1          AllUsers             0,01
    ARMHelper                      0.6.3                1          AllUsers             0,05
    Azure                          5.1.2                1          AllUsers             106,33
    ...

.EXAMPLE
    PS C:\> Get-PSInstalledModule PSHTML  -Scope AllUsers

    Name                           LatestVersion        Count      Scope                SpaceUsedMb
    ----                           -------------        -----      -----                -----------
    PSHTML                         0.8.0                2          AllUsers             1,96

.EXAMPLE
    PS C:\> Get-PSInstalledModule | Out-GridView

.NOTES
    Author: Mateusz Nadobnik
    Link: akademiapowershell.pl

    Date: 15-04-2020
    Version: 0.0.0
    Keywords: module, check, report
    Notes:
    Changelog:
#>

function Get-PSInstalledModule
{
    [cmdletbinding()]
    param(
        [Parameter(ValueFromPipeline, Position = 0)]
        [string[]]$Name,
        [Parameter(Position = 1)]
        [ValidateSet('CurrentUser', 'AllUsers')]
        # [ValidateSet('CurrentUser', 'AllUsers', 'PowerShell', 'CustomPath', 'System')]
        [string[]]$Scope = 'CurrentUser'
    )
    process
    {
        $Modules = if ($Name)
        {
            Get-Module -ListAvailable -Name $Name | Get-MoreModuleInfo | Where-Object { $Scope -Contains $_.Scope }
        }
        else
        {
            Get-Module -ListAvailable | Get-MoreModuleInfo | Where-Object { $Scope -contains $_.Scope }
        }

        if ($null -ne $Modules)
        {

            foreach ($ModuleName in ($Modules | Sort-Object Name -Unique).Name)
            {
                Write-Verbose "Module: $ModuleName"
                $GroupModule = $Modules | Where-Object Name -EQ $ModuleName

                # version per scope
                foreach ($Scope in ($GroupModule | Select-Object -Unique Scope).Scope)
                {
                    $VersionPerScope = ($GroupModule | Where-Object Scope -EQ $Scope).Version | Sort-Object -Descending
                    $SpaceUsedMb = ($GroupModule | Where-Object Scope -EQ $Scope | Measure-Object -Property SpaceUsedMb -Sum).Sum
                    $Properties = 'Name', 'Version' , 'Scope', 'ModuleBase', 'SpaceUsed', 'PowerShellVersion'

                    $Object = [PSCustomObject][ordered]@{
                        PSTypeName    = 'ModuleManagerList'
                        Name          = $ModuleName
                        LatestVersion = $VersionPerScope[0]
                        Count         = ($GroupModule | Measure-Object -Property Name).Count
                        Modules       = [array]($GroupModule | Where-Object Scope -EQ $Scope | Select-Object $Properties)
                        Scope         = [string]$Scope
                        #SpaceUsed = ($GroupModule | Measure-Object -Property SpaceUsed -Sum).Sum
                        SpaceUsedMb   = $SpaceUsedMb #[Math]::Round($SpaceUsedMb, 2)
                        Description   = $GroupModule[0].Description
                        Author        = $GroupModule[0].Author
                        CompanyName   = $GroupModule[0].CompanyName
                    }
                    Write-Output $Object
                }
            }
        }
    }
}

# Get-PSInstalledModule | Select-Object Name, Versions, AllVersion, SpaceUsed, SpaceUsedMB, InstalledLocation | Sort-Object -Property SpaceUsed -Descending | Format-Table -AutoSize
# Get-PSInstalledModule | Select SpaceUsed, SpaceUsedMB, Name

# Get-PSInstalledModule | Sort-Object -Property SpaceUsed -Descending | Select-Object -First 5
# Get-PSInstalledModule
