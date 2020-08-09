function Connect-Bgg {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [pscredential] $Credential = (Get-Credential)
    )
    
    $Body = @{
        credentials = @{
            username = $Credential.username
            password = $Credential.GetNetworkCredential().Password
        }
    }
    $LoginParams = @{
        Uri = "login/api/v1"
        Method = "POST"
        Body = ($Body | ConvertTo-Json)
        ContentType = "application/json"
    }
    $LoginRes, $Session = Invoke-BggApi @LoginParams
    if ($LoginRes.StatusCode -eq 202) {
        try {
            $Username = [regex]::Match($LoginRes.Headers."Set-Cookie", "(?=bggusername=)[^;]*")
            $Global:PSBG = @{
                Username = $Username.ToString().Split("=")[1]
                Session = $Session
            }
            $PsJob = Start-BggColJob
            $Global:PSBG.ColJobId = $PsJob.Id
            Write-Output "Connected to BGG successfully!"
        } catch {
            $Err = $_
            throw $Err
        }
    } else {
        throw "An error ocurred when attempting to login to the api."
    }
}