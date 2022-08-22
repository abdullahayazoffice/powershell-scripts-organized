
Set-AzContext  -SubscriptionName "Microsoft Azure"
 $rgs = Get-AzResourceGroup
 $cosmosdata=Foreach ($rg in $rgs) {
( Get-AzCosmosDBAccount -ResourceGroupName ($rg.ResourceGroupName)) 

 }
 $cosmosdata|Get-Process outlook | Select -ExpandProperty threads Export-Csv cosmosdb.csv