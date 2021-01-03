<#
.Synopsis
    Update-PSModule function updates modules

.DESCRIPTION
    The function updates PowerShell modules to the latest version.
    The function requires the custom object that it is return from Get-PSInstalledModule function.

.EXAMPLE
    PS C:\> Get-PSInstalledModule | Uninstall-PSOlderModule -WhatIf -Verbose

.EXAMPLE
    PS C:\> Get-PSInstalledModule | Uninstall-PSOlderModule -Force

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name dbatools | Uninstall-PSOlderModule -Force

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Scope AllUsers | Update-PSModule -Force

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Force

.EXAMPLE
    PS C:\> Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Force

.EXAMPLE
    PS C:\> Get-PSInstalledModule | Out-GridView -OutputMode Multiple | Update-PSModule -Verbose

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
function Update-PSModule
{
    [cmdletbinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(ValueFromPipeline, ParameterSetName = 'InputObject')]
        [PSTypeName('ModuleManagerList')]$InputObject,
        # Forces an update of each specified module without a prompt to request confirmation. If the module is already installed, Force reinstalls the module.
        [switch]$Force = $false
    )
    begin
    {
        $IsForce = if ($Force.IsPresent)
        {
            $true
        }
    }
    process
    {
        foreach ($Item in $InputObject)
        {
            $Name = $Item.Name
            $Scope = $Item.Scope

            if ($Scope -eq 'System')
            {
                Write-Warning "Update the module of scope 'System' is not supported"
                return
            }
            Write-Verbose "Find the new version '$Name' module and install to '$Scope' scope"
            $NewVersionModule = Find-Module -Name $Name
            if ($null -ne $NewVersionModule)
            {
                if ($PSCmdlet.ShouldProcess("Version '$($NewVersionModule.Version)' of module '$($NewVersionModule.Name)'"))
                {
                    $NewVersionModule | Update-Module -Scope $Scope -Force:$IsForce
                }
            }
        }
    }
}
