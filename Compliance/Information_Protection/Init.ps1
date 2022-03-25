Get-Module AzureADPreview
Install-Module AzureADPreview -Force -Scope CurrentUser
Update-Module AzureADPreview 
Import-Module AzureADPreview
Connect-AzureAD -TenantId $tenantId

$grpUnifiedSetting = (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ)
$template = Get-AzureADDirectorySettingTemplate -Id 62375ab9-6b52-47ed-826b-58e47e0e304b
$setting = $template.CreateDirectorySetting()

###########################################

Import-Module ExchangeOnlineManagement
Get-Module ExchangeOnlineManagement

Connect-IPPSSession -UserPrincipalName $adminUPN

Execute-AzureAdLabelSync



