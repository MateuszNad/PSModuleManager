<#
.Synopsis
    Uninstall-PSOlderModule function removes old modules.

.DESCRIPTION
    Default all modules version is removed except the latest.
    The function requires the custom object that it is return from Get-PSInstalledModule function.

.EXAMPLE
    PS C:\> Get-PSInstalledModule | Uninstall-PSOlderModule -Verbose -WhatIf

.EXAMPLE
   PS C:\>  Get-PSInstalledModule | Uninstall-PSOlderModule -Verbose

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Verbose -Force

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name dba* | Uninstall-PSOlderModule -Verbose

.EXAMPLE
    PS C:\> Get-PSInstalledModule | Out-GridView -OutputMode Multiple | Uninstall-PSOlderModule -Verbose

.NOTES
    Author: Mateusz Nadobnik
    Link: akademiapowershell.pl

    Date: 15-04-2020
    Version: 0.0.1
    Keywords: remove, uninstall, module
    Notes:
    Changelog:
#>
#Requires -RunAsAdministrator
function Uninstall-PSOlderModule
{
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(ValueFromPipeline, ParameterSetName = 'InputObject')]
        [PSTypeName('ModuleManagerList')]$InputObject
    )
    begin
    {
        # $LeaveAmountOfVersion = 1
    }
    process
    {
        # Write-Output $InputObject
        foreach ($Item in $InputObject)
        {
            $Versions = $Item.Modules.Version
            $Name = $Item.Modules.Name
            Write-Verbose "All existing versions of the $Name module: $Versions"

            try
            {
                if (($Versions | Measure-Object).Count -ge 2)
                {
                    $Count = $Versions.Count - 1
                    # $VersionsToRemove = $Versions[$LeaveAmountOfVersion..($Count)]
                    $VersionsToRemove = $Versions[1..($Count)]

                    foreach ($Version in $VersionsToRemove)
                    {
                        if ($PSCmdlet.ShouldProcess("Version '$Version' of module '$($Item.Name)'"))
                        {
                            # Get-InstalledModule -RequiredVersion $Version -Name $Item.Name
                            # Forces to run without asking for user confirmation
                            Get-InstalledModule -RequiredVersion $Version -Name $Item.Name | Uninstall-Module -Verbose:$VerbosePreference -Force
                        }

                    }
                }
            }
            catch
            {
                $Message = $_
                Write-Warning $Message
            }

        }
    }
}
