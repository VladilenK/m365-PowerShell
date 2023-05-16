$groups = Get-PnPMicrosoft365Group -IncludeSiteUrl -IncludeOwners -IncludeClassification -IncludeHasTeam

$groups | Sort-Object CreatedDateTime | Select-Object -First 15
$groups | Sort-Object CreatedDateTime | Select-Object -First 15 | fl | clip

$groups | Sort-Object CreatedDateTime | Export-Csv -Path "$HOME\Desktop\tmp.csv"

$groups | Sort-Object CreatedDateTime | Select-Object MailNickname, @{Name = "OwnersCount"; Expression = { $_.Owners.count } }

