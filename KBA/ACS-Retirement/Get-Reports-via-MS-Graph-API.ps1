
$headers | ft -a

# 

$reportPath = "applicationSignInDetailedSummary"
$reportPath = "servicePrincipalSignInActivities"
$reportPath = "appCredentialSignInActivities"

$apiUrl = "https://graph.microsoft.com/beta/reports/$reportPath"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get

$Data.value | Format-List
$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$Data.value | Export-Csv -Path "T:\code\PS\.data\ACS-audit\$reportPath-$timestamp.csv"



$Data.value | Format-List | clip
$Data.value[0] | Format-List 
$Data.value[-1] | Format-List 

$Data.value | Select-Object -ExpandProperty appId | Sort-Object -Unique
$Data.value | ?{$_.appId -eq "cb06d91c-33c7-408d-b5e2-4b60c33f2c7e" } # 1
$Data.value | ?{$_.appId -eq "9cfd2747-c335-4103-88a7-ef5d6efaa3de" } # 2
$Data.value | ?{$_.appId -eq "297219c4-bd24-4b9c-a15b-ec06de48f9f6" } # 3


