#$resourceGroupName = "test-cnet-inte"
$serviceEndpoint = "Microsoft.AzureCosmosDB"
$subnetName = "Default"
$subnetPrefix = "10.2.0.0/24"
$vnet = Get-AzVirtualNetwork  -ResourceGroupName $resourceGroupName 
Get-AzVirtualNetwork `
   -ResourceGroupName $resourceGroupName `
   -Name $vnet.Name | Set-AzVirtualNetworkSubnetConfig `
   -Name $subnetName `
   -AddressPrefix $subnetPrefix `
   -ServiceEndpoint $serviceEndpoint | Set-AzVirtualNetwork

$vnet = Get-AzVirtualNetwork  -ResourceGroupName $resourceGroupName 
$subnetId = $vnet.Id + "/subnets/" + $subnetName
$vnetRule = New-AzCosmosDBVirtualNetworkRule  -Id $subnetId
$accountName = Get-AzCosmosDBAccount  -ResourceGroupName $resourceGroupName
Update-AzCosmosDBAccount `
   -ResourceGroupName $resourceGroupName `
   -Name $accountName.Name `
   -EnableVirtualNetwork $true `
   -VirtualNetworkRuleObject @($vnetRule)


   $account = Get-AzCosmosDBAccount `
   -ResourceGroupName $resourceGroupName `
   -Name $accountName.Name

$account.IsVirtualNetworkFilterEnabled
$account.VirtualNetworkRules
#the integration of azure storage cosmos DB is completed 



#$resourceGroupName = "RG-cosmosDB"
$serviceEndpoint = "Microsoft.AzureCosmosDB"
$subnetName = "default"

$vnet = Get-AzVirtualNetwork  -ResourceGroupName $resourceGroupName 




$storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName
Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourceGroupName -Name $storageAccount.StorageAccountName -DefaultAction Deny
Register-AzProviderFeature -ProviderNamespace Microsoft.Network -FeatureName AllowGlobalTagsForStorage 
Get-AzProviderFeature -ProviderNamespace Microsoft.Network -FeatureName AllowGlobalTagsForStorage
(Get-AzStorageAccountNetworkRuleSet -ResourceGroupName $resourceGroupName -AccountName $storageAccount.StorageAccountName).VirtualNetworkRules
#Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnet.Name | Set-AzVirtualNetworkSubnetConfig -Name $subnetName -AddressPrefix $subnetPrefix -ServiceEndpoint "Microsoft.Storage" | Set-AzVirtualNetwork
Get-AzVirtualNetwork `
   -ResourceGroupName $resourceGroupName `
   -Name $vnet.Name | Set-AzVirtualNetworkSubnetConfig `
   -Name $subnetName `
   -AddressPrefix $subnetPrefix `
   -ServiceEndpoint Microsoft.Storage | Set-AzVirtualNetwork
$subnet = Get-AzVirtualNetwork -ResourceGroupName $resourceGroupName -Name $vnet.Name | Get-AzVirtualNetworkSubnetConfig -Name $subnetName
Add-AzStorageAccountNetworkRule -ResourceGroupName $resourceGroupName -Name $storageAccount.StorageAccountName -VirtualNetworkResourceId $subnet.Id