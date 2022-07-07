#Login-AzAccount
Get-AzSubscription
Set-AzContext -SubscriptionId "562411ec-a015-4e89-9023-e948e2eb2e22"

$RGname="RG-vnet"
$port=443
$rulename="allowAppPort$port"
$nsgname="vm1-nsg"

# Get the NSG resource
$nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname

# Add the inbound security rulD:\Systems Limited and Visionet\Partner Linq\scripts powershelle.
$nsg | Get-AzNetworkSecurityRuleConfig -Name $rulename
Set-AzNetworkSecurityRuleConfig -Name $rulename -NetworkSecurityGroup $nsg -Description "Allow app port" -Access Allow `
    -Protocol * -Direction inbound -Priority 3941 -SourceAddressPrefix "172" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange $port

# Update the NSG.
$nsg | Set-AzNetworkSecurityGroup