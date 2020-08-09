function Get-BggItem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = "Id")]
        [int[]] $Id,

        [Parameter(Mandatory = $false)]
        [ValidateSet(
            "boardgame",
            "boardgameexpansion"
        )]
        [string[]] $Type
    )

    try {
        $Uri = "xmlapi2/thing?id=$($Id -join ",")"
        $ReqParams = @{
            Uri = $Uri
            ContentType = "application/xml"
        }
        $Items = (Invoke-BggApi @ReqParams).Items.Item
        foreach ($Item in $Items) {
            [BggThingItem]::new($Item)
        }
    } catch {
        $Err = $_
        throw $Err
    }
}