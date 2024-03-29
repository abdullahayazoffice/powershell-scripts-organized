Get-AzContext -ListAvailable -PipelineVariable AzuremSub | Set-AzContext |foreach{
Get-AzResource -ResourceType Microsoft.DBforPostgreSQL/servers -ExpandProperties -ErrorAction Ignore -PipelineVariable PostGre | foreach{
$logcon = Get-AzResource -ResourceGroupName $PostGre.ResourceGroupName `
        -ResourceType Microsoft.DBforPostgreSQL/servers/configurations `
        -ResourceName (-join $PostGre.Name + '/log_retention_days') -ApiVersion 2017-12-01;
        If($logcon.Properties.Value -le 3){
            $logcon.Properties.Value = 4;
            $logcon |  Set-AzResource -ApiVersion 2017-12-01 -Force;
        }
    }
    }

