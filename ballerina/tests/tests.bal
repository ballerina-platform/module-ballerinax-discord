// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;

configurable string clientId = "Client ID";
configurable string clientSecret = "Client Secret";
configurable string[] scopes = ?;

// Test case for the endpoint for exchanging authorization code for tokens
@test:Config{}
function testGetToken() returns error? {
    Client discord =check new({
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["identify"]
        }
    });

    OAuth2GetKeys getToken = check discord->/oauth2/keys(); 
}

// Test case for the endpoint to retrieve details about a specific user
@test:Config{}
function testGetUser() returns error? {
    string user_id = "User ID";	
    Client discord =check new({
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["identify", "email"]
        }
    });

    UserResponse getUserInfo = check discord->/users/[user_id]();
}

// Test case for the endpoint to retrieve details about a specific guild
@test:Config{}
function testGetGuild() returns error? {
    string guild_id = "Guild ID";	
    Client discord =check new({
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["guilds"]
        }
    });

    PrivateGuildMemberResponse getGuildInfo = check discord->/users/\@me/guilds/[guild_id]/member();
}

// Test case for the endpoint to edit a message
@test:Config{}
function testGetChannel() returns error? {
    string channel_id = "Text Channel ID";
    string message_id = "Message ID";	
    Client discord =check new({
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["guilds"]
        }
    });

    MessageResponse getGuildChannel = check discord->/channels/[channel_id]/messages/[message_id]();
}

// Test case for the endpoint to create a voice channel invite
@test:Config{}
function testGetVoiceChannel() returns error? {
    string channel_id = "Voice Channel ID";	
    Client discord =check new({
        auth: {
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["voice"]
        }
    });

    var getVoiceChannelInfo = check discord->/channels/[channel_id]/invites();
}