$resourceGroupName = "<Resource group name>"
$vnetName = "<Virtual network name>"
$subnetName = "<Subnet name>"
$subnetPrefix = "<Subnet address range>"
$serviceEndpoint = "Microsoft.AzureCosmosDB"

Get-AzVirtualNetwork `
   -ResourceGroupName $resourceGroupName `
   -Name $vnetName | Set-AzVirtualNetworkSubnetConfig `
   -Name $subnetName `
   -AddressPrefix $subnetPrefix `
   -ServiceEndpoint $serviceEndpoint | Set-AzVirtualNetwork
   $vnet = Get-AzVirtualNetwork `
   -ResourceGroupName $resourceGroupName `
   -Name $vnetName

$subnetId = $vnet.Id + "/subnets/" + $subnetName
$vnetRule = New-AzCosmosDBVirtualNetworkRule `
   -Id $subnetId
 $accountName = "<Cosmos DB account name>"

Update-AzCosmosDBAccount `
   -ResourceGroupName $resourceGroupName `
   -Name $accountName `
   -EnableVirtualNetwork $true `
   -VirtualNetworkRuleObject @($vnetRule)  
   $account = Get-AzCosmosDBAccount `
   -ResourceGroupName $resourceGroupName `
   -Name $accountName

$account.IsVirtualNetworkFilterEnabled
$account.VirtualNetworkRules