# this script 
# 1) detects if there is a User id Mismatch Issue on the site
# 2) if yes - deletes User Id from the site and adds it again (with no permissions)
# NB! removing User from the UIL also removes all user's permissions, so user needs to request permissions again - but this time it should work
# NB! dew to nature of user id mismatch issue - these could be two different users - removing user's permissions is OK

# parameters
# specify User email and site url here:
$userEmail = "John.Smith.qerdgfq@$orgname.onmicrosoft.com"
$userEmail = "John.Smith@$orgname.onmicrosoft.com"
$siteUrl = "https://$orgname.sharepoint.com/teams/UserIDMismatchTest01"
$siteUrl = "https://$orgname.sharepoint.com/sites/UserIDMismatchTest02"
$siteUrl = "https://$orgname.sharepoint.com/teams/UserIDMismatchTest03"

# end of parameters section
# 

# authenticate
$connectionAdmin.Url

# let's find a user in entra id:
# try to get user by email (in most cases email equals upn)
$adUser = Get-PnPAzureADUser -Connection $connectionAdmin -Identity $userEmail
if ($adUser) {
    # Found user in entra id
} else {
    # otherwise (in case upn -ne email) let us try to find user by email
    $filter = "Mail eq '" + $userEmail + "'"
    $adUser = Get-PnPAzureADUser -Connection $connectionAdmin -Filter $filter    
}

if ($adUser) {
    $upn = $adUser.UserPrincipalName
    Write-Host "Found user in entra id: " $adUser.DisplayName
    if ($adUser.AccountEnabled) {        
    } else {
        Write-Host "Note that user's account entra id is disabled." 
    }
} else {
    Write-Host "Could not find user in entra id." -ForegroundColor Yellow
    Write-Host "Please double-check email specified: " $userEmail -ForegroundColor Yellow
    exit 1
}

# now we need to pull user profile from UPSA
$userProps = $null
$userProps = Get-PnPUserProfileProperty -Connection $connectionAdmin -Account $upn
if ($userProps) {
    Write-Host "Found user in SharePoint User Profiles Service: " $userProps["AccountName"]
} else {
    Write-Host "Could not find user in SharePoint User Profiles Service." -ForegroundColor Yellow
    exit 1
}

# let's connect to site
$connectionToSite = Connect-PnPOnline -ReturnConnection -ClientId $ClientId -Thumbprint $Thumbprint -Tenant $tenantId -Url $siteUrl 
if ($?) {
} else {
    Write-Host "Could not connect to site:" $siteUrl -ForegroundColor Yellow
    exit 1
}

# let's get site
$site = Get-PnPSite -Connection $connectionToSite
if ($?) {
    Write-Host "Connected to site:" $siteUrl 
} else {
    Write-Host "Could not connect to site:" $siteUrl -ForegroundColor Yellow
    exit 1
}

#  let's get site user
# Get-PnPUser -Connection $connectionToSite 
$siteUser = $null
$siteUser = Get-PnPUser -Connection $connectionToSite -Identity ("i:0#.f|membership|$upn") -Includes AadObjectId
if ($siteUser) {
    Write-Host "Found user in the site: " $siteUser.Title
} else {
    Write-Host "Could not find user in the site: " $siteUser.Title
}


# now we detect if there is a user id mismatch issue
# normally user id and sid should be the same in all 3 user objects from entra id, upsa and site
$userIdMismatch = $false

# compare SID from site and UPSA
$upsaSID = ($UserProp["SID"].split("|") | Select-Object -Last 1).split("@") | Select-Object -First 1
if($upsaSID -eq $siteUser.UserId.NameId) {
} else {
    Write-Host "SID mismatch found." -ForegroundColor Yellow
    Write-Host "SID from User Profile:" $upsaSID
    Write-Host "SID from Site User   :" $siteUser.UserId.NameId
    $userIdMismatch = $true
}

# compare User Id from site and UPSA
if ($UserProp["msOnline-ObjectId"] -eq $siteUser.AadObjectId.NameId) {
} else {
    Write-Host "User directory object Id mismatch found." -ForegroundColor Yellow
    Write-Host "User Id from User Profile:" $UserProp["msOnline-ObjectId"]
    Write-Host "User Id from Site User   :" $siteUser.AadObjectId.NameId
    $userIdMismatch = $true
}

# compare User Id from site and directory
if ($adUser.Id -eq $siteUser.AadObjectId.NameId) {
} else {
    Write-Host "User directory object Id mismatch found." -ForegroundColor Yellow
    Write-Host "User Id from Directory:" $adUser.Id
    Write-Host "User Id from Site User:" $siteUser.AadObjectId.NameId
    $userIdMismatch = $true
}

if ($userIdMismatch) {
    Write-Host "The User Id Mismatch Issue was found on the site for the user."
    Write-Host "We'll remove User from the UIL which also removes all user's permissions."
    Write-Host "User will need to request permissions again - but this time it should work."
} else {
    Write-Host "We did not find User Id Mismatch Issue on the site." -ForegroundColor Green
    Exit
}

# Next, we'll ask for confirmation then delete user id from site and add it back

$confirmation = Read-Host "Please confirm (y/n)"
if ($confirmation.ToLower() -eq "y") {
} else {
    Write-Host "User deletion was not confirmed. The Issue is not fixed." 
    Read-Host "Press any key to exit"
    Exit
}

# Fix the issue by removing the user and re-adding
# remove
Remove-PnPUser -Connection $connectionToSite -Identity ("i:0#.f|membership|$upn") -Force
if ($?) {
    Write-Host "Successfully removed user from site." 
} else {
    Write-Host "Something went wrong... Could not remove user from site."  -ForegroundColor Yellow
    exit 1
}
# add
$web = Get-PnPWeb -Connection $connectionToSite
$web.EnsureUser("i:0#.f|membership|$upn") 

# Validate
$newSiteUser = Get-PnPUser -Connection $connectionToSite -Identity ("i:0#.f|membership|$upn") -Includes AadObjectId
if ($newSiteUser) {
} else {
    Write-Host "Something went wrong... Just added user was not found on the site..."  -ForegroundColor Yellow
    Exit 1
}
if ($newSiteUser.Id -ne $siteUser.Id) {
    Write-Host "Added user to the site with no permissions."
} else {
    Write-Host "Something went wrong... Just added user got the same site user Id..."  -ForegroundColor Yellow
    Exit 1
}

Write-Host "Finished."
Read-Host "Press any key to exit"
Exit

