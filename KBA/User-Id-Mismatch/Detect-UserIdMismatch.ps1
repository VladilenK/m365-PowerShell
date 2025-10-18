# this script helps to detect user id mismatch issues in a given site collection

$siteUrl = "https://$orgName.sharepoint.com/teams/UserIDMismatchTest01"
$userUPN = "John.Smith@$orgname.onmicrosoft.com"

$siteConnection = Connect-PnPOnline -Url $siteUrl -ClientId $ClientId -Thumbprint $thumbprint -Tenant $tenantId -ReturnConnection
$siteUser = Get-PnPUser -Identity "i:0#.f|membership|$userUPN" -Connection $siteConnection -Includes AadObjectId
$siteUser.Id
$siteUser.UserId.NameId
$siteUser.AadObjectId.NameId

$userProfileProperties = Get-PnPUserProfileProperty -Account $userUPN -Connection $adminConnection
$userProfileProperties

$eIdUserAccount = Get-PnPAzureADUser -Identity $userUPN -Connection $adminConnection 
$eIdUserAccount.Id.Guid


if ($siteUser.AadObjectId.NameId -ne $eIdUserAccount.Id.Guid) {
    Write-Host "User ID mismatch detected for user $userUPN in site $siteUrl" -ForegroundColor Red
}
if ($siteUser.AadObjectId.NameId -ne $userProfileProperties["msOnline-ObjectId"]) {
    Write-Host "User ID mismatch detected for user $userUPN in site $siteUrl" -ForegroundColor Red
}
if($siteUser.UserId.NameId -ne $userProfileProperties["SID"].Trim("@live.com").TrimStart("i:0h.f|membership|")) {
    Write-Host "User ID mismatch detected for user $userUPN in site $siteUrl" -ForegroundColor Red
}

