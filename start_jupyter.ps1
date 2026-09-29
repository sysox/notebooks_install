param(
    [string]$Notebook = "",
    [string]$Style = "classic"
)

# Usage: .\start_jupyter.ps1 [notebook] [classic|lab]

if ($Notebook -eq "classic" -or $Notebook -eq "lab") {
    $Style = $Notebook
    $Notebook = ""
}

if ($Style -ne "classic" -and $Style -ne "lab") {
    throw "Style must be classic or lab"
}

# Resolve relative notebook paths from the caller's current PowerShell folder.
if ($Notebook) {
    $Notebook = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Notebook)
}

Set-Location $PSScriptRoot

$Venv = ".venv"
$VenvPython = "$Venv\Scripts\python.exe"
$Marker = "$Venv\.installed"
$RequirementsHash = (Get-FileHash requirements.txt -Algorithm SHA256).Hash
$InstalledHash = ""

if (Test-Path $Marker) {
    $InstalledHash = ([string](Get-Content $Marker -Raw)).Trim()
}

if (-not (Test-Path $VenvPython)) {
    py -3 -m venv $Venv
    if ($LASTEXITCODE -ne 0) {
        throw "Could not create the virtual environment"
    }
    $InstalledHash = ""
}

if ($InstalledHash -ne $RequirementsHash) {
    & $VenvPython -m pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) {
        throw "Could not install requirements.txt"
    }

    Set-Content -Path $Marker -Value $RequirementsHash -NoNewline
}

if ($Style -eq "lab") {
    $Command = "lab"
} else {
    $Command = "nbclassic"
}

if ($Notebook) {
    & "$Venv\Scripts\jupyter.exe" $Command $Notebook
} else {
    & "$Venv\Scripts\jupyter.exe" $Command
}
