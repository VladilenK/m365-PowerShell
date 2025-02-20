# creating sites in bulk using New-PnPTenantSite

Connect-PnPOnline -Url $adminUrl -ClientId $ClientId -Tenant $tenantId -Thumbprint $certThumbprint 
Connect-PnPOnline -Url $adminUrl -ClientId $clientid -Interactive 
Get-PnPSite

# regular:
$timeStart = Get-Date
01..10 | ForEach-Object {
    # $timestamp = Get-Date -Format "yyyy-MM-dd--HH-mm"
    $title = "KBA-ACS-Site-{0:00}" -f $_
    $Url = "https://$orgname.sharepoint.com/sites/" + $title
    $owner = $userUPN
    Write-Host "Creating a new site:" $title -NoNewline
    New-PnPTenantSite -Title $title -Url $url -Owner $adminUPN -Template "STS#3" -TimeZone "6" 
    Write-Host ""
    Start-Sleep -Seconds 1
} 
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.0}" -f ($timeElapsed.TotalSeconds / 10)



# return
$sites = Get-PnPTenantSite -Filter "Url -like 'https://$orgname.sharepoint.com/sites/KBA-ACS-Site-*'" 
$sites = Get-PnPTenantSite
$sites.count
$sites = $sites | ?{ $_.Title -like "Test-Parallel*" }
$sites.count
$sites[0].Title
$sites[-1].Title
$sites | Sort-Object Title | Select-Object Title, Url | Select-Object -First 3 | Format-Table -AutoSize
$sites | Sort-Object Title | Select-Object Title, Url | Select-Object -Last 3 | Format-Table -AutoSize

$sites[0..2] | foreach { 
    Remove-PnPMicrosoft365Group -Identity $_.GroupId 
}
$sites | foreach { 
    Remove-PnPMicrosoft365Group -Identity $_.GroupId 
}


