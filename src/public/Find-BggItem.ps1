function Find-BggItem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Search,

        [Parameter(Mandatory = $false)]
        [ValidateSet(
            "boardgame",
            "boardgameexpansion"
        )]
        [string[]] $Type = @("boardgame", "boardgameexpansion"),

        [Parameter(Mandatory = $false)]
        [switch] $ExactMatch
    )

    try {
        $Uri = "xmlapi2/search?query=$Search&type=$($Type -join ',')"
        if ($ExactMatch) {
            $Uri += "&exact=1"
        }
        $ReqParams = @{
            Uri = $Uri
            ContentType = "application/xml"
        }
        $Items = (Invoke-BggApi @ReqParams).Items.Item
        foreach ($Item in $Items) {
            [BggSearchItem]::new($Item)
        }
    } catch {
        $Err = $_
        throw $Err
    }
}