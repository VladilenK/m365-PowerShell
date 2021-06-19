import-module -Name  Microsoft.Graph
Get-Module -Name Microsoft.Graph


Get-Command -Verb Get -Noun "*licens*"
Get-Command -Verb Get -Noun "*licens*" -Module PnP.PowerShell
Get-Command -Verb Get -Noun "*licens*" -Module Az
Get-Command -Verb Get -Noun "*licens*" -Module AzureAD
Get-Command -Verb Get -Noun "*licens*" -Module Microsoft.Graph

Get-Command -Verb Get -Noun "*Cert*"
Get-Command -Verb Get -Noun "*SKU*"
Get-Command -Verb Get -Noun "*Subsc*"

# Microsoft.Graph
Connect-MgGraph -ClientId $clientId -Certificate 
Get-MgSubscribedSku | fl
Get-MgSubscribedSku | Select-Object PrepaidUnits -ExpandProperty PrepaidUnits
Get-MgSubscription 

# AzureAD
Get-AzureADSubscribedSku | Select SkuPartNumber



