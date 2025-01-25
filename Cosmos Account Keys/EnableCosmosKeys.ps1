# Use the System Assigned Managed Identity to connect to Azure.  It must have Contributor rights at the subscription level.
Connect-AzAccount -Identity

$resourceGroups = Get-AzResourceGroup

foreach ($rg in $resourceGroups) {
    # Get all Cosmos DB accounts in that resource group
    $cosmosAccounts = Get-AzCosmosDBAccount -ResourceGroupName $rg.ResourceGroupName

    foreach ($cosmosAccount in $cosmosAccounts) {
        $accountName = $cosmosAccount.Name

        $parameters = @{
            ResourceGroupName = $rg.ResourceGroupName
            ResourceName = $accountName
            ResourceType = "Microsoft.DocumentDB/databaseAccounts"
        }
        $resource = Get-AzResource @parameters
        
        $resource.Properties.DisableLocalAuth = $false
        
        $resource | Set-AzResource -Force
    }
}