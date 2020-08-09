function Get-BggPlay {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (
        [Parameter(ParameterSetName = "Default", Mandatory = $false)]
        [Parameter(ParameterSetName = "Page", Mandatory = $false)]
        [Parameter(ParameterSetName = "All", Mandatory = $false)]
        [string] $Username = $Global:PSBG.Username,

        [Parameter(ParameterSetName = "Default", Mandatory = $false, ValueFromPipelineByPropertyName = "Id")]
        [Parameter(ParameterSetName = "Page", Mandatory = $false, ValueFromPipelineByPropertyName = "Id")]
        [Parameter(ParameterSetName = "All", Mandatory = $false, ValueFromPipelineByPropertyName = "Id")]
        [int] $Id,

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
        [string] $SubType,

        [Parameter(ParameterSetName = "Page", Mandatory = $true)]
        [Parameter(Mandatory = $false)]
        [int[]] $Page,

        [Parameter(ParameterSetName = "All", Mandatory = $true)]
        [Parameter(Mandatory = $false)]
        [switch] $All
    )

    try {
        if (Test-BggLogin) {
            $Uri = "xmlapi2/plays?username=$Username"
            if ($Id) {
                $Uri += "&id=$Id"
            }
            if ($MinDate) {
                $Uri += "&mindate=$($MinDate.ToString("yyyy-MM-dd"))"
            }
            if ($MaxDate) {
                $Uri += "&maxdate=$($MaxDate.ToString("yyyy-MM-dd"))"
            }
            if ($SubType) {
                $Uri += "&subtype=$SubType"
            } else {
                $Uri += "&subtype=boardgame"
            }

            if ($Page) {
                $Plays = foreach ($NextPage in $Page) {
                    $ReqParams = @{
                        Uri = "$Uri&page=$NextPage"
                    }
                    (Invoke-BggApi @ReqParams).Plays
                }
                foreach ($Play in $Plays.Play) {
                    [BggPlay]::new($Play)
                }
            } else {
                $ReqParams = @{
                    Uri = $Uri
                }
                $Plays = (Invoke-BggApi @ReqParams).Plays

                if ($All) {
                    $AllPlays = $Plays.Play
                    $NextPage = [int] $Plays.Page + 1
                    $TotalPages = [math]::Ceiling([int] $Plays.Total / 100)
                    while ($NextPage -le $TotalPages) {
                        $ReqParams = @{
                            Uri = "$Uri&page=$NextPage"
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
    } catch {
        $Err = $_
        throw $Err
    }
}