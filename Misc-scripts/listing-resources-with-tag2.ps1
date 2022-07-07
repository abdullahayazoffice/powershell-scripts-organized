$results = @()
$groups = Get-AzureRmResourceGroup 
foreach($group in $groups){
    if($group.Tags.SquId -ne $null){
        $results += New-Object PSObject -Property @{
                    ResourceGroupName = $group.ResourceGroupName;
                    SquId = $group.Tags.SquId
                }
       }
}
$results | Export-Csv -Path C:\Users\joyw\Desktop\tag.csv -NoTypeInformation