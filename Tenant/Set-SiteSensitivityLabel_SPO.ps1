$PSVersionTable
# must be ? PowerShell 5.1 x64

Get-Module Microsoft.Online.SharePoint.PowerShell -ListAvailable 

$upn = "Vladilen@uhgdev.onmicrosoft.com"
$Id = [GUID]("0f4b1e4f-9646-4748-b397-283325ce9f49")
$adminUrl = "https://uhgdev-admin.sharepoint.com" 

Connect-SPOService -Url $adminUrl
$siteUrl = "https://uhgdev.sharepoint.com/teams/test-21"
$site = Get-SPOSite -Identity $siteUrl 
$site | Select-Object Url, SensitivityLabel 
Set-SPOSite -Identity $siteUrl -SensitivityLabel $Id 

Get-command Set-SPOSite








