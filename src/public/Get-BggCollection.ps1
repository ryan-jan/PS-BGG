function Get-BggCollection {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [string] $Username = $Global:PSBG.Username
    )

    try {
        if (Test-BggLogin) {
            $Uri = "xmlapi2/collection?username=$Username&stats=1"

            $ReqParams = @{
                Uri = $Uri
            }
            $Items = (Invoke-BggApi @ReqParams).Items
            if ([int] $Items.TotalItems -gt 0) {
                foreach ($Item in $Items.Item) {
                    [BggCollectionItem]::new($Item)
                }
            }
        }
    } catch {
        $Err = $_
        throw $Err
    }
}