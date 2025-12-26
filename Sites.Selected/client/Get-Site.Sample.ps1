# this script demonstrates working with Microsoft Graph API as a daemon app
# You'd need to specify below Application (client) ID, secret, tenant name and site: 
$orgname = "CONTOSO" # aka tenant prefix - e.g. CONTOSO in https://contoso.sharepoint.com/
$clientAppClientId = "CLIENT ID"
$clientAppClientSc = "CLIENT SECRET"
$siteUrl = "SITE URL" # e.g. "https://contoso.sharepoint.com/teams/Test-Sites-Selected"


# Authenticate to Microsoft:
$tenantName = $orgname +".onmicrosoft.com";
$tenantDomain = $orgname +".sharepoint.com";
$sitePath = $siteUrl.Split("/")[3] + '/' + $siteUrl.Split("/")[4]
$ReqTokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    client_Id     = $clientAppClientId
    Client_Secret = $clientAppClientSc
} 
$TokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody
$AccessToken = $TokenResponse.access_token
$headers = @{Authorization = "Bearer $AccessToken" }

# Get SharePoint site with MS Graph API: 
$apiUrl = 'https://graph.microsoft.com/v1.0/sites/' + $tenantDomain + ':/' + $sitePath + '?$select=id,displayName'
$spoResult = Invoke-RestMethod -Headers $Headers -Uri  $apiUrl -Method Get 
Write-Host "Site: " $spoResult.displayName


# get target site list
$targetSiteId = ""
$targetSiteListId = ""
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists/$targetSiteListId"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$list = $response
$list | Format-Table id, name

# get target site list items
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists/$targetSiteListId/items"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$response.value | Format-Table id
$response.value[0]


# get target site list item
$targetSiteListItemId = $response.value[0].id
$targetSiteListItemId = "2"
$targetSiteListItemId = "1"
$apiUrl = "https://graph.microsoft.com/v1.0/sites/$targetSiteId/lists/$targetSiteListId/items/$targetSiteListItemId"
$apiUrl 
$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$response | Format-List 


