Write-Host "This script will generate a Teams app package that will allow you to pin your SharePoint intranet in Teams."
Write-Host "Please ensure you have SharePoint admin privileges in your tenant before running this script."
# Import-Module -Name Microsoft.Online.SharePoint.PowerShell 
# Get-Module -Name Microsoft.Online.SharePoint.PowerShell | ft Version, Path
# Install-Module -Name Microsoft.Online.SharePoint.PowerShell -MinimumVersion 16.0.20324.12000 -Force

# Get SharePoint Portal link from user
# 'Enter the link of the SharePoint portal that you want to pin in Teams. 
#  Please ensure that it is a modern Communication site. We recommend that you use a Home Site'
[uri]$configUrl = "https://$orgname.sharepoint.com/"
[string]$domain = $configUrl.Host
$hostElement = $domain.Split(".")[0]

## Search Info
$searchSiteVariable = '';
$searchUrlPath = $domain;

if ($configUrl.LocalPath -match '/teams' -or $configUrl.LocalPath -match '/sites') {
  $searchSiteVariable = '/siteall';
  if ($configUrl.LocalPath -match '^\/[^\/]+\/[^\/]+') { $searchUrlPath = $domain + $Matches[0]; }
}
$searchUrl = "https://$searchUrlPath/_layouts/15/search.aspx$searchSiteVariable" + 'q={searchQuery}'

# Get the Name of the App
# 'Please enter the name of your app, as you want it to appear in Teams'
$appname = "Sparq2"
$shortDescription = 'Short description for the app' # less than 80 characters
$longDescription = 'Long description for the app' # less than 4000 characters
$PrivacyPolicyUrl = 'https://privacy.microsoft.com/en-us/privacystatement'
$TermsOfUseUrl = 'https://go.microsoft.com/fwlink/?linkid=2039674'
$companyName = "UHG"
$companyWebsite = "https://www.uhc.com"

#Adding query param with app=portal
if ($ConfigUrl -contains '`?') {
  [uri]$finalconfigUrl = $configUrl.ToString() + '&app=portals'
} 
else {
  [uri]$finalconfigUrl = $configUrl.ToString() + '?app=portals'
}
Write-Host "Company Portal: '$finalConfigUrl'"

# Generate random GUID
$guid = [System.Guid]::NewGuid()
$DesktopPath = [Environment]::GetFolderPath("Desktop")

$color = "C:\Users\Vlad\Desktop\Viva-Desktop\icons8-linkedin-192.png" # "Please upload colored-icon[192x192]px"
$color_filename = Split-Path $color -leaf
$outline = "C:\Users\Vlad\Desktop\Viva-Desktop\icons8-linkedin-32.png" #  "Please upload outline-icon[32x32]px"
$outline_filename = Split-Path $outline -leaf

#https://developer.microsoft.com/en-us/json-schemas/teams/v1.8/MicrosoftTeams.schema.json
#https://raw.githubusercontent.com/OfficeDev/microsoft-teams-app-schema/preview/DevPreview/MicrosoftTeams.schema.json
# Json object
$json = @"
{
  "`$schema": "https://developer.microsoft.com/en-us/json-schemas/teams/v1.9/MicrosoftTeams.schema.json",
  "manifestVersion": "1.9",
  "version": "1.0",
  "id": "$guid",
  "packageName": "com.microsoft.teams.$appname",
  "developer": {
    "name": "$companyName",
    "websiteUrl": "$companyWebsite",
    "privacyUrl": "$PrivacyPolicyUrl",
    "termsOfUseUrl": "$TermsOfUseUrl"
  },
  "icons": {
    "color": "$color_filename",
    "outline": "$outline_filename"
  },
  "name": {
    "short": "$appName",
    "full": "$appName"
  },
  "description": {
    "short": "$shortDescription",
    "full": "$longDescription"
  },
  "accentColor": "#40497E",
  "isFullScreen": true,
  "staticTabs": [
        {
            "entityId": "sharepointportal_$guid",
            "name": "Portals-$appName",
            "contentUrl": "https://$domain/_layouts/15/teamslogon.aspx?spfx=true&dest=$finalconfigUrl",
            "websiteUrl": "$configUrl",
            "searchUrl": "https://$searchUrlPath/_layouts/15/search.aspx?q={searchQuery}",
            "scopes": ["personal"],
            "supportedPlatform" : ["desktop"]
        }
    ],
  "permissions": [
    "identity",
    "messageTeamMembers"
  ],
  "validDomains": [
    "$domain",
    "*.login.microsoftonline.com",
    "*.sharepoint.com",
    "*.sharepoint-df.com",
    "spoppe-a.akamaihd.net",
    "spoprod-a.akamaihd.net",
    "resourceseng.blob.core.windows.net",
    "msft.spoppe.com"
  ],
  "webApplicationInfo": {
    "id": "00000003-0000-0ff1-ce00-000000000000",
    "resource": "https://$domain"
  }
}
"@

$tempPath = [System.IO.Path]::GetTempPath()
$manifestPath = $tempPath + '\manifest.json'

#Writing content to manifest file in temp location
Set-Content -Path $manifestPath $json

# Creating zip file
Compress-Archive -DestinationPath $DesktopPath\$appName.zip -Force -LiteralPath $manifestPath, $color, $outline -CompressionLevel Optimal
Write-Host "Your Viva Connections desktop app has been successfully created! Please find the app manifest in location '$DesktopPath', filename '$appName'.zip."
Write-Host "Please upload this app in Teams Admin Center to proceed."
