Connect-AZAccount  
Set-AzContext  -SubscriptionName "Microsoft Azure"
 $rgs = Get-AzResourceGroup
 Foreach ($rg in $rgs) {
  $tags += @{Owner="PartnerLinQ";BU="PartnerLinQ"; Company="VSI";Schedule="24x7";Client="N/A";Project="Name of Client";Environment="PRD/DEV";Dept="PartnerLinQ";DeleteOn="N/A";CreationDate="N/A";Name="N/A"}
 Update-AzTag -ResourceId $rg.ResourceId -Tag $tags -Operation Merge

 }