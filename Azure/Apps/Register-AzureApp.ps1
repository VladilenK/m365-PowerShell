
Connect-PnPOnline -Url $adminUrl -ClientId $clientid -Interactive 
Get-PnPSite
Get-PnPAzureADApp

$graphScopes = @("Sites.Selected")
$spoScopes = @("Sites.Selected")
$appName = "KBA-ACS-App-00-tst-04"
Register-PnPAzureADApp -Interactive -ApplicationName $appName -Tenant $tenantId -CertificatePath $certPath -CertificatePassword $certPass -Username $adminUPN -GraphApplicationPermissions $graphScopes -SharePointApplicationPermissions $spoScopes 


# bulk
01..06 | ForEach-Object {
    # $timestamp = Get-Date -Format "yyyy-MM-dd--hh-mm"
    $appName = "KBA-ACS-App-{0:00}" -f $_
    Write-Host "Creating an app:" $appName -NoNewline
    Register-PnPAzureADApp -Interactive -ApplicationName $appName -Tenant $tenantId -CertificatePath $certPath -CertificatePassword $certPass -Username $adminUPN -GraphApplicationPermissions $graphScopes -SharePointApplicationPermissions $spoScopes 
    Write-Host ""
    Start-Sleep -Seconds 1
} 
