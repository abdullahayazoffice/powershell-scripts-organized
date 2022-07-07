 $allWebApps =Get-AzFunctionApp
  //$AllMyWebApps = @()
   foreach ($app in $allWebApps){

az functionapp vnet-integration list --name $app.Name --resource-group $app.ResourceGroupName | export-csv function-app-vnet.csv

   }