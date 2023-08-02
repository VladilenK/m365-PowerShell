# Vladilen@$orgname.onmicrosoft.com

$PSVersionTable # must be 5.1 x64
Get-Module AzureAD -ListAvailable
Get-Module AzureADPreview -ListAvailable
Update-Module AzureADPreview 
Import-Module AzureADPreview
Connect-AzureAD

Get-AzureADUser 
Get-AzureADDirectorySetting 
Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ 

$GroupName = "m365-Groups-Creators"

$settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
if ($settingsObjectID) { 
    Write-Host $settingsObjectID 
} else {
    Write-Warning "Cannot find settings"; return
    # create AzureADDirectorySetting
    $template = Get-AzureADDirectorySettingTemplate | Where-object { $_.displayname -eq "group.unified" }
    $settingsCopy = $template.CreateDirectorySetting()
    New-AzureADDirectorySetting -DirectorySetting $settingsCopy
    $settingsObjectID = (Get-AzureADDirectorySetting | Where-object -Property Displayname -Value "Group.Unified" -EQ).id
}

$settingsCopy = Get-AzureADDirectorySetting -Id $settingsObjectID
$settingsCopy["EnableGroupCreation"] 
$settingsCopy["EnableGroupCreation"] = $False

$adGroup = Get-AzureADGroup -SearchString $GroupName
$adGroup
$settingsCopy["GroupCreationAllowedGroupId"] = $adGroup.objectid
$settingsCopy.Values

Set-AzureADDirectorySetting -Id $settingsObjectID -DirectorySetting $settingsCopy
(Get-AzureADDirectorySetting -Id $settingsObjectID).Values