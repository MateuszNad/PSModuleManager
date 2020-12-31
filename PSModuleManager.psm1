# # script:variable
# $script:PSModuleRoot = $PSScriptRoot
# $script:LibraryPath = Join-Path -Path $script:PSModuleRoot -ChildPath 'lib'
# $script:BinaryPath = Join-Path -Path $script:PSModuleRoot -ChildPath 'bin'
# $script:DataPath = Join-Path -Path $script:PSModuleRoot -ChildPath 'data'
# $script:ClassPath = Join-Path -Path $script:PSModuleRoot -ChildPath 'class'

# # load function
# Get-ChildItem "$PSScriptRoot\public\*.ps1" | ForEach-Object {
#     . $_.FullName
# }

# Get-ChildItem "$PSScriptRoot\private\*.ps1" | ForEach-Object {
#     . $_.FullName
# }

# script:variable
$script:PSModuleRoot = $PSScriptRoot
$script:FormatXml = Join-Path -Path $script:PSModuleRoot -ChildPath 'PSModuleManager.Format.ps1xml'
Update-FormatData -PrependPath $script:FormatXml

Microsoft.PowerShell.Core\Set-StrictMode -Version Latest

#region script variables
$script:IsInbox = $PSHOME.EndsWith('\WindowsPowerShell\v1.0', [System.StringComparison]::OrdinalIgnoreCase)
$script:IsWindows = (-not (Get-Variable -Name IsWindows -ErrorAction Ignore)) -or $IsWindows
$script:IsLinux = (Get-Variable -Name IsLinux -ErrorAction Ignore) -and $IsLinux
$script:IsMacOS = (Get-Variable -Name IsMacOS -ErrorAction Ignore) -and $IsMacOS
$script:IsCoreCLR = $PSVersionTable.ContainsKey('PSEdition') -and $PSVersionTable.PSEdition -eq 'Core'
$script:IsNanoServer = & {
    if (!$script:IsWindows)
    {
        return $false
    }

    $serverLevelsPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Server\ServerLevels\'
    if (Test-Path -Path $serverLevelsPath)
    {
        $NanoItem = Get-ItemProperty -Name NanoServer -Path $serverLevelsPath -ErrorAction Ignore
        if ($NanoItem -and ($NanoItem.NanoServer -eq 1))
        {
            return $true
        }
    }
    return $false
}

if ($script:IsInbox)
{
    $script:ProgramFilesPSPath = Microsoft.PowerShell.Management\Join-Path -Path $env:ProgramFiles -ChildPath "WindowsPowerShell"
}
elseif ($script:IsCoreCLR)
{
    if ($script:IsWindows)
    {
        $script:ProgramFilesPSPath = Microsoft.PowerShell.Management\Join-Path -Path $env:ProgramFiles -ChildPath 'PowerShell'
    }
    else
    {
        $script:ProgramFilesPSPath = Microsoft.PowerShell.Management\Split-Path -Path ([System.Management.Automation.Platform]::SelectProductNameForDirectory('SHARED_MODULES')) -Parent
    }
}

try
{
    $script:MyDocumentsFolderPath = [Environment]::GetFolderPath("MyDocuments")
}
catch
{
    $script:MyDocumentsFolderPath = $null
}

if ($script:IsInbox)
{
    $script:MyDocumentsPSPath = if ($script:MyDocumentsFolderPath)
    {
        Microsoft.PowerShell.Management\Join-Path -Path $script:MyDocumentsFolderPath -ChildPath "WindowsPowerShell"
    }
    else
    {
        Microsoft.PowerShell.Management\Join-Path -Path $env:USERPROFILE -ChildPath "Documents\WindowsPowerShell"
    }
}
elseif ($script:IsCoreCLR)
{
    if ($script:IsWindows)
    {
        $script:MyDocumentsPSPath = if ($script:MyDocumentsFolderPath)
        {
            Microsoft.PowerShell.Management\Join-Path -Path $script:MyDocumentsFolderPath -ChildPath 'PowerShell'
        }
        else
        {
            Microsoft.PowerShell.Management\Join-Path -Path $HOME -ChildPath "Documents\PowerShell"
        }
    }
    else
    {
        $script:MyDocumentsPSPath = Microsoft.PowerShell.Management\Split-Path -Path ([System.Management.Automation.Platform]::SelectProductNameForDirectory('USER_MODULES')) -Parent
    }
}



$script:ProgramFilesModulesPath = Microsoft.PowerShell.Management\Join-Path -Path $script:ProgramFilesPSPath -ChildPath 'Modules'
$script:MyDocumentsModulesPath = Microsoft.PowerShell.Management\Join-Path -Path $script:MyDocumentsPSPath -ChildPath 'Modules'
$script:PowerShellModulesPath = Microsoft.PowerShell.Management\Join-Path -Path $PSHOME -ChildPath 'Modules'
$script:SystemModulesPath = if ($script:IsInbox)
{
    Microsoft.PowerShell.Management\Join-Path  -Path $PSHOME -ChildPath 'Modules'
}
elseif ($script:IsCoreCLR)
{
    Microsoft.PowerShell.Management\Join-Path  -Path $PSHOME -ChildPath 'Modules'
}

# load function
Get-ChildItem "$PSScriptRoot\public\*.ps1" | ForEach-Object {
    . $_.FullName
}

Get-ChildItem "$PSScriptRoot\private\*.ps1" | ForEach-Object {
    . $_.FullName
}
