$ResourceGroup = Get-AzResourceGroup -Name 'Demo-RG'
$Policy = Get-AzPolicyDefinition -BuiltIn | Where-Object {$_.Properties.DisplayName -eq 'Allowed resource types'}



$array = @("virtualMachines")



$PolicyParameterObject = @{'listOfResourceTypesAllowed' = $array}



New-AzPolicyAssignment -Name 'Allowedresource' -PolicyDefinition $Policy -Scope $ResourceGroup.ResourceId -PolicyParameterObject $PolicyParameterObject