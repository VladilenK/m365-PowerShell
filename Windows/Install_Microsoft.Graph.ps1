Get-InstalledModule -Name Microsoft.Graph
Get-Module Microsoft.Graph
Get-Module Microsoft.Graph -ListAvailable 
Get-Module Microsoft.Graph -ListAvailable | ft name, Version, Path 
Find-Module Microsoft.Graph
Install-Module Microsoft.Graph

Import-Module Microsoft.Graph
Get-Module Microsoft.Graph


Update-Module -Name Microsoft.Graph

#################################################################
Get-Module Microsoft.Graph.Authentication -ListAvailable
Update-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Identity.DirectoryManagement
Get-Module Microsoft.Graph.Identity.DirectoryManagement

Get-Module Microsoft.Graph.Identity.DirectoryManagement -ListAvailable
Update-Module Microsoft.Graph.Identity.DirectoryManagement
Import-Module Microsoft.Graph.Authentication
Get-Module Microsoft.Graph.Authentication

