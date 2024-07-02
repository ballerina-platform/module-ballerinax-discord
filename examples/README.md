# Examples

The `ballerinax/discord` connector provides practical examples illustrating usage in various scenarios. Explore the below examples, covering use cases like automated event announcements and automated role assignment based on reactions.

1. [Automated Event Announcements]
2. [Automated Role Assignment Based on Reactions]

## Prerequisites

1. Generate Discord credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/discord/latest#setup-guide).

2. For each example, create a `Config.toml` file the related configuration. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId="<client_id>"
    clientSecret="<client_secret>"
    scopes=["<scope1>", "<scope2>"]
    ```

## Running an Example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the Examples with the Local Module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
