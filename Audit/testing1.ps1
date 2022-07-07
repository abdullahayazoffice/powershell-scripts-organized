 $allWebApps =Get-AzFunctionApp

   foreach ($app in $allWebApps){

  $Properties = az functionapp vnet-integration list --name $app.Name --resource-group $app.ResourceGroupName | Add-content file1.csv
  
  
   }