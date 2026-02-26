
$headers | ft -a

# 

#################################
# Audit logs
$reportPath = "signIns" 
#  includes user sign-in events


$apiUrl = "https://graph.microsoft.com/beta/auditLogs/$reportPath" 
# $apiUrl = "https://graph.microsoft.com/beta/auditLogs/$reportPath" + '?$filter=' + "signInEventTypes/any(t:t eq 'servicePrincipal')" + " and appId eq 'cb06d91c-33c7-408d-b5e2-4b60c33f2c7e'"
$apiUrl += '?$filter=' + "signInEventTypes/any(t:t eq 'servicePrincipal')"
$apiUrl += " and appId eq 'cb06d91c-33c7-408d-b5e2-4b60c33f2c7e'"
$apiUrl += " and createdDateTime ge 2026-02-16T00:00:00Z"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Data.value.Count

# $Data.value | Format-List
$timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
$Data.value | Export-Csv -Path "$home\code\m365-PowerShell\.data\ACS-Audit\$reportPath-$timestamp.csv"

$Data.value | Format-List | clip
$Data.value | Select-Object -Property appId, appDisplayName, createdDateTime, status | Format-List | clip
$Data.value[0] | Format-List 
$Data.value[0].status.additionalDetails | Format-List 
$Data.value[-1] | Format-List 

$Data.value | ?{$_.clientAppUsed -ne "Browser"} | Select-Object -First 1 | Format-List


# "signIns"
$Data.value | Select-Object -ExpandProperty userDisplayName | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty userId | Sort-Object -Unique | Format-List
$Data.value | Select-Object clientAppUsed -ExpandProperty clientAppUsed | Sort-Object -Unique | Format-List
$Data.value | Select-Object appId -ExpandProperty appId | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty authenticationProtocol | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty userAgent | Sort-Object -Unique | Format-List
$Data.value | Select-Object -ExpandProperty authenticationProcessingDetails | Select-Object -Last 5 | Format-List 
$Data.value | Select-Object -ExpandProperty authenticationDetails | Select-Object -First 5 | Format-List 


$Data.value | ?{$_.activityDisplayName -eq "Add service principal"} | Format-List
$Data.value | ?{$_.targetResources.DisplayName -like "KBA-ACS-App-01"} | Select-Object -First 3 | Format-List 
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Format-List
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Select-Object -ExpandProperty targetResources | Select-Object -ExpandProperty displayName | Sort-Object -Unique | Format-List
$Data.value | ?{$_.activityDisplayName -eq "Add app role assignment to service principal"} | Select-Object -ExpandProperty targetResources | Format-List

