# 
# Your tenant ID (in the Azure portal, under Azure Active Directory > Overview).
$TenantID = "4711e202-fab7-46b3-8086-028242654fc2" # the one with Azure Subscription
$resourceGroup = "01-AzureMngIds-JVK"
$webAppName = "01-AzureWebApp-JVK"

# tenant with an Azure Subscription
Connect-AzAccount -Subscription "3947764c-a78f-48b3-a9ee-fb0c5a541e4f" -Tenant $TenantID

# Get the ID of the managed identity for the web app.
$spID = (Get-AzWebApp -ResourceGroupName $resourceGroup -Name $webAppName).identity.principalid
$spID
$spId = "add61c3c-555c-48f0-a276-7961fc6e51b9"


# tenant with a M365 Subscription
$TenantID = "887d660e-c53f-4c38-af69-214fe2a73f0a" # the one with m365 subscription
# Check the Microsoft Graph documentation for the permission you need for the operation.
$PermissionName = "User.Read.All"

Connect-AzureAD -TenantId $TenantID

# Get the service principal for Microsoft Graph.
# First result should be AppId 00000003-0000-0000-c000-000000000000
$GraphServicePrincipal = Get-AzureADServicePrincipal -SearchString "Microsoft Graph" | Select-Object -first 1

# Assign permissions to the managed identity service principal.
$AppRole = $GraphServicePrincipal.AppRoles | `
    Where-Object { $_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains "Application" }

$naadspa = New-AzureAdServiceAppRoleAssignment -ObjectId $spID -PrincipalId $spID `
    -ResourceId $GraphServicePrincipal.ObjectId -Id $AppRole.Id


(Get-AzureADServicePrincipal -Top 1).ObjectId    
Get-AzureAdServiceAppRoleAssignment -ObjectId 003dd2bb-3c42-478b-82a0-950d66d145a1
Get-AzureAdServiceAppRoleAssignment -ObjectId $spID

