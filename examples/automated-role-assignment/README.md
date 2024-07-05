# Automated Role Assignment Based on Reactions

This example demonstrates how to use the Discord API to automatically assign roles based on reactions to a message. The Ballerina program sends a message to users in a channel, instructing them to react with an emoji representing the role they desire. The program then retrieves the emoji reactions and assigns roles to each user according to their chosen emoji.

## Prerequisites

### 1. Setup Discord API

Refer to the [Setup Guide](https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/ballerina/Module.md) for necessary credentials (client ID, secret and tokens).

### 2. Configuration

Create the `Config.toml` file and onfigure Discord API credentials in `Config.toml` in the example directory:

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