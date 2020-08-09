function Remove-BggPlay {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [BggPlay] $Play
    )

    try {
        if (Test-BggLogin) {
            $ReqParams = @{
                Uri = "geekplay.php"
                ContentType = "application/json"
                Method = "POST"
                Body = @{
                    playid = $Play.Id
                    ajax = 1
                    finalize = 1
                    action = "delete"
                } | ConvertTo-Json
            }
            $RemPlay = Invoke-BggApi @ReqParams
            if ($true -ne $RemPlay.Success) {
                throw "An error ocurred when attemting to delete Play with Id $($Play.Id)"
            }
        }
    } catch {
        $Err = $_
        throw $Err
    }
}