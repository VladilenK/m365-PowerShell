# getting sites in bulk using Get-PnPTenantSite
# connect as admin 

# regular:
$timeStart = Get-Date
$i = 0
# 401..421 | ForEach-Object {
Get-Random -Minimum 1 -Maximum 500 -Count 20 | ForEach-Object {
    $i++
    $Url = "https://uhgdev.sharepoint.com/teams/Test-Parallel-{0:000}" -f $_
    $pnpTenantSite = Get-PnPTenantSite -Identity $Url -Detailed -Connection $connection
    if ($?) { Write-Host "*" -ForegroundColor Green -NoNewline } else { Write-Host "`n0" -ForegroundColor Yellow }
    if ($pnpTenantSite.Url -eq $Url) { } else { Write-Host "`n0" -ForegroundColor Yellow }
}
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.000}" -f ($timeElapsed.TotalSeconds / $i)


$sites = Get-PnPTenantSite -Connection $connection -Filter  "Url -like 'Test-Parallel-'"
$sites.count
$count = 500
$sites = $sites | Get-Random -Count $count
$sites.count

# parallel:
$i = 0
$errorsLog = @()
$timeStart = Get-Date
# Get-Random -Minimum 1 -Maximum 500 -Count $count | ForEach-Object -Parallel {
Start-Sleep -Seconds 3    
$sites | ForEach-Object -Parallel {
    $_ | Add-Member -MemberType NoteProperty -Name "MyStatus" -Value $null -Force
    $counter = $using:i; $counter++
    $err = $using:errorsLog
    # $Url = "https://uhgdev.sharepoint.com/teams/Test-Parallel-{0:000}" -f $_
    $Url = $_.Url
    $pnpTenantSite = $null
    $pnpTenantSite = Get-PnPTenantSite -Identity $Url -Detailed -Connection $using:connection -ErrorAction SilentlyContinue
    if ($pnpTenantSite.Url -eq $Url) { 
        $_.MyStatus = "OK1"
        Write-Host "*" -ForegroundColor Green -NoNewline 
    }
    else { 
        $_.MyStatus = "Err1"
        Write-Host "0" -ForegroundColor Yellow; $err += $_ 
        Start-Sleep -Seconds 3
        $pnpTenantSite = $null
        $pnpTenantSite = Get-PnPTenantSite -Identity $Url -Detailed -Connection $using:connection
        if ($pnpTenantSite.Url -eq $Url) { 
            Write-Host "*" -ForegroundColor DarkGreen -NoNewline 
            $_.MyStatus = "OK2"
        }
        else { 
            Write-Host "`n0" -ForegroundColor DarkMagenta; $err += $_ 
            Write-Host $_.Url.TrimStart('https://uhgdev.sharepoint.com/teams/Test-Parallel-')
            $_.MyStatus = "Err2"
        }
    }
    $_.Description = $pnpTenantSite.Url    
} -ThrottleLimit 20
$timeFinish = Get-Date
$timeElapsed = $timeFinish - $timeStart
$timeElapsed.TotalSeconds
"{0:000.000}" -f ($timeElapsed.TotalSeconds / $count)
$sites.Count

return
$sites | ? { $_.Description -ne $_.Url } | select -First 1 | fl
$sites | ? { $_.Description -ne $_.Url } | select Description, Url
$sites | ? { $_.MyStatus -ne "OK1" } | select MyStatus, Description, Url
$sites | select MyStatus, Description, Url

$ind = 0
$sites[$ind] | fl
$pnpTenantSite = Get-PnPTenantSite -Identity $sites[$ind].Url -Detailed -Connection $connection
$pnpTenantSite | fl
