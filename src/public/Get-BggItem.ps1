function Get-BggItem {
    [CmdletBinding(DefaultParameterSetName = "ByName")]
    param (
        [Parameter(ParameterSetName = "ById", Mandatory = $true, ValueFromPipelineByPropertyName = "Id")]
        [int[]] $Id,

        [Parameter(ParameterSetName = "ByName", Mandatory = $true)]
        [string] $Name,

        [Parameter(ParameterSetName = "ByName", Mandatory = $false)]
        [switch] $ExactMatch,

        [Parameter(ParameterSetName = "ById", Mandatory = $false)]
        [Parameter(ParameterSetName = "ByName", Mandatory = $false)]
        [ValidateSet(
            "boardgame",
            "boardgameexpansion"
        )]
        [string[]] $Type
    )

    try {
        if (Test-BggLogin) {
            $PsbgDir = Join-Path -Path $env:USERPROFILE -ChildPath ".psbg"
            $CollPath = Join-Path -Path $PsbgDir -ChildPath "collection.xml"
            if (Test-Path -Path $CollPath) {
                $Coll = Import-Clixml -Path $CollPath
            }

            if ($PSCmdlet.ParameterSetName -eq "ById") {
                $Uri = "xmlapi2/thing?id=$($Id -join ",")&stats=1"
                $ReqParams = @{
                    Uri = $Uri
                }
                $Items = (Invoke-BggApi @ReqParams).Items.Item
                foreach ($Item in $Items) {
                    if ($Coll) {
                        [BggThingItemExt]::new($Item, $Coll)
                    } else {
                        [BggThingItem]::new($Item)
                    }
                }
            } elseif ($PSCmdlet.ParameterSetName -eq "ByName") {
                $SearchParams = @{
                    Search = [System.Web.HttpUtility]::UrlEncode($Name)
                }
                $Params = @{}
                if ($ExactMatch) {
                    $SearchParams.ExactMatch = $true
                }
                if ($Type) {
                    $SearchParams.Type = $Type
                    $Params.Type = $Type
                }
                $SearchRes = Find-BggItem @SearchParams
                if ($SearchRes) {
                    Get-BggItem -Id $SearchRes.Id @Params
                }
            }
        }
    } catch {
        $Err = $_
        throw $Err
    }
}