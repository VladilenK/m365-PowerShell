#  
Import-Module Microsoft.Graph

DisConnect-MgGraph 
Connect-MgGraph -Scopes "Application.Read.All"
Get-MgContext

Get-MgServicePrincipal 
Get-MgServicePrincipal | ft DisplayName, AppId, ServicePrincipalType

$servicePrincipals = Get-MgServicePrincipal -All
$servicePrincipals.count
$servicePrincipals[0].AppOwnerOrganizationId
$servicePrincipals[0] | fl
$servicePrincipals[-1] | fl

$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$servicePrincipals | Export-Csv -Path "T:\code\m365-PowerShell\.data\ACS-Audit\ServicePrincipals-$timestamp.csv"



$servicePrincipals | ?{ $_.AppOwnerOrganizationId -eq $tenantid }
$servicePrincipals | ?{ $_.id -eq '27a7bdef-db68-4204-ae80-37e0f1f5ccf8' }
$sp = $servicePrincipals | ?{ $_.AppDisplayName -eq 'KBA-ACS-App-01' }
$sp = $servicePrincipals | ?{ $_.AppDisplayName -eq 'KBA-ACS-App-01' }

$sp = Get-MgServicePrincipal -ServicePrincipalId "387d91bc-0771-4b6b-a4d9-1c66242e045f" -Property Info, AppRoleAssignments, AppRoles, AppRoleAssignedTo, KeyCredentials, PasswordCredentials
$sp = Get-MgServicePrincipal -ServicePrincipalId "70e5e047-386e-4657-b765-865fb632a559" -Property addins, Info, AppRoleAssignments, AppRoles, AppRoleAssignedTo, KeyCredentials, PasswordCredentials
$sp 
$sp.AddIns
$sp.Info
$sp.AppRoleAssignedTo
$sp.AppRoleAssignments
$sp.AppRoles
$sp.KeyCredentials
$sp.PasswordCredentials

$servicePrincipals | Select-Object ServicePrincipalType | Sort-Object ServicePrincipalType -Unique | ft ServicePrincipalType
$servicePrincipals | Select-Object SignInAudience | Sort-Object SignInAudience -Unique | ft SignInAudience
$servicePrincipals | Select-Object AccountEnabled | Sort-Object AccountEnabled -Unique | ft AccountEnabled







$sp | fl | clip

