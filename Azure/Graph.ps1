# me
Invoke-RestMethod -Uri 'https://graph.microsoft.com/v1.0/me' -Headers $Headers

# Get all users
$apiUrl = "https://graph.microsoft.com/v1.0/users/"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Users = ($Data | Select-Object Value).Value 
$Users | Format-Table displayName, userPrincipalname, id

# list teams
$apiUrl = "https://graph.microsoft.com/beta/groups?`$filter=resourceProvisioningOptions/Any(x:x eq 'Team')"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Teams = ($Data | select-object Value).Value | Select-Object displayName, id, description
$Teams[-1]
$teamId = "648f5a8b-53e2-4602-a2cb-a3af9828ff8b" # Learning


# groups
$apiUrl = 'https://graph.microsoft.com/v1.0/Groups/'
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$Groups = ($Data | select-object Value).Value
$Groups | Format-Table DisplayName, Description -AutoSize

# not working:

# OneDrive get
$apiUrl = 'https://graph.microsoft.com/v1.0/me/drive/root/children'
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$DriveItems = ($Data | Select-Object Value).Value 
$DriveItems | Select-Object name, size, id

# events
$apiUrl = "https://graph.microsoft.com/v1.0/me/calendar/events"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$CalEvents = ($Data | Select-Object Value).Value 
$CalEvents | Select-Object -Property subject, importance, showAs, @{Name = 'Location'; Expression = { $_.location.displayname } }, @{Name = 'Response'; Expression = { $_.responseStatus.response } }, @{Name = 'Start'; Expression = { $_.start.dateTime.Replace(":00.0000000", "").Replace("T", " ") } }, @{Name = 'End'; Expression = { $_.End.dateTime.Replace(":00.0000000", "").Replace("T", " ") } } | Format-Table 
$CalEvents

# send an email
$apiUrl = "https://graph.microsoft.com/v1.0/me/sendMail"
$body = @"
{
  "Message": {
    "Subject": "Did you see that ludicrous display last night?",
    "importance":"High",
    "Body": {
      "ContentType": "Text",
      "Content": "Thing about Arsenal is, they always try and walk it in."
    },
    "ToRecipients": [
      {
        "EmailAddress": {
          "Address": "vlad@sd.kz"
        }
      }
    ]
  },
  "SaveToSentItems": "false",
  "isDraft": "false"
}
"@
Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'

# OneDrive
$apiUrl = 'https://graph.microsoft.com/v1.0/me/drive/root:/FileTESTING.txt:/content'
$body = "test the file creation via Microsoft Graph API
This would be my second line
And this is my 3rd line
Bye!
"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Put -Body $body -ContentType "text/plain" 

# list teams channels
$apiUrl = "https://graph.microsoft.com/beta/teams/$teamId/channels"
$apiUrl = "https://graph.microsoft.com/v1.0/teams/$teamId/channels"
$Data = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Method Get
$TeamChannels = ($Data | select-object Value).Value
$TeamChannels
$channel = $TeamChannels[-1]
$channel

# message in channel chat
$channelid = 
$apiUrl = "https://graph.microsoft.com/beta/teams/$teamId/channels/$channelId@thread.skype/messages"
$body = @"
{ 
"body": { 
    "content": "Hello Management team! This is being sent to you from PowerShell!" 
     } 
 }
"@

Invoke-RestMethod -Headers @{Authorization = "Bearer $($Tokenresponse.access_token)" } -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'

##########################################

# search
$apiUrl = "https://graph.microsoft.com/beta/search/query"
$body = @"
{ 
  "requests": [
    {
      "entityTypes": [
        "driveItem"
      ],
      "query": {
        "queryString": "test"
      }
    }
  ]
}
"@

$res = Invoke-RestMethod -Headers $Headers -Uri $apiUrl -Body $Body -Method Post -ContentType 'application/json'
$res.value[0].searchTerms
$res.value[0].hitsContainers[0].hits




