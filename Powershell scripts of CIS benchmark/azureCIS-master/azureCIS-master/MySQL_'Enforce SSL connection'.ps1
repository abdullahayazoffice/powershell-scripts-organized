﻿
$shellOutFilePath = "~/clouddrive/mysql_sslencryption.csv"

#loop through all subscriptions
Get-AzContext -ListAvailable -PipelineVariable AzureRMSub | Set-AzContext | foreach {

$mysql = Get-AzResource -ResourceType Microsoft.DBforMySQL/servers -ErrorAction Ignore -ExpandProperties

$Mysqlssl = New-Object –TypeName PSObject

$Mysqlssl | Add-Member –MemberType NoteProperty –Name Name –Value $mysql.Name
$Mysqlssl | Add-Member –MemberType NoteProperty –Name Subscription –Value $mysql.ResourceGroupName

$Mysqlssl | Add-Member –MemberType NoteProperty –Name SSLConnection –Value $mysql.Properties.sslEnforcement
 

$Mysqlssl | Export-CSV $shellOutFilePath    }


