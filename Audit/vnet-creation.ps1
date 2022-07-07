$vnet = @{
    Name = 'myVNet'
    ResourceGroupName = 'RG-vne'

    Location = 'UAE North'
    AddressPrefix = '10.0.0.0/16'    
}
$virtualNetwork = New-AzVirtualNetwork @vnet
$subnet = @{
    Name = 'default'
    VirtualNetwork = $virtualNetwork
    AddressPrefix = '10.0.0.0/24'
}
$subnetConfig = Add-AzVirtualNetworkSubnetConfig @subnet
$virtualNetwork | Set-AzVirtualNetwork