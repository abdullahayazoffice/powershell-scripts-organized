$userAssignedIdentityResourceId = Get-AzUserAssignedIdentity -ResourceGroupName RG-Key-Vault -Name test-user-assigned| Select-Object -ExpandProperty Id
$appResourceId = Get-AzWebApp -ResourceGroupName DR_source-asr -Name gavgevfye | Select-Object -ExpandProperty Id

$Path = "{0}?api-version=2021-01-01" -f $appResourceId
Invoke-AzRestMethod -Method PATCH -Path $Path -Payload "{'properties':{'keyVaultReferenceIdentity':'$userAssignedIdentityResourceId'}}"