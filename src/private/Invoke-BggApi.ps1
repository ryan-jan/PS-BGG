function Invoke-BggApi {
    [CmdletBinding()]
    param (
        [string] $Uri,

        [string] $Method = "GET",

        $Body,

        [string] $ContentType = "text/xml"
    )

    $BaseUri = "https://boardgamegeek.com/"

    try {
        $ProgPref = $ProgressPreference
        $ProgressPreference = "SilentlyContinue"
        $Params = @{
            Uri = $BaseUri + $Uri
            Method = $Method
            ContentType = "$ContentType; charset=utf-8"
            Headers = @{Accept = $ContentType}
            UseBasicParsing = $true
            OutFile = $Temp
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
                $Params.WebSession = $Global:PSBG.Session
            }
            if ($Body) {
                $Params.Body = $Body
            }
            $Res = Invoke-WebRequest @Params
            if ($ContentType -eq "text/xml") {
                if ($Res.StatusCode -eq 200) {
                    [xml] (Invoke-Utf8Fix -String $Res.Content)
                } elseif ($Res.StatusCode -eq 202) {
                    Write-Host "The BoardGameGeek API has queued this request. Please wait." -NoNewline
                    while ($Res.StatusCode -eq 202) {
                        Start-Sleep -Seconds 5
                        Write-Host "." -NoNewline
                        try {
                            $Res = Invoke-WebRequest @Params
                        } catch {
                            $Err = $_
                            if ($Err.Exception.Message -like "*Rate limit exceeded.*") {
                                Start-Sleep -Seconds 10
                            } else {
                                throw $Err
                            }
                        }
                    }
                    if ($Res.StatusCode -eq 200) {
                        [xml] (Invoke-Utf8Fix -String $Res.Content)
                    } else {
                        throw $Res.StatusCode
                    }
                } else {
                    throw $Res.StatusCode
                }
            } else {
                if ($Res.StatusCode -eq 200) {
                    (Invoke-Utf8Fix -String $Res.Content) | ConvertFrom-Json
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