Get-Date
Import-Module Az
Get-Module Az | ft -a
Get-Date
Import-Module Microsoft.Graph.Authentication
Get-Module Microsoft.Graph.Authentication | ft -a
Get-Date
Import-Module Microsoft.Graph.Identity.DirectoryManagement
Get-Module Microsoft.Graph.Identity.DirectoryManagement | ft -a
Get-Date

$vaultName = "m365-lcnse-alrts-rprtg"
$rgName = "m365-license-alerts-and-reporting"
$vault = Get-AzKeyVault -VaultName $vaultName -ResourceGroupName $rgName 
$vault.VaultName

Connect-AzAccount

