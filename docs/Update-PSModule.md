---
external help file: PSModuleManager-help.xml
Module Name: PSModuleManager
online version:
schema: 2.0.0
---

# Update-PSModule

## SYNOPSIS
Update-PSModule function updates modules

## SYNTAX

```
Update-PSModule [-InputObject <Object>] [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The function updates PowerShell modules to the latest version.
The function requires the custom object that it is return from Get-PSInstalledModule function.

## EXAMPLES

### EXAMPLE 1
```
Get-PSInstalledModule | Uninstall-PSOlderModule -WhatIf -Verbose
```

### EXAMPLE 2
```
Get-PSInstalledModule | Uninstall-PSOlderModule -Force
```

### EXAMPLE 3
```
Get-PSInstalledModule -Name dbatools | Uninstall-PSOlderModule -Force
```

### EXAMPLE 4
```
Get-PSInstalledModule -Scope AllUsers | Update-PSModule -Force
```

### EXAMPLE 5
```
Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Force
```

### EXAMPLE 6
```
Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Force
```

### EXAMPLE 7
```
Get-PSInstalledModule | Out-GridView -OutputMode Multiple | Update-PSModule -Verbose
```

## PARAMETERS

### -InputObject
{{ Fill InputObject Description }}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Force
Forces an update of each specified module without a prompt to request confirmation.
If the module is already installed, Force reinstalls the module.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
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
Version: 0.0.1
Keywords: remove, uninstall, module
Notes:
Changelog:

Requires -RunAsAdministrator

## RELATED LINKS
