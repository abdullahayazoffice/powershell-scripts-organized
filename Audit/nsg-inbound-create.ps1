#Login-AzAccount
Get-AzSubscription
Set-AzContext -SubscriptionId "562411ec-a015-4e89-9023-e948e2eb2e22"

$RGname="RG-vnet"
$port=8081
$rulename="allowAppPort$port"
$nsgname="vm1-nsg"

# Get the NSG resource
$nsg = Get-AzNetworkSecurityGroup -Name $nsgname -ResourceGroupName $RGname

# Add the inbound security rule.
$nsg | Add-AzNetworkSecurityRuleConfig -Name $rulename -Description "Allow app port" -Access Allow `
    -Protocol * -Direction Inbound -Priority 3891 -SourceAddressPrefix "*" -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange $port

# Update the NSG.
$nsg | Set-AzNetworkSecurityGroup