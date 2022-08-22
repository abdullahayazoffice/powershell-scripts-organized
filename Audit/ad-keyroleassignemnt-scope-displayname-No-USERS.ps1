
$groups = Get-AzureADGroup 

$report = Foreach ($group in $groups) {
 

    [PSCustomObject][ordered]@{ 
      
      GroupDisplayName  = $group.DisplayName
      keyRoles=( Get-AzRoleAssignment -ObjectId $group.ObjectId  | Select-Object -Property  RoleDefinitionName,Scope, DisplayName ,@{Expression={$_.Name -join ';'}}| Export-Csv "temp.csv" -NoTypeInformation -Append)
}}

# print a table with desired formatting
$report | Export-Csv "Users_groups.csv" -NoTypeInformation 