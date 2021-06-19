param($Timer)
$currentUTCtime = (Get-Date).ToUniversalTime()
if ($Timer.IsPastDue) {
    Write-Host "PowerShell timer is running late!"
}
Write-Host "PowerShell timer trigger function ran! TIME: $currentUTCtime"
Write-Host "=================================================================================="
Get-Module -ListAvailable | Format-Table -AutoSize

Write-Host "Connecting to the KeyVault..."
$vaultName = "m365-licenses-and-alerts"
$resourceGroupName = "m365-licenses-and-alerts"
$secretName = "secret01"
$keyVault = Get-AzKeyVault -VaultName $vaultName -ResourceGroupName $resourceGroupName
Write-Host "keyVault connected: " $keyVault.VaultName
$secret = Get-AzKeyVaultSecret -VaultName $vaultName -Name $secretName
Write-Host "secret value: " $($secret.SecretValue | ConvertFrom-SecureString -AsPlainText )



# Connect-AzAccount -Subscription "ba534be8-fe3a-4281-913d-899a9b74d598" -Tenant "4711e202-fab7-46b3-8086-028242654fc2"
# Get-AzSubscription
# Get-AzContext
# disConnect-AzAccount

