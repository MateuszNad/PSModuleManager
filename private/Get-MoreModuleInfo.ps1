function Get-MoreModuleInfo
{
    [cmdletbinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $InputObject
    )
    begin
    {
        # $script:ProgramFilesModulesPath
        # $script:MyDocumentsModulesPath
        # $script:PowerShellModulesPath
    }
    process
    {
        try
        {
            $Scope, $PSModulePath = if ($InputObject.ModuleBase -like "$script:ProgramFilesModulesPath*")
            {
                'AllUsers', $script:ProgramFilesModulesPath
            }
            elseif ($InputObject.ModuleBase -like "$script:MyDocumentsModulesPath*")
            {
                'CurrentUser', $script:MyDocumentsModulesPath
            }
            # elseif ($InputObject.ModuleBase -like "$script:PowerShellModulesPath*")
            # {
            #     'PowerShell', $script:PowerShellModulesPath
            # }
            elseif ($InputObject.ModuleBase -like "$script:SystemModulesPath*")
            {
                'System', $script:SystemModulesPath
            }
            else
            {
                'CustomPath', $InputObject.ModuleBase
            }

            Write-Verbose "$InputObject, $($InputObject.ModuleBase),  $Scope, $PSModulePath"

            $SpaceUsed = (Get-ChildItem -Recurse -File -Path $InputObject.ModuleBase -ErrorAction Stop | Measure-Object -Property  Length -Sum).Sum
            $InputObject | Add-Member -Name Scope -Value $Scope -MemberType NoteProperty
            $InputObject | Add-Member -Name LowerName -Value ($InputObject.Name).ToLower() -MemberType NoteProperty
            $InputObject | Add-Member -Name SpaceUsed -Value $SpaceUsed -MemberType NoteProperty
            $InputObject | Add-Member -Name SpaceUsedMb -Value { [Math]::Round(($this.SpaceUsed / 1MB), 2) } -MemberType ScriptProperty
            $InputObject | Add-Member -Name PSModulePath -Value $PSModulePath -MemberType NoteProperty
            $InputObject.PSTypeNames.Insert(0, 'ModuleInfoGroupingPlus')

            $DefaultProperties = 'Version', 'Name', 'Scope', 'SpaceUsed', 'Description'
            Update-TypeData -TypeName 'ModuleInfoGroupingPlus' -DefaultDisplayPropertySet $DefaultProperties -Force

            Write-Output $InputObject
        }
        catch
        {
            Write-Warning "$_"
        }
    }
}
