# Get public function definition files and dot source them
$ClassesPath = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath "classes") -ChildPath "*.ps1"
$PublicPath = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath "public") -ChildPath "*.ps1"
$PrivatePath = Join-Path -Path (Join-Path -Path $PSScriptRoot -ChildPath "private") -ChildPath "*.ps1"
$Classes = @(Get-ChildItem -Path $ClassesPath)
$Public = @(Get-ChildItem -Path $PublicPath)
$Private = @(Get-ChildItem -Path $PrivatePath)

foreach ($Module in ($Classes + $Public + $Private)) {
    try {
        . $Module.FullName
    } catch {
        Write-Error -Message "Failed to import function $($Module.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName

$PSBG = (Join-Path -Path $HOME -ChildPath ".psbg")
if (-not (Test-Path -Path $PSBG)) {
    New-Item -Path $PSBG -ItemType "Directory"
}