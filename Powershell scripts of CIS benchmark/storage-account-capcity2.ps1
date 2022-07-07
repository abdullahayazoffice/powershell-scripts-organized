
$RGs = Get-AzResourceGroup | select ResourceGroupName
$storageaccountdetails =foreach($RG in $RGs)
{
    $CurrentRG = $RG.ResourceGroupName
    $StorageAccounts = Get-AzStorageAccount -ResourceGroupName $CurrentRG | select StorageAccountName
    $StorageAccountsData =foreach ($StorageAccount in $StorageAccounts){
    $StorageAccount = $StorageAccount.StorageAccountName
    $CurrentSAID = (Get-AzStorageAccount -ResourceGroupName $CurrentRG -AccountName $StorageAccount).Id
    ##Start-Sleep -Seconds 10
    $usedCapacity = (Get-AzMetric -ResourceId $CurrentSAID -MetricName "UsedCapacity").Data
    $usedCapacityInMB = $usedCapacity.Average / 1024 / 1024
    [PSCustomObject]@{
                StorageAccount = $StorageAccount
                usedCapacityInMB=$usedCapacityInMB
                CurrentRG=$CurrentRG
                
                
            }
    "$StorageAccount,$usedCapacityInMB,$CurrentRG,$currentSub" >> ".\storageAccountsUsedCapacity.csv"
    } $StorageAccountsData |Export-Excel file.xlsx -WorksheetName storageAccountsUsedCapacity -append
}