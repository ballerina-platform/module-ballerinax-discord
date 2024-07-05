## Overview

[Discord](https://support.discord.com/hc/en-us/articles/360045138571-Beginner-s-Guide-to-Discord) is a popular communication platform designed for creating communities and facilitating real-time messaging, voice, and video interactions over the internet.

The Ballerina Discord connector offers APIs to connect and interact with the [Discord REST API v10](https://discord.com/developers/docs/reference).

## Setup guide

Follow these steps to create a Discord developer account.

### Step 1: Login to Discord developer page

<img src="https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/docs/setup/resources/discord-dev-page.png?raw=true">

Visit [Discord developer portal](https://discord.com/login?redirect_to=%2Fdevelopers) by logging into your Discord account. 

If you do not have a Discord account already, [create a new discord account](https://discord.com/login) by clicking on the `Register` hyperlink below the `Log In` button when opening the Discord developer page.

<img src= "https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/docs/setup/resources/create-acc.png?raw=true">

Complete the account creation process by including the relavant information in the given fields.

### Step 2: Make a new Discord application

<img src="https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/docs/setup/resources/make-new-app.png?raw=true">

Once in the Discord developer portal is open, click on the `New Application` button as displayed above to start the process.

### Step 3: Name the Discord Application 

<img src="https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/docs/setup/resources/create-app.png?raw=true">

1. Proceed by giving the Discord Application a name and click on the terms of service.

2. Finally complete the naming process by clicking on the `next` button.

### Step 4: Obtain the Client ID and Client Secret

<img src="https://github.com/HussainLatiff/module-ballerinax-discord/blob/main/docs/setup/resources/obtain-client-id.png?raw=true">

Under the `OAuth2` section found on the left-sided list, locate the Client's Information as shown on the screen. To implement the functionalities provided by Discord's API, you will need the Client ID and Client Secret.

## Quickstart

To use the `discord` connector in your Ballerina application, modify the `.bal` file as follows:

### Step 1: Import the module

Import the `discord` module.

```ballerina
import ballerinax/discord;
```

### Step 2: Instantiate a new connector

Create a `discord:ConnectionConfig` with the obtained OAuth2.0 Client Credentials and initialize the connector with it.

Apps must receive approval from users installing them to perform actions within Discord. To enable these functions, specific scopes must be defined. These scopes are outlined in the [OAuth2 Scopes documentation](https://discord.com/developers/docs/topics/oauth2#shared-resources-oauth2-scopes).

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string[] scopes = ?;

discord:Client discord = check new({
    auth: {
            clientId,
            clientSecret,
            scopes
        }
});
```

### Step 3: Invoke the connector operation
Now, utilize the available connector operations.

### Return linked third-party accounts of the user

```ballerina
 ConnectedAccountResponse[] connectedAccounts = check cl->/users/\@me/connections();
````

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Discord` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-discord/tree/main/examples/), covering the following use cases:

1. [Automated Event Reminders](https://github.com/ballerina-platform/module-ballerinax-discord/tree/main/examples/automated-event-reminders) - This use case illustrates how the Discord API can be leveraged to create a scheduled event in a Discord server and automate daily reminders about this event across all channels within the server.
2. [Automated Role Assignment Based on Reactions](https://github.com/ballerina-platform/module-ballerinax-discord/tree/main/examples/automated-role-assignment) - This use case illustrates the utilization of the Discord API to assign roles to members based on their interests, enabling them to gain roles by reacting to designated messages.