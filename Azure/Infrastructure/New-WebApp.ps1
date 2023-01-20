
Connect-AzAccount -Subscription $subscriptionId -Tenant $TenantID

$resourceGroupName = "Test02"

$templateFile = "C:\scripts\PS\Azure\Infrastructure\WebPlan-Template.json"
$paramsFile = "C:\scripts\PS\Azure\Infrastructure\WebPlan-Params.json"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -TemplateParameterFile $paramsFile

$templateFile = "C:\scripts\PS\Azure\Infrastructure\WebApp-Template.json"
$paramsFile = "C:\scripts\PS\Azure\Infrastructure\WebApp-Params.json"
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -TemplateParameterFile $paramsFile

Remove-AzWebApp -DeleteAppServicePlan -Name "test02webapp3" -ResourceGroupName $resourceGroupName

$webApps = Get-AzWebApp -ResourceGroupName $resourceGroupName 
Remove-AzWebApp -WebApp $webApps[1]
-DeleteAppServicePlan -ResourceGroupName $resourceGroupName -

Remove-AzResourceGroup -Name $resourceGroupName -Force -AsJob
 

