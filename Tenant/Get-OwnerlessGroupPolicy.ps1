$clientId = ""
$loginUPN = ""
Connect-ExchangeOnline -UserPrincipalName $loginUpn
Get-EXOMailbox -Verbose -Debug

Get-OwnerlessGroupPolicy 


# orig:
Add-Type -Path 'C:\Program Files\WindowsPowerShell\Modules\AzureAD\2.0.1.10\Microsoft.IdentityModel.Clients.ActiveDirectory.dll'
$authContext3 = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList "https://login.windows.net/michev.onmicrosoft.com"
$plat = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters -ArgumentList "Auto"
$authenticationResult = $authContext3.AcquireTokenAsync("https://outlook.office365.com", "fb78d390-0c51-40cd-8e17-fdbfab77341b", "urn:ietf:wg:oauth:2.0:oob", $plat);
# https://www.michev.info/Blog/Post/2869/abusing-the-rest-api-endpoints-behind-the-new-exo-cmdlets
# https://www.michev.info/Blog/Post/4148/ownerless-group-policy-cmdlets-replacement


# I was not able to make it work
# 
##################
# Michev
Add-Type -Path "C:\Program Files\WindowsPowerShell\Modules\Microsoft.PowerApps.Administration.PowerShell\2.0.42\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
Add-Type -Path "C:\Users\Vlad\Documents\PowerShell\Modules\ExchangeOnlineManagement\3.0.0\netFramework\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
Add-Type -Path "C:\Users\Vlad\Documents\WindowsPowerShell\Modules\AzureADPreview\2.0.2.149\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"

Add-Type -Path "C:\Users\Vlad\Documents\WindowsPowerShell\Modules\AzureAD\2.0.1.10\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
Add-Type -Path "C:\Users\Vlad\Documents\WindowsPowerShell\Modules\AzureAD\2.0.2.140\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
$authContext3 = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext -ArgumentList "https://login.windows.net/uhgdev.onmicrosoft.com"
$plat = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters -ArgumentList "Auto"
$authenticationResult = $authContext3.AcquireTokenAsync("https://outlook.office365.com", "fb78d390-0c51-40cd-8e17-fdbfab77341b", "https://login.microsoftonline.com/common/oauth2/nativeclient", $plat)
# $authenticationResult = $authContext3.AcquireTokenAsync("https://outlook.office365.com", "f001f1f9-cd40-421b-82d9-bcc71592aece", "https://login.microsoftonline.com/common/oauth2/nativeclient", $plat)
# $authenticationResult = $authContext3.AcquireTokenAsync("https://outlook.office365.com", "f001f1f9-cd40-421b-82d9-bcc71592aece", "urn:ietf:wg:oauth:2.0:oob", $plat)
$authenticationResult

$authHeader = @{'Authorization' = $authenticationResult.Result.CreateAuthorizationHeader() }
$mailboxes = Invoke-RestMethod -Method Get -Uri "https://outlook.office.com/adminApi/beta//887d660e-c53f-4c38-af69-214fe2a73f0a/Mailbox" -Headers $AuthHeader
$mailboxes.value


##################################

Get-MsalToken -ClientId $clientId -TenantId $TenantId -Interactive -RedirectUri https://localhost

Connect-PnPOnline -ClientId $clientId -Tenant $TenantId -Url $adminUrl -Interactive 
Get-Command -Module PnP.PowerShell "*token*"

Get-PnPAccessToken
$token = Request-PnPAccessToken 
$headers = @{Authorization = "Bearer $token" }
$headers
$mailboxes = Invoke-RestMethod -Method Get -Uri "https://outlook.office.com/adminApi/beta//887d660e-c53f-4c38-af69-214fe2a73f0a/Mailbox" -Headers $headers
$mailboxes.value





