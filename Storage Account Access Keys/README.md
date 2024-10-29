# Storage Account Access Keys

Loops through all storage accounts in a subscription and enables the use of access keys.

## Setup

1. Create an Azure Automation Account.
    - Make sure to enable System Assigned Managed Identity.
1. Grant the System Identity Contributor rights on the subscription.
1. Create a new Runbook in the Automation Account with the contents of [EnableAccessKeys.ps1](./EnableAccessKeys.ps1).
1. Create a new schedule for the Runbook to run every 12 hours.
