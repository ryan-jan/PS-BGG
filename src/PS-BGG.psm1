# Get public function definition files and dot source them
$Classes = @(Get-ChildItem -Path $PSScriptRoot\classes\*.ps1)
$Public = @(Get-ChildItem -Path $PSScriptRoot\public\*.ps1)
$Private = @(Get-ChildItem -Path $PSScriptRoot\private\*.ps1)

foreach ($Module in ($Classes + $Public + $Private)) {
    try {
        . $Module.FullName
    } catch {
        Write-Error -Message "Failed to import function $($Module.FullName): $_"
    }
}

Export-ModuleMember -Function $Public.BaseName