# Assign sensitivity labels to Microsoft 365 groups in Azure Active Directory
# https://docs.microsoft.com/en-us/azure/active-directory/enterprise-users/groups-assign-sensitivity-labels
# To configure this feature, there must be at least one active Azure Active Directory Premium P1 license in your Azure AD organization.

$PSVersionTable
# must be PowerShell 5.1 x64
$upn = "Vladilen@$orgname.onmicrosoft.com"

Get-Module AzureADPreview -ListAvailable 
Find-Module AzureADPreview 
Install-Module AzureADPreview -Scope CurrentUser -AllowClobber
Import-Module AzureADPreview
Update-Module AzureADPreview
Uninstall-Module AzureADPreview

Connect-AzureAD 
Get-AzureADUser -ObjectId $upn

# Fetch the current group settings for the Azure AD organization and display the current group settings.
Get-AzureADDirectorySetting 
$grpUnifiedSetting = (Get-AzureADDirectorySetting | Where-Object -Property DisplayName -Value "Group.Unified" -EQ)
$grpUnifiedSetting.Values
$Setting = $grpUnifiedSetting
$Setting["EnableMIPLabels"] 
# Enable the feature:
$Setting["EnableMIPLabels"] = "True"
$Setting["EnableMIPLabels"] 
# Save the changes and apply the settings:
Set-AzureADDirectorySetting -Id $grpUnifiedSetting.Id -DirectorySetting $Setting

# Create/Update sensitivity labels with Site/Group scope
# GUI

# Synchronize your sensitivity labels to Azure AD
Get-Command Execute-AzureAdLabelSync
Get-Help Execute-AzureAdLabelSync

# Connect to Security & Compliance PowerShell
Get-Module ExchangeOnlineManagement -ListAvailable
Find-Module ExchangeOnlineManagement 
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Import-Module ExchangeOnlineManagement
Connect-IPPSSession -UserPrincipalName $upn

# Then run the following command to ensure your sensitivity labels can be used with Microsoft 365 groups
Execute-AzureAdLabelSync

# Configure Policy

Get-Label | ft -a
Get-Label | ft -a Name, ImmutableId
Get-Label | ? { $_.Name -like "*test*" } | fl
$label = Get-Label | ? { $_.Name -like "*test*" } | fl

$Id = [GUID]("0f4b1e4f-9646-4748-b397-283325ce9f49") # Test Label 01
$Id = [GUID]("737dde27-1b61-4232-b976-7ff1148da60c") # Internal-Only Site Group
$Id = [GUID]("27b5d387-be3c-4c5d-b59c-f204385c2ff3") # External Access Enabled Site or Group
Get-Label -Identity $Id

Get-Label -Identity $label.ImmutableId


$adminUrl = "https://$orgname-admin.sharepoint.com" 
Connect-SPOService -Url $adminUrl
$siteUrl = "https://$orgname.sharepoint.com/teams/test-21"
$site = Get-SPOSite -Identity $siteUrl 
$site | Select-Object Url, SensitivityLabel 
Set-SPOSite -Identity $siteUrl -SensitivityLabel $Id 










