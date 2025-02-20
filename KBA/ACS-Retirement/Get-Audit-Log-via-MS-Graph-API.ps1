
$headers | ft -a

# 

#################################
# Audit logs
$reportPath = "directoryAudits"
$reportPath = "signIns"

$apiUrl = "https://graph.microsoft.com/beta/auditLogs/$reportPath" 
$apiUrl = "https://graph.microsoft.com/beta/auditLogs/$reportPath" + '?&$filter=signInEventTypes/any' + "(t: t ne 'interactiveUser')"      # "signIns"
$apiUrl = "https://graph.microsoft.com/beta/auditLogs/$reportPath" + '?&$filter=signInEventTypes/any' + "(t: t eq 'nonInteractiveUser')"   # "signIns"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get

$Data.value | Format-List
$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$Data.value | Export-Csv -Path "T:\code\PS\.data\ACS-audit\$reportPath-$timestamp.csv"



$Data.value | Format-List | clip
$Data.value[0] | Format-List 
$Data.value[-1] | Format-List 

$Data.value | ?{$_.clientAppUsed -ne "Browser"} | Select-Object -First 1 | Format-List


# "signIns"
$Data.value | Select-Object clientAppUsed -ExpandProperty clientAppUsed | Sort-Object -Unique | Format-List
$Data.value | Select-Object appId -ExpandProperty appId | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty userId | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty authenticationProtocol | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty userAgent | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty authenticationProcessingDetails | Select-Object -Last 5 | Format-List 
$Data.value | Select-Object -ExpandProperty authenticationDetails | Select-Object -First 5 | Format-List 

# $reportPath = "directoryAudits"
$Data.value | Select-Object -ExpandProperty category | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty activityDisplayName | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty targetResources | Select-Object -ExpandProperty displayName | Sort-Object -Unique | Format-List

$Data.value | ?{$_.activityDisplayName -eq "Add service principal"} | Format-List
$Data.value | ?{$_.targetResources.DisplayName -like "KBA-ACS-App-01"} | Select-Object -First 3 | Format-List 
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Format-List
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Select-Object -ExpandProperty targetResources | Select-Object -ExpandProperty displayName | Sort-Object -Unique | Format-List
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Select-Object -ExpandProperty targetResources | Format-List

