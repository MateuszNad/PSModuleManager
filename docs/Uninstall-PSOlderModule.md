---
external help file: PSModuleManager-help.xml
Module Name: PSModuleManager
online version:
schema: 2.0.0
---

# Uninstall-PSOlderModule

## SYNOPSIS
Uninstall-PSOlderModule function removes old modules.

## SYNTAX

```
Uninstall-PSOlderModule [-InputObject <Object>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Default all modules version is removed except the latest.
The function requires the custom object that it is return from Get-PSInstalledModule function.

## EXAMPLES

### EXAMPLE 1
```
Get-PSInstalledModule | Uninstall-PSOlderModule -Verbose -WhatIf
```

### EXAMPLE 2
```
Get-PSInstalledModule | Uninstall-PSOlderModule -Verbose
```

### EXAMPLE 3
```
Get-PSInstalledModule -Name dba* -Scope AllUsers | Update-PSModule -Verbose -Force
```

### EXAMPLE 4
```
Get-PSInstalledModule -Name dba* | Uninstall-PSOlderModule -Verbose
```

### EXAMPLE 5
```
Get-PSInstalledModule | Out-GridView -OutputMode Multiple | Uninstall-PSOlderModule -Verbose
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
