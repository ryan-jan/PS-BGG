function Test-BggLogin {
    [CmdletBinding()]
    param ()

    if ($null -eq $Global:PSBG.Session) {
        throw "You are not connected to BGG! Please connect using the Connect-BGG command."
    } else {
        $true
    }
}