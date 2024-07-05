# Running Tests

There are two test environments for running the Discord connector tests. The default test environment is the mock server for Discord API. The other test environment is the actual Discord API. 

You can run the tests in either of these environments and each has its own compatible set of tests.

 Test Groups | Environment                                       
-------------|---------------------------------------------------
 mock_tests  | Mock server for Discord API (Defualt Environment) 
 live_tests  | Discord API                                       

## Running Tests in the Mock Server

To execute the tests on the mock server, ensure that the `IS_LIVE_SERVER` environment variable is either set to `false` or unset before initiating the tests. 

This environment variable can be configured within the `Config.toml` file located in the tests directory or specified as an environmental variable.

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and the following content:

```toml
isLiveServer = false
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:

```bash
export IS_LIVE_SERVER=false
```

Then, run the following command to run the tests:

```bash
   ./gradlew clean test
```

## Running Tests Against Discord Live API

#### Using a Config.toml File

Create a `Config.toml` file in the tests directory and add your authentication credentials, to create a [Discord bearer token use this guide](https://github.com/discord-net/Discord.Net/blob/dev/docs/guides/bearer_token/bearer_token_guide.md). 

```toml
isTestOnLiveServer = true
token = "<your-discord-bearer-token>"
userId = "<your-discord-user-id>"
serviceUrl = "<your-discord-subdomain-service-url>"
```

#### Using Environment Variables

Alternatively, you can set your authentication credentials as environment variables:

```bash
export IS_LIVE_SERVER=true
export TOKEN="<your-discord-bearer-token>"
export DISCORD_USER_ID="<your-discord-user-id>"
export DISCORD_URL="<your-discord-subdomain-service-url>"
```

Then, run the following command to run the tests:

```bash
   ./gradlew clean test -Pgroups="live_tests"
```