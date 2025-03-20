$baererToken = "Put your baerer token here"

$headers = @{ Authorization = ("Bearer " + $baererToken) }
$webRequest = Invoke-WebRequest –Uri "https://www.yammer.com/api/v1/messages.json" –Method Get -Headers $headers
$results = $webRequest.Content | ConvertFrom-Json

$results.messages | ForEach-Object {
    $message = $_ 
    Write-Host "Message Id:" $message.id
    Write-Host "Message body:" $message.body.parsed
}

Invoke-WebRequest –Uri "https://www.yammer.com/api/v1/users.json" –Method Get -Headers $headers | ConvertFrom-Json | select email

# search:
$YammerApiURL = "https://www.yammer.com/api/v1/search.json?search=Test*"
$results = Invoke-WebRequest –Uri $YammerApiURL –Method Get -Headers $headers | ConvertFrom-Json 
$results
$results.count
$results.users[0]
$results.messages.messages[0].body.parsed





# admin only:
Invoke-WebRequest –Uri "https://export.yammer.com/api/v1/export?since=2020-02-09T00:00:00+00:00" –Method Get -Headers $headers 





