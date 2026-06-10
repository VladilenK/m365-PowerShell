# this script is designed to retrieve the hierarchy of direct reports for a given user in Azure AD using Microsoft Graph API. 
# It includes functions to get authentication headers, retrieve user information, and recursively get all direct reports.


function Get-AuthHeaders {
    [CmdletBinding()]
    param (
        $config
    )
        
    $tenantId = $config.tenantId
    $uri = "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/token"
    $body = @{
        client_id     = $config.clientId
        scope         = "https://graph.microsoft.com/.default"
        client_secret = $config.clientSecret
        grant_type    = "client_credentials" 
    }

    # Get OAuth 2.0 Token
    $tokenRequest = Invoke-WebRequest -Method Post -Uri $uri -ContentType "application/x-www-form-urlencoded" -Body $body -UseBasicParsing
    # $tokenRequest.StatusDescription

    # Unpack Access Token
    $token = ($tokenRequest.Content | ConvertFrom-Json).access_token

    # Base URL
    $headers = @{Authorization = "Bearer $token" }
    return $headers
}

function Get-User {
    param (
        [string]$upn
    )
    $apiUrl = "https://graph.microsoft.com/v1.0/users/$upn" + "?`$select=id,userPrincipalName,mail,displayName,accountEnabled,directReports"
    $user = Invoke-RestMethod -Headers $headers -Uri $apiUrl -Method Get
    $user | Add-Member -MemberType NoteProperty -Name "Level" -Value $level -Force
    $user | Add-Member -MemberType NoteProperty -Name "Manager" -Value $level -Force
    return $user
}

function Get-DirectReports {
    param (
        [string]$upn,
        [int]$level = 1
    )

    $apiUrl = "https://graph.microsoft.com/v1.0/users/$upn/directReports"
    $data = Invoke-RestMethod -Headers $headers -Uri $apiUrl -Method Get
    $directReports = @()
    foreach ($reportee in $data.value) {
        $user = Get-User -upn $reportee.userPrincipalName        
        $user.Level = $level
        $user.Manager = $upn
        $directReports += $user
    }
    return $directReports
}

function Get-AllReports { 
    param (
        [string]$upn,
        [bool]$includeLeader     = $false,
        [int]$level         = 1
    )

    $reports = @()
    if ($includeLeader) {
        $leader = Get-User -upn $upn 
        $leader.Level = $level
        $leader.Manager = $null
        $reports += $leader
    }
    $level += 1
    $directReports = Get-DirectReports -upn $upn -level $level
    foreach ($report in $directReports) {
        $reports += $report
        $reports += Get-AllReports -upn $report.userPrincipalName -level $level
    }
    return $reports
}

# Main Script

$Path = "./Solutions/HierarchyReports/Config.psd1"
Test-Path -Path $Path 
$config = Import-PowerShellDataFile -Path $Path -Verbose
$orgname = $config.orgname
$headers = Get-AuthHeaders -config $config
$headers["Authorization"].Substring(0, 20) + "..." # show the first 20 characters of the token for verification

$upn = "miriamg@$orgname.onmicrosoft.com"
$upn = "pattif@$orgname.onmicrosoft.com"

$user = Get-User -upn $upn
$directReports = Get-DirectReports -upn $upn
$directReports.count

$allReports = Get-AllReports -upn $upn -includeLeader $true -level 3
$allReports = Get-AllReports -upn $upn -level 5
$allReports = Get-AllReports -upn $upn -includeLeader $true
$allReports.count
$allReports | Sort-Object Level | ft -AutoSize displayName, userPrincipalNamem, accountEnabled, Level, Manager

