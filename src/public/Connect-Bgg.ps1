function Connect-BGG {
    [CmdletBinding()]
    param (
        [pscredential] $Credential
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
            $Global:PSBGG = @{
                Username = $Username.ToString().Split("=")[1]
                Session = $Session
            }
            Write-Output "Connected to BGG successfully!"
        } catch {
            $Err = $_
            throw $Err
        }
    } else {
        throw "An error ocurred when attempting to login to the api."
    }
}