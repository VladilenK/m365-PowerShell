Connect-MgGraph -Scopes "Mail.Read"
Get-MgUserMessage -UserId $userId

Find-MgGraphCommand -Command 'Get-MGAuditlogsignin' 
Find-MgGraphCommand -Uri 'sites'
Find-MgGraphCommand -Command 'Get-MGSite' | select permissions

Get-MgProfile
Select-MgProfile -Name beta

Disconnect-MgGraph
Connect-MgGraph -ClientId "0922a1f0-0a8b-4a08-a316-e137500ab9ce" -TenantId "887d660e-c53f-4c38-af69-214fe2a73f0a" -CertificateThumbprint "4536C377039C16256A6328F6B1A70E08E19A1B5E"

$period = -7
$date = (Get-Date).AddDays($period)
$sDate = $date.ToString("yyyy-MM-dd")
Get-MgAuditLogSignIn 

$reportFilePath = 'C:\Temp\mg-report-test.csv'
# New-Item -Path $reportFilePath -Force
Remove-Item -Path $reportFilePath -Force
Get-MgReportYammerActivityUserDetail -Period 'D90' -OutFile $reportFilePath
Import-Csv -Path $reportFilePath | Out-GridView

$uri = "https://graph.microsoft.com/v1.0/reports/getSharePointActivityUserDetail(period='D7')"
Invoke-MgGraphRequest -Method GET -Uri $uri -OutputFilePath $reportFilePath
Import-Csv -Path $reportFilePath | Out-GridView

Get-Command -Module Microsoft.Graph.Authentication 
Get-Command -Module Microsoft.Graph.Identity | ? { $_.Name -like "*token*" }





