$groups = Get-PnPMicrosoft365Group -IncludeSiteUrl -IncludeOwners
$groups = Get-PnPMicrosoft365Group -Connection $connectionAdmin 
# $groups = Get-PnPMicrosoft365Group -IncludeSiteUrl -IncludeOwners -IncludeClassification -IncludeHasTeam

$myGroups = $allGroups | Where-Object { $_.DisplayName -like "ExamTest*" }
$myGroups.Count

$groups | Sort-Object CreatedDateTime | Select-Object -First 15
$groups | Sort-Object CreatedDateTime | Select-Object -First 15 | fl | clip

$groups | Sort-Object CreatedDateTime | Export-Csv -Path "$HOME\Desktop\tmp01.csv"

$groups | Sort-Object CreatedDateTime | Select-Object MailNickname, @{Name = "OwnersCount"; Expression = { $_.Owners.count } }

