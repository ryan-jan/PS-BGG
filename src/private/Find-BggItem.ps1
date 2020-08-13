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
        }
        $Items = (Invoke-BggApi @ReqParams).Items
        if ([int] $Items.Total -gt 0) {
            foreach ($Item in $Items.Item) {
                [BggSearchItem]::new($Item)
            }
        } else {
            Write-Warning "0 Items returned."
            $false
        }
    } catch {
        $Err = $_
        throw $Err
    }
}