$resources = Get-AzureRmResource
foreach($resource in $resources)
{
    if ($resource.Tags -eq $ENV)
    {
        echo $resource.Name, $resource.ResourceType
    }
}