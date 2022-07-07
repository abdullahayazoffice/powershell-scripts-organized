Remove-Item *.xlsx
$resources = Get-AzResource
$list =foreach($resource in $resources)
{
    if ($resource.Tags -eq $null)
    {
       [PSCustomObject]@{
            Namee = $resource.Name
            ResourceType=$resource.ResourceType
            
            
        }
        
    }
    
}
$list|Export-Excel CisData.xlsx -WorksheetName tagslist
Start-Sleep -Seconds 10
#starting the unattached disks
# Set deleteUnattachedDisks=1 if you want to delete unattached Managed Disks
# Set deleteUnattachedDisks=0 if you want to see the Id of the unattached Managed Disks
$deleteUnattachedDisks=0
$managedDisks = Get-AzDisk
$allDisks=foreach ($md in $managedDisks) {
    # ManagedBy property stores the Id of the VM to which Managed Disk is attached to
    # If ManagedBy property is $null then it means that the Managed Disk is not attached to a VM
    if($md.ManagedBy -eq $null){
        if($deleteUnattachedDisks -eq 1){
            Write-Host "Deleting unattached Managed Disk with Id: $($md.Id)"
            $md | Remove-AzDisk -Force
            Write-Host "Deleted unattached Managed Disk with Id: $($md.Id) "
        }else{  [PSCustomObject]@{
            diskname = $md.Name
            DiskRGName=$md.resourceGroupname
            
            
        }}
    }
 }
 $allDisks| Export-Excel CisData.xlsx -WorksheetName unattachedDisk
 #storage account
 Start-Sleep -Seconds 10

 
$RGs = Get-AzResourceGroup | select ResourceGroupName
$storageaccountdetails =foreach($RG in $RGs)
{
    $CurrentRG = $RG.ResourceGroupName
    $StorageAccounts = Get-AzStorageAccount -ResourceGroupName $CurrentRG | select StorageAccountName
    $StorageAccountsData =foreach ($StorageAccount in $StorageAccounts){
    $StorageAccount = $StorageAccount.StorageAccountName
    $CurrentSAID = (Get-AzStorageAccount -ResourceGroupName $CurrentRG -AccountName $StorageAccount).Id
    Start-Sleep -Seconds 10
    $usedCapacity = (Get-AzMetric -ResourceId $CurrentSAID -MetricName "UsedCapacity").Data
    $usedCapacityInMB = $usedCapacity.Average / 1024 / 1024
    [PSCustomObject]@{
                StorageAccount = $StorageAccount
                usedCapacityInMB=$usedCapacityInMB
                CurrentRG=$CurrentRG
                
                
            }
   
    } $StorageAccountsData |Export-Excel CisData.xlsx -WorksheetName storageAccountsUsedCapacity -append
}