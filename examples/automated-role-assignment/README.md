# Automated Role Assignment Based on Reactions

This example demonstrates how to use the Discord API to automatically assign roles based on reactions to a message. The Ballerina program sends a message to users in a channel, instructing them to react with an emoji representing the role they desire. The program then retrieves the emoji reactions and assigns roles to each user according to their chosen emoji.

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