# This script - universal SharePoint sites lookup tool 
# it takes any kind of url (sharepoint, teams, yammer community) and 
# returns site url, title, description, status, group owners etc..

$connectionAdmin.Url
$token = Get-PnPAccessToken -Connection $connectionAdmin
$headers = @{ Authorization = "Bearer $token" }
$headers

# The encoded sharing link must be for a file or folder
# $sharingUrl = "https://engage.cloud.microsoft/main/groups/eyJfdHlwZSI6Ikdyb3VwIiwiaWQiOiIyMjE2NzU1OTM3MjgifQ/all";
$sharingUrl = "https://s5dz3.sharepoint.com/:w:/t/Test-UIL/IQAWApnoiAjjR4ICXusHkuLsAVN808VtkHFfbe-15vecodY?e=xkKhNl";
$sharingUrl = "https://s5dz3.sharepoint.com/:li:/t/Test-UIL/IwAWqQ2GLEzbTo8vTVaurMxUAcVGunFAiBYAcUtOKGYmmEM?e=ADHUJb";
$sharingUrl = "https://s5dz3.sharepoint.com/teams/Test-UIL/Shared%20Documents/Doc1.docx";
$sharingUrl = "https://s5dz3-my.sharepoint.com/:f:/g/personal/m365admin_s5dz3_onmicrosoft_com/IgDxX_9dpOZsRK5vwLlxAZRxAahyghsyQ8syVnjp8ACRXp8?e=k40uzP";
$sharingUrl = "https://s5dz3.sharepoint.com/:x:/s/Mark8ProjectTeam/IQBFQPEN4VFLSp8yzjWyB6CwATrYnITINVbPcHKFFX-ZYww?e=Uxl8oV";
$sharingUrl = "https://s5dz3.sharepoint.com/teams/Test-Elevations-PrivatechannelwithMegan/";
$sharingUrl = "https://s5dz3.sharepoint.com/:u:/s/tst/subsite01/IQDT1WnS2vtERpmwXi1aOxruAViMmZ7-C5miAFamf6sQMnE?e=gtEfMD";
# string base64Value = System.Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(sharingUrl));
$base64Value = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($sharingUrl))
$base64Value
# string encodedUrl = "u!" + base64Value.TrimEnd('=').Replace('/','_').Replace('+','-');
$encodedUrl = "u!" + $base64Value.TrimEnd('=').Replace('/','_').Replace('+','-')
$encodedUrl

$apiUrl = "https://graph.microsoft.com/v1.0/shares/{shareId}/listItem"
$apiUrl = "https://graph.microsoft.com/v1.0/shares/{shareId}/list"
$apiUrl = "https://graph.microsoft.com/v1.0/shares/{shareId}/site"
$result = Invoke-RestMethod -Uri $apiUrl.Replace("{shareId}", $encodedUrl) -Headers $headers
$result | fl




# Define the URL you want to look up
# $url = ""

$responceText = $null


$allowedHosts = @()
$allowedHosts += $orgname + ".sharepoint.com"
$allowedHosts += $orgname + "-my.sharepoint.com"
$allowedHosts += "teams.microsoft.com"
$allowedHosts += "engage.cloud.microsoft"

function Remove-SharePointSharingPrefix {
    param([Parameter(Mandatory)][string]$Url)
    # Remove modern sharing prefixes like /:w:/r/, /:x:/r/, /:f:/r/ AND also /:li:/t/ (two-letter codes with /t/)
    $url = $url -replace '/:[a-z]{1,3}:/[a-z]/', '/'

    # $Url = $Url -replace '/:[a-z]:/r/', '/'
    # $Url = $Url -replace '/:[a-z]:/g/', '/'
    # $Url = $Url -replace '/:[a-z]:/t/', '/'
    return $Url 
}

function Get-SurfaceFromHost {
  param([Uri]$Uri)

  # $Uri = $url -as [Uri]; $Uri.Host; $Uri.AbsolutePath
  if(!$Uri.Host) {return 'Invalid Uri'}
  
  $h = $Uri.Host.ToLower()
  if ($h -notin $allowedHosts) { return 'Unknown Domain' }

  if ($h -match '\.sharepoint\.com$') { 
    $AbsolutePath = Remove-SharePointSharingPrefix -Url $Uri.AbsolutePath
    if (($h -match '\-admin.sharepoint\.com$')) {return 'Admin SharePoint' }
    if ($AbsolutePath -match '^/sites/|^/teams/|^/portals/') {return 'SharePoint' }
    if ($AbsolutePath -match '^/personal/') { return 'OneDrive' }
    return 'SharePoint (unknown site type)'
  }
  if ($h -match '^teams\.microsoft\.com$') { return 'Teams' }
  if ($h -match '^engage\.cloud\.microsoft$') { return 'Engage' }  # include regional variants later
  if ($h -match '(^|\.)(yammer|engage)\.com$') { return 'Engage' }  # include regional variants later

  return 'Unknown'
}

# the function  Get-SiteUrl returns site collection Url from a long SharePoint Url, for example from sharing link or from ling to library item 
function Get-SiteUrl {
  param([Uri]$Uri)

  if(!$Uri.Host) {return 'Invalid Uri'}
  
  $h = $Uri.Host.ToLower()
  if ($h -match '\.sharepoint\.com$') { 
    $AbsolutePath = Remove-SharePointSharingPrefix -Url $Uri.AbsolutePath
    if ($AbsolutePath -match '^/sites/|^/teams/|^/portals/') {
      $parts = $AbsolutePath.Split('/')
      return "https://$($Uri.Host)$($parts[0])/$($parts[1])"
    }
  }
  
  return $null
}

function Get-SiteDetails {
  param (
    [Parameter(Mandatory)]
    [string]$Url  
  )
  $r = "Site url: $Url`n"
  $siteUrl = Get-SiteUrl -Uri $Url
  $pnpSite = Get-PnPTenantSite -Connection $connectionAdmin -Identity $siteUrl -Detailed
  if (!$pnpSite) {return $r + "Unable to retrieve site details."}
  $r += "Site title: $($pnpSite.Title)`n"
  $r += "Site description: $($pnpSite.Description)`n"
  return $r
}

$surface = Get-SurfaceFromHost -Uri $url

switch ($surface) {
  "SharePoint" { $responceText = Get-SiteDetails -Url $url }
  Default {}
}

Write-Host "The URL belongs to: $surface`n"
Write-Host $responceText
