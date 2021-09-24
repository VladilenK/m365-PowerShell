# PowerShell Script to get alerts from a site collection in SharePoint Online 
# Prerequisites: Configured Azure App, PnP.PowerShell module 
#
# based on Salaudeen Rajack: https://www.sharepointdiary.com/2017/11/sharepoint-online-powershell-to-get-all-alerts-from-site-collection.html

#Config Parameters
$SiteURL = "" # specify site collection Url
$ReportOutput = "C:\Temp\AlertsRpt.csv"

# $appId = "" # app registerd in Azure with delegated permissions to SharePoint

#Load SharePoint CSOM Assemblies
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
    
Function Get-SPOWebAlerts($SiteURL) {
    Connect-PnPOnline -ClientId $AppId -Interactive -Url $siteUrl # -ForceAuthentication
    $ctx = Get-PnPContext 
    Try {
        Write-host -f Yellow "Getting Alerts in the site" $SiteURL
        Write-host -f Yellow "Context:" $Ctx.Url
        #Get All Alerts from the Web
        $Web = $Ctx.Web
        $WebAlerts = $Web.Alerts
        $Ctx.Load($Web)
        $Ctx.Load($web.Webs)
        $Ctx.Load($WebAlerts)
        $Ctx.ExecuteQuery()
 
        If ($WebAlerts.count -gt 0) { Write-host -f Green "Found $($WebAlerts.Count) Alerts!" }
 
        $AlertCollection = @()
        #Loop through each alert of the web and get alert details
        ForEach ($Alert in $webAlerts) {
            #Get Alert list and User
            $Ctx.Load($Alert.User)
            $Ctx.Load($Alert.List)
            $Ctx.ExecuteQuery()
 
            $AlertData = New-Object PSObject
            $AlertData | Add-Member NoteProperty SiteName($Web.Title)
            $AlertData | Add-Member NoteProperty SiteURL($Web.URL)
            $AlertData | Add-Member NoteProperty AlertTitle($Alert.Title)
            $AlertData | Add-Member NoteProperty AlertUser($Alert.User.Title)
            $AlertData | Add-Member NoteProperty AlertList($Alert.List.Title)
            $AlertData | Add-Member NoteProperty AlertFrequency($Alert.AlertFrequency)
            $AlertData | Add-Member NoteProperty AlertType($Alert.AlertType)
            $AlertData | Add-Member NoteProperty AlertEvent($Alert.EventType)
                       
            #Add the result to an Array
            $AlertCollection += $AlertData
        }
        #Export Alert Details to CSV file
        $AlertCollection | Export-CSV $ReportOutput -NoTypeInformation -Append
 
        #Iterate through each subsite of the current web and call the function recursively
        foreach ($Subweb in $web.Webs) {
            #Call the function recursively to process all subsites underneath the current web
            Get-SPOWebAlerts($Subweb.url)
        }
    }
    Catch {
        write-host -f Red "Error Getting Alerts!" $_.Exception.Message
    }
}

#Delete the Output Report, if exists
if (Test-Path $ReportOutput) { Remove-Item $ReportOutput }
 

#Call the function
Get-SPOWebAlerts($SiteURL)

