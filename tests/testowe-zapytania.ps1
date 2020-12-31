Get-PSInstalledModule -Scope AllUsers | Select-Object -ExpandProperty Modules | Select-Object Name, Scope, ModuleBase
Get-PSInstalledModule | Out-GridView
Get-MoreModuleInfo

$Scope = 'CurrentUser'

Get-Module -ListAvailable | Get-MoreModuleInfo | Where-Object { $Scope -contains $_.Scope }
Get-MMInstalledModule | Out-GridView

Get-PSInstalledModule | Out-GridView -OutputMode Multiple | Uninstall-PSOlderModule -Verbose -WhatIf
Get-mmInstalledModule -Name Az.ContainerRegistry | Uninstall-mmOlderModule -Verbose -WhatIf


Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Verbose -Force
Get-PSInstalledModule | Uninstall-PSOlderModule -Verbose

Get-mmInstalledModule | Uninstall-mmOlderModule -Verbose
Get-mmInstalledModule -Name Az.CognitiveServices  | Select-Object -ExpandProperty Modules
