$subs = Get-AzureRmSubscription
foreach($sub in $subs){
    Set-AzureRmContext -Subscription $sub.Id -Tenant $sub.TenantId
    $vaults = Get-AzureRmKeyVault
    foreach($vault in $vaults){
        $policies = (Get-AzureRmKeyVault -ResourceGroupName $vault.ResourceGroupName -VaultName $vault.VaultName).AccessPolicies
        foreach($policy in $policies){
        $obj = [PSCustomObject]@{
            KeyVaultName = $vault.VaultName
            DisplayName = $policy.DisplayName
            PermissionsToCertificatesStr = $policy.PermissionsToCertificatesStr
            PermissionsToKeysStr = $policy.PermissionsToKeysStr
            PermissionsToSecretsStr = $policy.PermissionsToSecretsStr
            }
        $obj |  Export-Csv -Path C:\Users\joyw\Desktop\policies1.csv -Append -NoTypeInformation
       }
    }
}