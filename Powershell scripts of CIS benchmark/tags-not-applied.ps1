$resources = Get-AzResourceGroup
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
$list|Export-Excel file.xlsx -WorksheetName tagslist