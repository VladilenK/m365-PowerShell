# $baererToken = "Put your baerer token here"
$baererToken 

$headers = @{ Authorization = ("Bearer " + $baererToken) }
Invoke-WebRequest –Uri "https://www.yammer.com/api/v1/messages.json" –Method Get -Headers $headers
Invoke-WebRequest –Uri "https://www.yammer.com/api/v2/messages.json" –Method Get -Headers $headers
Invoke-WebRequest –Uri "https://api.yammer.com/api/v2/messages.json" –Method Get -Headers $headers
Invoke-WebRequest –Uri "https://api.yammer.com/v2/messages.json" –Method Get -Headers $headers
Invoke-WebRequest –Uri "https://api.yammer.com/v2/messages" –Method Get -Headers $headers
Invoke-WebRequest –Uri "https://api.yammer.com/v2/" –Method Get -Headers $headers

