
Start-process "https://docs.microsoft.com/en-us/powershell/microsoftgraph/overview?view=graph-powershell-1.0"

$moduleName = "Microsoft.Graph.Sites"
$moduleName = "Microsoft.Graph.Authentication"
$moduleName = "Microsoft.Graph.Beta.Sites"
Get-Module -Name $moduleName -ListAvailable
Find-Module -Name $moduleName 
Update-Module -Name $moduleName 
Install-Module -Force -Name $moduleName



Find-Module -Command 'get-mgusermessage'
Find-Module -Command 'get-mggroup'
Get-Module Microsoft.Graph -ListAvailable

Find-Module -Name Microsoft.Graph

Find-Module -Name Microsoft.Graph.Search
Install-Module -Name Microsoft.Graph.Search

Find-Module -Name Microsoft.Graph.Groups
Install-Module -Name Microsoft.Graph.Groups

Install-Module -Name Microsoft.Graph.Authentication 
Import-Module Microsoft.Graph.Authentication
Get-Module Microsoft.Graph.Authentication
Get-Module Microsoft.Graph.Authentication -ListAvailable | ft name, Version, Path 
UnInstall-Module -Name Microsoft.Graph.Authentication -AllVersions




Install-Module -Force -Name Microsoft.Graph.Authentication 
Install-Module -Force -Name Microsoft.Graph.Identity 
Install-Module -Force -Name Microsoft.Graph.Reports
Install-Module -Force -Name Microsoft.Graph.Groups
Install-Module -Force -Name Microsoft.Graph.Applications

Get-Module Microsoft.Graph.* -ListAvailable | ft name, Version, Path 


#########################
Import-Module Microsoft.Graph.Identity.DirectoryManagement
Get-Module Microsoft.Graph.Identity.DirectoryManagement

Get-Module Microsoft.Graph.Identity.DirectoryManagement -ListAvailable
Update-Module Microsoft.Graph.Identity.DirectoryManagement

##################################
Get-InstalledModule -Name Microsoft.Graph
Get-Module Microsoft.Graph
Get-Module Microsoft.Graph -ListAvailable 
Get-Module Microsoft.Graph -ListAvailable | ft name, Version, Path 
Get-Module Microsoft.Graph.* -ListAvailable | ft name, Version, Path 
Find-Module Microsoft.Graph
Install-Module Microsoft.Graph
UnInstall-Module Microsoft.Graph -allVersions

Get-Module Microsoft.Graph.* | UnInstall-Module



Import-Module Microsoft.Graph
Get-Module Microsoft.Graph

###########################################
# Mail
Update-Module -Name Microsoft.Graph.Mail
Install-Module -Name Microsoft.Graph.Mail
Get-Module Microsoft.Graph.Mail -ListAvailable | ft name, Version, Path 
###########################################

Get-command -Module Microsoft.Graph
Get-command -Name Get-MgServicePrincipal