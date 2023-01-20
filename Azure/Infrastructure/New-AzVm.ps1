# tenant with an Azure Subscription
Connect-AzAccount -Subscription $subscriptionId -Tenant $TenantID

New-AzVm `
    -ResourceGroupName "CrmTestingResourceGroup" `
    -Name "CrmUnitTests" `
    -Image "UbuntuLTS"
    
    
