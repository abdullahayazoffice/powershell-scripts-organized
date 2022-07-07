#Login to your Azure Subscription using az login before running the script
$AppServices = @(
az webapp list | ConvertFrom-Json
az functionapp list | ConvertFrom-Json
)
$VNetAppServices = foreach ($App in $AppServices) {    
    $Apps = Get-AzPrivateLinkResource -PrivateLinkResourceId $App.ID
    if ([bool]$Apps -eq $true) {
       
        [PSCustomObject]@{
            AppServiceName = $Apps.Name
           
            ResourceGroup  = $Apps.ResourceGroup
            Location       = $Apps.Location
   
        }
    }    
}
$VNetAppServices | Export-CSV enpoint-list.csv