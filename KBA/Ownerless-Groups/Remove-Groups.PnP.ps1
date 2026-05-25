# This script is just a sample to demonstrate basic technique on deletion m365 groups with PowerShell and MS Graph
# please do not run this script as is, but update it upon your needs

$allGroups = Get-PnPMicrosoft365Group -Connection $connectionAdmin 
$allGroups.Count
$allGroups[-1]

$groupsToDelete = $allGroups | Where-Object { $_.DisplayName -like "Test-Ownerless*" }
$groupsToDelete = $allGroups | Where-Object { $_.DisplayName -like "Test-Pa*" }
$groupsToDelete.Count

$Batch = $groupsToDelete 
$Batch = $groupsToDelete | select -First 2
$Batch = $groupsToDelete | select -First 2000 -Skip 2
$Batch = $groupsToDelete | select -First 3990 -Skip 6002

foreach ($group in $Batch) {
    Write-Host "Deleting group: $($group.DisplayName) with id: $($group.Id)"
    Remove-PnPMicrosoft365Group -Identity $group.Id -Connection $connectionAdmin 
}




