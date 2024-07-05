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

import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string token = isLiveServer ? os:getEnv("TOKEN") : "z4HhmDy5ghijpIRL1YFzhCeVFabcdef";
configurable string serviceUrl = isLiveServer ? "https://discord.com/api/v10" : "http://localhost:9090";
configurable string userId = isLiveServer ? os:getEnv("DISCORD_USER_ID") :"688069266636800112";

string voiceChannelId = "1160951610135019725";
string channelId = "893493941398294611";

ConnectionConfig config = {
    auth: {
        token
    }
};

final Client discord = check new Client(config, serviceUrl);

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetUser() returns error? {
    UserResponse user = check discord->/users/[userId]();
    test:assertEquals(user.id, userId);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetVoiceChannel() returns error? {
    anydata[] voiceChannels = check discord->/channels/[voiceChannelId]/invites();
    test:assertTrue(voiceChannels.length() > 0);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetWebhook() returns error? {
    anydata[] channelWebhooks = check discord->/channels/[channelId]/webhooks();
    test:assertTrue(channelWebhooks.length() > 0);
}
