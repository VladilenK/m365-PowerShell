# always specify PageSize (if not specified - it returns 1) 

$connectionAdmin = Connect-PnPOnline -ReturnConnection -Url $adminUrl -ClientId $clientid -ClientSecret $clientSc 
$connectionAdmin.url

Get-PnPExternalUser -Connection $connectionAdmin -PageSize 20

