$resources = Get-AzureRmResources
$resources.foreach{ if ($PSItem.tags.keys -match '^Office') { $PSItem } }