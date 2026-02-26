
$headers | ft -a

# 

#################################
# Audit logs
$reportPath = "directoryAudits"
#  includes events like CRUD against app registrations, service principals, groups, users, devices, etc.

$apiUrl = "https://graph.microsoft.com/beta/auditLogs/$reportPath" 
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Data.value.Count

$Data.value | Format-List
$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$Data.value | Export-Csv -Path "$home\code\m365-PowerShell\.data\ACS-Audit\$reportPath-$timestamp.csv"


$Data.value | Format-List | clip
$Data.value[0] | Format-List 
$Data.value[-1] | Format-List 

$Data.value | ?{$_.clientAppUsed -ne "Browser"} | Select-Object -First 1 | Format-List


# $reportPath = "directoryAudits"
$Data.value | Select-Object -ExpandProperty category | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty activityDisplayName | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty targetResources | Select-Object -ExpandProperty displayName | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty additionalDetails | Format-List
$Data.value | Select-Object -ExpandProperty initiatedBy | Format-List
$Data.value | Select-Object -ExpandProperty initiatedBy | Select-Object -ExpandProperty app | Format-List
$Data.value | Select-Object -ExpandProperty initiatedBy | Select-Object -ExpandProperty app | Select-Object -ExpandProperty displayName | Sort-Object -Unique | Format-List
$Data.value | ?{$_.initiatedBy.app.displayName} | Format-List

$Data.value | ?{$_.activityDisplayName -eq "Add service principal"} | Format-List
$Data.value | ?{$_.targetResources.DisplayName -like "KBA-ACS-App-01"} | Select-Object -First 3 | Format-List 
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Format-List
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Select-Object -ExpandProperty targetResources | Select-Object -ExpandProperty displayName | Sort-Object -Unique | Format-List
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Select-Object -ExpandProperty targetResources | Format-List

