# Discord automated event reminders

This example demonstrates how to automate event announcements and reminders in a Discord server using the Ballerina Discord connector.

## Prerequisites

### 1. Setup Discord account

Refer to the [Setup guide](https://central.ballerina.io/ballerinax/discord/latest#setup-guide) to set up your Discord account, if you do not have one.

### 2. Configuration

Create a `Config.toml` file in the example root directory and update your Discord account related configurations as follows:

```toml
clientId = "<YOUR_CLIENT_ID>"
clientSecret = "<YOUR_CLIENT_SECRET>"
scopes = ["<YOUR>", "<REQUIRED>", "<SCOPES>"]
```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```
