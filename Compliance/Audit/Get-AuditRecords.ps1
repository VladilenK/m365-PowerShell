#Modify the values for the following variables to configure the audit log search.
[DateTime]$start = [DateTime]::UtcNow.AddHours(-3)
[DateTime]$start = [DateTime]::UtcNow.AddDays(-30)
[DateTime]$end = [DateTime]::UtcNow
$resultSize = 5000

$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize 
$results.Count


$freeText = "test"
$operations = 'Add service principal.'
$recordType = 'AzureActiveDirectory'
$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize -Formatted -Operations $operations -RecordType $recordType
Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize -Formatted -Operations $operations -RecordType $recordType
$results.Count

$results | select -Last 10 | ft -a CreationDate, Operations, RecordType, UserIds
$results | select -First 10 | ft -a CreationDate, Operations, RecordType, UserIds
$results | select -First 100 | ft -a CreationDate, Operations, RecordType, UserIds

$results | select -First 100 | clip

Search-UnifiedAuditLog -ObjectIds 

