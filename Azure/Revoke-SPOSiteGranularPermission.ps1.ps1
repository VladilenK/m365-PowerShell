# https://gist.github.com/svarukala
#Provie tenant prefix, Application (client) ID, and client secret of the IT admin app
#IT admin app must have sites.fullcontrol app-only perms
# $tenantPrefix = "Contoso";
# $clientId = "Client-Id";
# $clientSecret = "Client-Secret";
# $tenantName = $tenantPrefix + ".onmicrosoft.com"; 
# $tenantDomain = $tenantPrefix + ".sharepoint.com";

#Site url 
# $sitePath = ""
#Leave this empty to delete all granular perms or provide specific app id
$clientAppId = "" #Example: "986f9573-cfcc-4444-b86a-99f9997c3edc"
#$clientAppId = "6cea34ae-ee32-4283-882e-0b2618a8c3bb"

$siteName = $sitePath.Split("/")[4]

$resource = "https://graph.microsoft.com/"
$ReqTokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $clientID
    Client_Secret = $clientSecret
} 
$TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/sites/' + $siteName + '?$select=id,displayName'
try {
    $spoResult = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri  $apiUrl -Method Get 
    Write-Host "Site:" $spoResult.displayName
}
catch {
    Write-Output "Failed to enumerate the site"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
    Exit
}    

$baseApiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $spoResult.id + '/permissions/'

try {
    $spoData = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $baseApiUrl -Method Get
    if ($spoData.value.length -eq 0) {
        Write-Host "No site level permissions found"
    }
    else {
        $spoData.value | % { 
            if (($clientAppId.Trim().Length -ne 0) -and ($clientAppId -eq $_.grantedToIdentities.application.id)) {
                #Delete only the requested app perm
                $apiUrl = $baseApiUrl + $_.id
                Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Method Delete
                Write-Host "Deleted permission id: " $_.id
            }
            elseif ($clientAppId.Trim().Length -eq 0) {
                #Delete all perms
                $apiUrl = $baseApiUrl + $_.id
                Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Method Delete
                Write-Host "Deleted permission id: " $_.id
            }
        }
    }
}
catch {
    Write-Output "Failed to add permissions the site"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
}