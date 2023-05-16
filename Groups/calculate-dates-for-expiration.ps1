$dateTarget = Get-Date -Date '2020-11-15'
$dateTarget = Get-Date -Date '2020-12-01'
$dateToday = Get-Date

#setup policy expiration date
($dateToday - $dateTarget).TotalDays + 30 # to hit the group 30 days before expiration
($dateToday - $dateTarget).TotalDays + 30 + 5 + 5  # 5 days before 35 days

$dateToday.AddDays(-924).AddDays(30)
$dateTarget.AddDays(931).AddDays(-30)

$messageCame = Get-Date -Date '2023-05-04'
$messageExpDate = Get-Date -Date '2023-06-08'
$messageExpDate - $messageCame 
# for already expired groups messages come 35 days before expiration ?

(Get-Date -Date '2023-05-06') - (Get-Date -Date '2020-11-17')
(Get-Date -Date '2023-05-06') - (Get-Date -Date '2020-11-17')
(Get-Date -Date '2023-06-18') - (Get-Date -Date '2023-05-15')
(Get-Date -Date '2023-06-18') - (Get-Date -Date '2021-01-05') ; 924 - 894 


