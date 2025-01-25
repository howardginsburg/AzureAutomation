# Enable Cosmos Account Keys Authentication

Enables Cosmos Account Keys authentication on all Cosmos DB accounts in the subscription.

## Setup

1. Create an Azure Automation Account.
    - Make sure to enable System Assigned Managed Identity.
1. Grant the System Identity Contributor rights on the subscription.
1. Create a new Runbook in the Automation Account with the contents of [EnableCosmosKeys.ps1](./EnableCosmosKeys.ps1).
1. Create a new schedule for the Runbook to run daily.
