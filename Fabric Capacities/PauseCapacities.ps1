# Use the System Assigned Managed Identity to connect to Azure. It must have Contributor rights at the subscription level.
Connect-AzAccount -Identity

# Get all Fabric capacities in the subscription
$fabricCapacities = Get-AzResource -ResourceType "Microsoft.Fabric/capacities"

# Loop through each Fabric capacity and pause it if not already paused
foreach ($capacity in $fabricCapacities) {
    $resourceGroupName = $capacity.ResourceGroupName
    $capacityName = $capacity.Name

    # Get the current state of the Fabric capacity
    $capacityDetails = Get-AzResource -ResourceGroupName $resourceGroupName -ResourceType "Microsoft.Fabric/capacities" -ResourceName $capacityName

    if ($capacityDetails.Properties.state -ne "Paused") {
        # Pause the Fabric capacity
        $pauseActionUri = "/subscriptions/$($capacity.SubscriptionId)/resourceGroups/$resourceGroupName/providers/Microsoft.Fabric/capacities/$capacityName/suspend?api-version=2023-11-01"
        Invoke-AzRestMethod -Method POST -Path $pauseActionUri
        Write-Output "Paused Fabric capacity: $capacityName in resource group: $resourceGroupName"
    } else {
        Write-Output "Fabric capacity: $capacityName in resource group: $resourceGroupName is already paused"
    }
}