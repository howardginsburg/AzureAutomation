# Fabric Capacities

Pauses any Fabric Capacities that are not in use to save costs.

## Setup

1. Create an Azure Automation Account.
    - Make sure to enable System Assigned Managed Identity.
1. Grant the System Identity Contributor rights on the subscription.
1. Create a new Runbook in the Automation Account with the contents of [PauseCapacities.ps1](./PauseCapacities.ps1).
1. Create a new schedule for the Runbook to run daily.
