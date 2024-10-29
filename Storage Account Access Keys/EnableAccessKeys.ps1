# Use the System Assigned Managed Identity to connect to Azure.  It must have Contributor rights at the subscription level.
Connect-AzAccount -Identity

# Get all storage accounts in the subscription
$storageAccounts = Get-AzStorageAccount

# Loop through each storage account and set the "Allow Storage Account Key Access" flag to ON
foreach ($storageAccount in $storageAccounts) {
    $resourceGroupName = $storageAccount.ResourceGroupName
    $storageAccountName = $storageAccount.StorageAccountName

    # Get the current storage account properties
    $storageAccountProperties = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName

    # Check if the "Allow Storage Account Key Access" flag is already ON
    if ($storageAccountProperties.AllowSharedKeyAccess -ne $true) {
        # Update the storage account properties to set the flag to ON
        $storageAccountProperties.AllowSharedKeyAccess = $true
        Set-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName -AllowSharedKeyAccess $true

        Write-Output "Updated storage account: $storageAccountName in resource group: $resourceGroupName"
    } else {
        Write-Output "Storage account: $storageAccountName in resource group: $resourceGroupName already has the flag set to ON"
    }
}