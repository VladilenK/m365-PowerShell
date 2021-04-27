#Modify the values for the following variables to configure the audit log search.
[DateTime]$start = [DateTime]::UtcNow.AddHours(-3)
[DateTime]$end = [DateTime]::UtcNow
$resultSize = 5000

$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize 
$results.Count

$freeText = "TestLoggingApp01"
$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize -FreeText $freeText
$results | select -Last 10 | ft -a CreationDate, Operations, RecordType, UserIds
$results | select -First 10 | ft -a CreationDate, Operations, RecordType, UserIds
$results | select -First 100 | ft -a CreationDate, Operations, RecordType, UserIds

$results | select -First 100 | clip

Search-UnifiedAuditLog -ObjectIds 

