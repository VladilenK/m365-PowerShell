Import-Module Microsoft.Graph

Connect-MgGraph -Scopes "Application.Read.All"
Get-MgContext

Get-MgServicePrincipal 
Get-MgServicePrincipal | ft DisplayName, AppId, ServicePrincipalType

$legacyServicePrincipals = Get-MgServicePrincipal -Filter { ServicePrincipalType eq 'Legacy' } 
$legacyServicePrincipals = Get-MgServicePrincipal -All
$legacyServicePrincipals.count

# remove any principals that don't have KeyCredentials (Workflow, Napa, etc.)
$legacyServicePrincipals = $legacyServicePrincipals | Where-Object -Property KeyCredentials
$legacyServicePrincipals.count
$legacyServicePrincipals

$results = @()

foreach( $legacyServicePrincipal in $legacyServicePrincipals )
{
    $results += [PSCustomObject] @{
                    ServicePrincipalId    = $legacyServicePrincipal.Id
                    ClientId              = $legacyServicePrincipal.AppId
                    DisplayName           = $legacyServicePrincipal.DisplayName
                    CreatedDate           = $legacyServicePrincipal.AdditionalProperties["createdDateTime"]
                    RedirectURL           = $legacyServicePrincipal.ReplyUrls -join ','
                    AppDomain             = $legacyServicePrincipal.ServicePrincipalNames[-1] -replace "$($legacyServicePrincipal.AppId)/", ""
                    StartDateTime         = $legacyServicePrincipal.KeyCredentials | SELECT -First 1 -ExpandProperty StartDateTime
                    EndDateTime           = $legacyServicePrincipal.KeyCredentials | SELECT -First 1 -ExpandProperty EndDateTime
                }
}

$results | Export-Csv -Path "SharePointAppPrincipals.csv" -NoTypeInformation