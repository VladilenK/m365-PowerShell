$body
$tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
$token = ($tokenRequest.Content | ConvertFrom-Json).access_token
$headers = @{Authorization = "Bearer $token" }

$requestURI = "https://graph.microsoft.com/v1.0/reports/getSharePointSiteUsageDetail(period='D30')" 
$requestURI = "https://graph.microsoft.com/v1.0/reports/getOffice365GroupsActivityDetail(period='D30')" 
$result = (Invoke-RestMethod -Uri $requestURI -Headers $Headers -Method Get -ContentType "application/json") 
$result = $result | ConvertFrom-Csv
$result | ft
$result | ?{$_.'Group Display Name' -like '*611'}
$result[1] | fl


