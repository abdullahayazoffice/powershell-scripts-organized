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