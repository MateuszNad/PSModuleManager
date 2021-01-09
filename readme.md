<p align="left">
  <img src="https://github.com/MateuszNad/PSModuleManager/workflows/Publish%20PowerShell%20module/badge.svg"/>
  <a href="https://www.powershellgallery.com/packages/PSModuleManager"><img src="https://img.shields.io/powershellgallery/v/PSModuleManager.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSModuleManager"><img src="https://img.shields.io/powershellgallery/p/PSModuleManager.svg"></a>
  <a href="https://akademiapowershell.pl"><img src="https://img.shields.io/badge/Blog-AkademiaPowerShell-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/mnadobnik/"><img src="https://img.shields.io/badge/LinkedIn-mnadobnik-0077B5.svg?logo=LinkedIn"></a>
<a href="https://twitter.com/MateuszNadobnik"><img src="https://img.shields.io/twitter/follow/MateuszNadobnik.svg?label=Twitter%20%40MateuszNadobnik&style=social"></a>
</p>

# PSModuleManager - PowerShell Module

PSModuleManager it's the module for **managing PowerShell modules on your machine**. The module is based on native cmdlets like Get-Module, Update-Module, and Uninstall-Module.

PSModuleManager provides 3 functions that help you get a list of modules depends on a scope (CurrentUser or AllUsers), removing older versions, and updating to the latest versions in a fast way.

>⚠️ The module requires administrator permission

## Get-PSInstalledModule

The function returns information about available modules on your machine (similar to Get-Module and Get-InstalledModule). Default it will be modules from CurrentScope scope (and consistent with running PowerShell version).

A whole object that it's returned:

```ps
Get-PSInstalledModule -Name dbatools  | Select-Object *

# Name          : Az
# LatestVersion : 5.3.0
# Count         : 1
# Modules       : {@{Name=Az; Version=5.3.0; Scope=AllUsers; ModuleBase=C:\Program Files\PowerShell\Modules\Az\5.3.0; SpaceUsed=43563; PowerShellVersion=5.1}}
# Scope         : AllUsers
# SpaceUsedMb   : 0,04
# Description   : Microsoft Azure PowerShell - Cmdlets to manage resources in Azure. This module is compatible with WindowsPowerShell and PowerShell Core. For more information about the Az module, please visit the following: https://docs.microsoft.com/en-us/powershell/azure/
# Author        : Microsoft Corporation
# CompanyName   : Microsoft Corporation
```

### Examples

You can get information about all modules on your machine (example for Windows PowerShell if the command will be running there)

```ps
# default CurrentUser scope
Get-PSInstalledModule

# the command for AllUsers scope
Get-PSInstalledModule -Scope AllUsers
```

![Get-PSInstalledModule](https://akademiapowershell.pl/wp-content/uploads/2021/01/image.png)

You can get information about one a module.

```ps
Get-PSInstalledModule -Name dbatools

# a parameter -Name supports wildcards
Get-PSInstalledModule -Name dba*
```

You can get information about how many space use for installed modules

```ps
# CurrentUser scope
Get-PSInstalledModule | Measure-Object -Property SpaceUsedMb -Sum

# AllUsers scope
Get-PSInstalledModule -Scope AllUsers | Measure-Object -Property SpaceUsedMb -Sum
```

Other examples

```ps
Get-PSInstalledModule | Sort-Object -Property SpaceusedMb -Descending | Select -First 5

Get-PSInstalledModule -Scope AllUsers | Sort-Object -Property SpaceusedMb -Descending | Select -First 5

Get-PSInstalledModule | Sort-Object -Property Count -Descending | Select -First 5

Get-PSInstalledModule -Scope AllUsers | Sort-Object -Property Count -Descending | Select -First 5
```

## Update-PSModule

The command wraps Update-Module cmdlet. Update-PSModule needs a ModuleManagerList object from Get-PSIntalledModule.

```ps
# updating all modules for CurrentUser scope
Get-PSInstalledModule | Update-PSModule -Force
```

![Update-PSModule](https://akademiapowershell.pl/wp-content/uploads/2021/01/image-1.png)

### Examples

```ps
# the command supports -WhatIf switch
Get-PSInstalledModule -Name dbatools -Scope AllUsers | Update-PSModule -WhatIf

# updating all modules for AllUsers scope
Get-PSInstalledModule -Scope AllUsers | Update-PSModule -Verbose -Force

# updating Az.Accounts module
Get-PSInstalledModule -Name Az.Accounts | Update-PSModule -Force

# updating modules matching regular expression
Get-PSInstalledModule -Name az* | Update-PSModule -Force
```

## Uninstal-PSOlderModule

The command wraps the Uninstall-Module cmdlet. UninstalPSOlderModule needs an object ModuleManagerList from Get-PSIntalledModule and uninstalls all older versions.

```ps
# removing old versions for modules in the scope of CurrentUser
Get-PSInstalledModule | Uninstall-PSOlderModule
```

### Examples

```ps
# you can use -WhatIf switch
Get-PSInstalledModule -Scope AllUsers | Uninstall-PSOlderModule -Verbose -WhatIf

Get-PSInstalledModule -Name dbatools -Scope AllUsers | Uninstall-PSOlderModule -Verbose -WhatIf

# removing older versions Az.Accounts module
Get-PSInstalledModule -Name Az.Accounts | Uninstall-PSOlderModule

# removing older versions for modules in the scope of AllUsers
Get-PSInstalledModule -Scope AllUsers | Uninstall-PSOlderModule

# removing older versions for the selected module in AllUser scope
Get-PSInstalledModule -Name dbatools -Scope AllUsers | Uninstall-PSOlderModule -Verbose
```

# Installation

## Install from PSGallery

```ps
Install-Module -Name PSParseHTML -AllowClobber -Force
```

## Update from PSGallery

```ps
Update-Module -Name PSParseHTML
```
