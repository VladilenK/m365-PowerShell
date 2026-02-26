
$headers | ft -a

# 

$reportPath = "applicationSignInDetailedSummary"
$reportPath = "appCredentialSignInActivities"
$reportPath = "servicePrincipalSignInActivities"

$apiUrl = "https://graph.microsoft.com/beta/reports/$reportPath"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Data.value.Count

$Data.value | Format-List
$Data.value | Format-Table -AutoSize

# appCredentialSignInActivities
$Data.value | Select-Object -Property appId, keyType, createdDateTime, expirationDateTime | Sort-Object expirationDateTime

$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$Data.value | Export-Csv -Path "T:\code\m365-PowerShell\.data\ACS-Audit\$reportPath-$timestamp.csv"

$Data.value | Format-List | clip
$Data.value[0] | Format-List 
$Data.value[-1] | Format-List 

$Data.value | Select-Object -ExpandProperty appId | Sort-Object -Unique
$Data.value | ?{$_.appId -eq "cb06d91c-33c7-408d-b5e2-4b60c33f2c7e" } # 1
$Data.value | ?{$_.appId -eq "9cfd2747-c335-4103-88a7-ef5d6efaa3de" } # 2
$Data.value | ?{$_.appId -eq "297219c4-bd24-4b9c-a15b-ec06de48f9f6" } # 3
$Data.value | ?{$_.appId -eq "7887d358-ef05-49df-964c-4fe5f122c0ba" } # 8
$Data.value | ?{$_.appId -eq "a2de88c7-d9b1-4958-94aa-8014f92d5ebf" } # 9


# applicationSignInDetailedSummary

# servicePrincipalSignInActivities
$Data.value | ?{$_.appId -eq "cb06d91c-33c7-408d-b5e2-4b60c33f2c7e" } # 1



