# Use the System Assigned Managed Identity to connect to Azure. It must have Contributor rights at the subscription level.
Connect-AzAccount -Identity

# Get all PostgreSQL servers in the subscription
$pgServers = Get-AzPostgreSqlFlexibleServer

# Stop all read replicas first
$replicas = $pgServers | Where-Object { $_.ReplicationRole -eq 'Replica' }
foreach ($server in $replicas) {
    $resource = Get-AzResource -ResourceId $server.Id
    $resourceGroupName = $resource.ResourceGroupName

    Write-Output "Stopping read replica PostgreSQL server: $($server.Name) in resource group: $resourceGroupName"
    Stop-AzPostgreSqlFlexibleServer -Name $server.Name -ResourceGroupName $resourceGroupName
}

# Then stop all primary servers
$primaries = $pgServers | Where-Object { $_.ReplicationRole -ne 'Replica' }
foreach ($server in $primaries) {
    $resource = Get-AzResource -ResourceId $server.Id
    $resourceGroupName = $resource.ResourceGroupName

    Write-Output "Stopping primary PostgreSQL server: $($server.Name) in resource group: $resourceGroupName"
    Stop-AzPostgreSqlFlexibleServer -Name $server.Name -ResourceGroupName $resourceGroupName
}

