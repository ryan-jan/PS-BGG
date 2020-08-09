function Get-BggPlays {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (
        [Parameter(ParameterSetName = "Default", Mandatory = $false)]
        [Parameter(ParameterSetName = "Page", Mandatory = $false)]
        [Parameter(ParameterSetName = "All", Mandatory = $false)]
        [string] $Username = $Global:PSBGG.Username,

        [Parameter(ParameterSetName = "Default", Mandatory = $false)]
        [Parameter(ParameterSetName = "Page", Mandatory = $false)]
        [Parameter(ParameterSetName = "All", Mandatory = $false)]
        [datetime] $MinDate,

        [Parameter(ParameterSetName = "Default", Mandatory = $false)]
        [Parameter(ParameterSetName = "Page", Mandatory = $false)]
        [Parameter(ParameterSetName = "All", Mandatory = $false)]
        [datetime] $MaxDate,

        [Parameter(ParameterSetName = "Default", Mandatory = $false)]
        [Parameter(ParameterSetName = "Page", Mandatory = $false)]
        [Parameter(ParameterSetName = "All", Mandatory = $false)]
        [ValidateSet(
            "boardgame",
            "boardgameexpansion"
        )]
        [string] $Type,

        [Parameter(ParameterSetName = "Page", Mandatory = $true)]
        [Parameter(Mandatory = $false)]
        [int[]] $Page,

        [Parameter(ParameterSetName = "All", Mandatory = $true)]
        [Parameter(Mandatory = $false)]
        [switch] $All
    )

    $Uri = "xmlapi2/plays?username=$Username"
    if ($MinDate) {
        $Uri += "&mindate=$($MinDate.ToString("yyyy-MM-dd"))"
    }
    if ($MaxDate) {
        $Uri += "&maxdate=$($MaxDate.ToString("yyyy-MM-dd"))"
    }
    if ($Type) {
        $Uri += "&type=$Type"
    } else {
        $Uri += "&type=boardgame,boardgameexpansion"
    }

    if ($Page) {
        $Plays = foreach ($NextPage in $Page) {
            $ReqParams = @{
                Uri = "$Uri&page=$NextPage"
                ContentType = "application/xml"
            }
            (Invoke-BggApi @ReqParams).Plays
        }
        foreach ($Play in $Plays.Play) {
            [BggPlay]::new($Play)
        }
    } else {
        $ReqParams = @{
            Uri = $Uri
            ContentType = "application/xml"
        }
        $Plays = (Invoke-BggApi @ReqParams).Plays

        if ($All) {
            $AllPlays = $Plays.Play
            $NextPage = [int] $Plays.Page + 1
            $TotalPages = [math]::Ceiling([int] $Plays.Total / 100)
            while ($NextPage -le $TotalPages) {
                $ReqParams = @{
                    Uri = "$Uri&page=$NextPage"
                    ContentType = "application/xml"
                }
                $Plays = (Invoke-BggApi @ReqParams).Plays
                $AllPlays += $Plays.Play
                $NextPage++
            }
            foreach ($Play in $AllPlays) {
                [BggPlay]::new($Play)
            }
        } else {
            foreach ($Play in $Plays.Play) {
                [BggPlay]::new($Play)
            }
        }
    }
}