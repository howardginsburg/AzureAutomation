# Postgres Flexible Server

Pauses any Postgres Flexible Servers.

## Setup

1. Create an Azure Automation Account.
    - Make sure to enable System Assigned Managed Identity.
1. Grant the System Identity Contributor rights on the subscription.
1. Create a new Runbook in the Automation Account with the contents of [PausePostgres.ps1](./PausePostgres.ps1).
1. Create a new schedule for the Runbook to run daily.
