function Invoke-BggApi {
    [CmdletBinding()]
    param (
        [string] $Uri,

        [string] $Method = "GET",

        $Body,

        [string] $ContentType = "application/xml"
    )

    $BaseUri = "https://boardgamegeek.com/"

    try {
        $ProgPref = $ProgressPreference
        $ProgressPreference = "SilentlyContinue"
        $Params = @{
            Uri = $BaseUri + $Uri
            Method = $Method
            ContentType = $ContentType
            UseBasicParsing = $true
        }        

        if ($Uri -eq "login/api/v1") {
            $Params.Body = $Body
            $Params.SessionVariable = "Session"
            $Res = Invoke-WebRequest @Params
            if ($Res.StatusCode -eq 202) {
                $Res, $Session
            } else {
                throw $Res.StatusCode
            }
        } else {
            if ($Method -eq "POST") {
                if ($null -ne $Global:PSBGG.Session) {
                    $Params.WebSession = $Global:PSBGG.Session
                } else {
                    throw "You are not connected to BGG! Please connect using the Connect-BGG command."
                }
            }
            if ($Body) {
                $Params.Body = $Body
            }
            $Res = Invoke-WebRequest @Params
            if ($ContentType -eq "application/xml") {
                if ($Res.StatusCode -eq 200) {
                    [xml] $Res.Content
                } else {
                    throw $Res.StatusCode
                }
            } else {
                if ($Res.StatusCode -eq 200) {
                    $Res
                } else {
                    throw $Res.StatusCode
                }
            }
        }
        $ProgressPreference = $ProgPref
    } catch {
        $Err = $_
        throw $Err
    }
}