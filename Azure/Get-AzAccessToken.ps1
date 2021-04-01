Connect-AzAccount -Tenant "046d11d6-08e0-4d20-a743-562836cdcab5"
# $azAccessToken = Get-AzAccessToken -ResourceTypeName AadGraph
# $azAccessToken = Get-AzAccessToken 
# $azAccessToken = Get-AzAccessToken -Resource "https://graph.windows.net/" 
$azAccessToken = Get-AzAccessToken -Resource "https://graph.microsoft.com" 

# Create header
$Headers = @{
  'Authorization' = "$($azAccessToken.Type) $($azAccessToken.Token)"
}

# me
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

