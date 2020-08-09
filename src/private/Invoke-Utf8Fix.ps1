function Invoke-Utf8Fix([string] $String) {
    $Temp = New-TemporaryFile
    $String | Set-Content -Path $Temp
    $Out = Get-Content -Path $Temp -Encoding "utf8"
    Remove-Item -Path $Temp -Force -Confirm:$false
    $Out
}