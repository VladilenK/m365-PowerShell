
#Modify the values for the following variables to configure the audit log search.
[DateTime]$start = [DateTime]::UtcNow.AddHours(-12)
[DateTime]$end = [DateTime]::UtcNow
$resultSize = 5000

$freeText = "appregnew"
$operations = 'PageViewed'
$recordType = 'SharePoint'

$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize -FreeText $freeText -Operations $operations -RecordType $recordType
$results.count
$results | select -Last 10 | ft -a CreationDate, Operations, RecordType, UserIds

$results = Search-UnifiedAuditLog -StartDate $start -EndDate $end -ResultSize $resultSize 
$results.Count
