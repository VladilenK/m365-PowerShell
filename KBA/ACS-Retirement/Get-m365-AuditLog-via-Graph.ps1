
$headers | ft -a

# 

#################################
# Audit logs
$reportPath = "m365AuditLog" 

# submit a query
$apiUrl = "https://graph.microsoft.com/beta/security/auditLog/queries"
$requestBody = @{
  displayName         = "My audit search 01"
  filterStartDateTime = "2026-02-23T00:00:00Z"
  filterEndDateTime   = "2026-02-24T23:59:59Z"
  recordTypeFilters   = @("sharePointFileOperation")
} | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Post -Body $requestBody -ContentType "application/json"
$response

# Check query status

$apiUrl = "https://graph.microsoft.com/beta/security/auditLog/queries/" + $response.id
Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get

# get query results

$apiUrl = "https://graph.microsoft.com/v1.0/security/auditLog/queries/" + $response.id + "/records"
Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get

