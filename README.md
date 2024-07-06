# Ballerina Discord Connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-discord/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-discord/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/ballerina-platform/module-ballerinax-discord/branch/main/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerinax-discord)
[![Trivy](https://github.com/ballerina-platform/module-ballerinax-discord/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-discord/actions/workflows/trivy-scan.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-discord.svg)](https://github.com/ballerina-platform/module-ballerinax-discord/commits/master)
[![GraalVM Check](https://github.com/ballerina-platform/module-ballerinax-discord/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-discord/actions/workflows/build-with-bal-test-graalvm.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## Overview

[Discord](https://support.discord.com/hc/en-us/articles/360045138571-Beginner-s-Guide-to-Discord) is a popular communication platform designed for creating communities and facilitating real-time messaging, voice, and video interactions over the internet.

The Ballerina Discord connector offers APIs to connect and interact with the [Discord REST API v10](https://discord.com/developers/docs/reference).

## Setup guide

Follow these steps to create a Discord developer account.

### Step 1: Login to Discord developer page
<br/><br/>
<img src="https://github.com/ballerina-platform/module-ballerinax-discord/blob/main/docs/setup/resources/discord-dev-page.png?raw=true" alt="Discord Dev Page" style="width: 70%;">
<br/><br/>

Visit [Discord developer portal](https://discord.com/login?redirect_to=%2Fdevelopers) by logging into your Discord account. 

If you do not have a Discord account already, [create a new discord account](https://discord.com/login) by clicking on the `Register` hyperlink below the `Log In` button when opening the Discord developer page.

<br/><br/>
<img src= "https://github.com/ballerina-platform/module-ballerinax-discord/blob/main/docs/setup/resources/create-acc.png?raw=true" alt="Create Discord Account" style="width: 70%;">
<br/><br/>

Complete the account creation process by including the relevant information in the given fields.

### Step 2: Make a new Discord application
<br/><br/>

<img src="https://github.com/ballerina-platform/module-ballerinax-discord/blob/main/docs/setup/resources/make-new-app.png?raw=true" alt="Make New Application" style="width: 70%;">

<br/><br/>

Once in the Discord developer portal is open, click on the `New Application` button as displayed above to start the process.

### Step 3: Name the Discord Application 
<br/><br/>
<img src="https://github.com/ballerina-platform/module-ballerinax-discord/blob/main/docs/setup/resources/create-app.png?raw=true" alt="Name and Create the App" style="width: 70%;">

<br/><br/>

1. Proceed by giving the Discord Application a name and click on the terms of service.

2. Finally complete the naming process by clicking on the `next` button.

### Step 4: Obtain the Client ID and Client Secret
<br/><br/>
<img src="https://github.com/ballerina-platform/module-ballerinax-discord/blob/main/docs/setup/resources/obtain-client-id.png?raw=true" alt="Obtain Client ID and Secret" style="width: 70%;">
<br/><br/>

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
public function main() returns error? {
    ConnectedAccountResponse[] connectedAccounts = check discord->/users/\@me/connections();
}
````

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Discord` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-discord/tree/main/examples/), covering the following use cases:

1. [Automated Event Reminders](https://github.com/ballerina-platform/module-ballerinax-discord/tree/main/examples/automated-event-reminders) - This use case illustrates how the Discord API can be leveraged to create a scheduled event in a Discord server and automate daily reminders about this event across all channels within the server.

2. [Automated Role Assignment Based on Reactions](https://github.com/ballerina-platform/module-ballerinax-discord/tree/main/examples/automated-role-assignment) - This use case illustrates the utilization of the Discord API to assign roles to members based on their interests, enabling them to gain roles by reacting to designated messages.

## Build from the source

### Prerequisites

1. Download and install Java SE Development Kit (JDK) version 17. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environment:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```
