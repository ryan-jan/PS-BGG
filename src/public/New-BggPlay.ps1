function New-BggPlay {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [BggThingItem] $Item,

        [Parameter(Mandatory = $false)]
        [int] $Quantity = 1,

        [Parameter(Mandatory = $false)]
        [string] $Location,

        [Parameter(Mandatory = $false)]
        [datetime] $Date = (Get-Date),

        [Parameter(Mandatory = $false)]
        [string] $Comment,

        [Parameter(Mandatory = $false)]
        [int] $Length,

        [Parameter(Mandatory = $false)]
        [bool] $Incomplete = $false,

        [Parameter(Mandatory = $false)]
        [bool] $NoWinStats = $false,

        [Parameter(Mandatory = $false)]
        [hashtable[]] $Players
    )

    try {
        if (Test-BggLogin) {
            $Play = [BggPlay]::new()
            $Play.Item = $Item
            $Play.Quantity = $Quantity
            if ($Location) {
                $Play.Location = $Location
            }
            $Play.Date = $Date
            if ($Comment) {
                $Play.Comment = $Comment
            }
            if ($Length) {
                $Play.Length = $Length
            }
            $Play.Incomplete = $Incomplete
            $Play.NoWinStats = $NoWinStats
            if ($Players) {
                $Play.Players = $Players.ForEach({
                    [BggPlayer]::new($_)
                })
            }
            
            $ReqParams = @{
                Uri = "geekplay.php"
                ContentType = "application/json"
                Method = "POST"
                Body = $Play.NewPlayJson()
            }
            $NewPlay = Invoke-BggApi @ReqParams
            if ($null -eq $NewPlay.PlayId) {
                throw $NewPlay
            }
        }
    } catch {
        $Err = $_
        throw $Err
    }
}