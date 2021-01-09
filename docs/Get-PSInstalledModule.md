---
external help file: PSModuleManager-help.xml
Module Name: PSModuleManager
online version:
schema: 2.0.0
---

# Get-PSInstalledModule

## SYNOPSIS
The function to return installed modules

## SYNTAX

```
Get-PSInstalledModule [[-Name] <String[]>] [[-Scope] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
The function return information about all modules on the host.
'Get-PSInstalledModule' default returns modules in CurrentUser scope.

Available scope: CurrentUser and AllUsers

## EXAMPLES

### EXAMPLE 1
```
Get-PSInstalledModule
```

Name                           LatestVersion        Count      Scope                SpaceUsedMb
----                           -------------        -----      -----                -----------
Az.Accounts                    2.1.0                4          CurrentUser          73,02
Az.Advisor                     1.1.1                1          CurrentUser          0,34
Az.Aks                         2.0.0                4          CurrentUser          5,06
Az.AnalysisServices            1.1.4                3          CurrentUser          1,72
Az.ApiManagement               2.1.0                3          CurrentUser          18,02
Az.ApplicationInsights         1.1.0                2          CurrentUser          1,58

### EXAMPLE 2
```
(Get-PSInstalledModule | Measure-Object -Property SpaceUsedMb -Sum) | Select Property, Sum
```

Property       Sum
--------       ---
SpaceUsedMb 780,48

### EXAMPLE 3
```
Get-PSInstalledModule PSHTML -Scope AllUsers | Select *
```

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

### EXAMPLE 4
```
Get-PSInstalledModule -Name PSReadLine
```

Name                           LatestVersion        Count      Scope                SpaceUsedMb
----                           -------------        -----      -----                -----------
PSReadLine                     2.2.0                2          CurrentUser          0,93

### EXAMPLE 5
```
Get-PSInstalledModule -Name dba*
```

Name                           LatestVersion        Count      Scope                SpaceUsedMb
----                           -------------        -----      -----                -----------
dbachecks                      2.0.3                1          CurrentUser          2,68
dbatools                       1.0.113              1          CurrentUser          99,48

### EXAMPLE 6
```
Get-PSInstalledModule -Scope AllUsers
```

Name                           LatestVersion        Count      Scope                SpaceUsedMb
----                           -------------        -----      -----                -----------
ALTools                        0.0.2                1          AllUsers             0,01
ARMHelper                      0.6.3                1          AllUsers             0,05
Azure                          5.1.2                1          AllUsers             106,33
...

### EXAMPLE 7
```
Get-PSInstalledModule PSHTML  -Scope AllUsers
```

Name                           LatestVersion        Count      Scope                SpaceUsedMb
----                           -------------        -----      -----                -----------
PSHTML                         0.8.0                2          AllUsers             1,96

### EXAMPLE 8
```
Get-PSInstalledModule | Out-GridView
```

## PARAMETERS

### -Name
{{ Fill Name Description }}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Scope
\[ValidateSet('CurrentUser', 'AllUsers', 'PowerShell', 'CustomPath', 'System')\]

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: CurrentUser
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Mateusz Nadobnik
Link: akademiapowershell.pl

Date: 15-04-2020
Version: 0.0.0
Keywords: module, check, report
Notes:
Changelog:

## RELATED LINKS
