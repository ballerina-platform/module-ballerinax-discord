# Discord automated role assignment

This example demonstrates how using the Discord API how to automatically assign roles based on the reactions to a message. The Ballerina program sends a message to the users in a channel stating to react to that message with the emoji representing the role they require. The emoji reactions are retrieved and according to each user's emoji, each role is assigned to each user.

## Prerequisites

### 1. Setup Discord API

Refer to the [Setup Guide](https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/ballerina/Module.md) for necessary credentials (client ID, secret and tokens).

### 2. Configuration

Create a `Config.toml` file in the example root directory and update your Discord account related configurations as follows:

```toml
clientId="<Client ID>"
clientSecret="<Client Secret>"
scopes="<Scopes>"
```

## Run the Ballerina Example

Execute the following command to run the example:

```bash
bal run
```
