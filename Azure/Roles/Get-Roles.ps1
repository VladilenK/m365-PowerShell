$clientId = "7bac27b8-d042-4ed9-b030-d286734366a2"
$tenantId = "046d11d6-08e0-4d20-a743-562836cdcab5"
Import-Module Microsoft.Graph.Identity.Governance


DisConnect-MgGraph -Verbose
Connect-MgGraph -ClientId $clientId -TenantId $tenantId

Get-MgContext | select Account

Get-MgRoleManagementDirectoryRoleDefinition
Get-MgRoleManagementDirectoryRoleEligibilitySchedule

Get-MgRoleManagementDirectoryRoleAssignmentSchedule
Get-MgRoleManagementDirectoryRoleAssignmentScheduleRequest

