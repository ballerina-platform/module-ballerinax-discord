_Author_: @KamalikaSene \
_Created_: 2024/06/25 \
_Edition_: Swan Lake  

# Sanitation for OpenAPI specification
This document records the sanitation done on top of the official OpenAPI specification from Discord. The OpenAPI specification is obtained from the [Discord OpenAPI repository](https://github.com/discord/discord-api-spec).

1. These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.
This records the sanitization done when converting OAS from version 3.1.0 to 3.0.0 using APIMatic's conversion tool. These sanitation's are done to reduce the errors which occur when generating the client.

    The following changes were made:

    *    In OpenAPI 3.1.0, the `null` type within the Schema Object's list of types now maps to a nullable field within the OpenAPI 3.0 Schema Object, as the nullable field is no longer allowed.

    *    The `const` field in OpenAPI 3.1.0 is now represented as a single-valued enum in the OpenAPI 3.0 file.

2. Renamed the `config.auth` variable into `httpClientConfig.auth`. This is done as a workaround for this issue. [Authorization issues in the generated client](https://github.com/ballerina-platform/ballerina-library/issues/6655)


## OpenAPI cli command
The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.
```bash
bal openapi -i docs/spec/openapi.json --mode client --license docs/license.txt -o ballerina
```
