clear
# Application (client) ID, secret, tenant name and site 
# $tenantPrefix = "CONTOSO"; #Pass 'Contoso' for contoso.onmicrosoft.com
# $clientAppId = "CLIENT ID"; #Pass the azure ad app id here
# $clientAppSecret = "CLIENT SECRET"; #Pass the azure ad app client secret
# $tenantName = $tenantPrefix +".onmicrosoft.com";
# $tenantDomain = $tenantPrefix +".sharepoint.com";

#$sitePath = ""
$siteName = $sitePath.Split("/")[3] + '/' + $sitePath.Split("/")[4]

$resource = "https://graph.microsoft.com/"
$ReqTokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $clientAppId
    Client_Secret = $clientAppSecret
} 
try {
    $TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody
    $AccessToken = $TokenResponse.access_token
}
catch {
    Write-Output "Failed to connect to the site"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    #Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
    Exit 
}

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/' + $siteName + '?$select=id,displayName'
try {
    $spoResult = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri  $apiUrl -Method Get 
    Write-Host "Site: " $spoResult.displayName
}
catch {
    Write-Output "Failed to enumerate the site"
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    #Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
    Exit 
}    

$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $spoResult.id + '/lists?$select=displayName'
try {
    $spoData = Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Method Get -ContentType "text/plain" -ResponseHeadersVariable spoRespHeaders
    $spoData.Value | FT
}
catch {
    Write-Output "Failed to get site lists..."
    Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ 
    Write-Host "StatusDescription:" $_.Exception.Response.StatusDescription 
}

