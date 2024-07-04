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
import ballerina/os;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string CliId = isLiveServer ? os:getEnv("Client_ID") : "test";
configurable string CliScre = isLiveServer ? os:getEnv("Client_Secret") : "test";
configurable string serviceUrl = isLiveServer ? os:getEnv("DISCORD_URL") : "http://localhost:9090/";
ConnectionConfig config = {auth:{
    token: "BearerToken"
}};
final Client discord = check new Client(config, serviceUrl);

@test:Config{}
function testGetUser() returns error? {
    string user_id = "User Id";	  
    UserResponse getUserInfo = check discord->/users/[user_id]();
    test:assertTrue((getUserInfo.length()> 0));
}

@test:Config{}
function testGetVoiceChannel() returns error? {
    string channel_id = "Voice Channel ID";	
    anydata getVoiceChannelInfo = check discord->/channels/[channel_id]/invites();
    test:assertTrue((getVoiceChannelInfo.count()> 0));
}

@test:Config{}
function testGetWebhook() returns error? {
    string channel_id = "Channel ID";	
    anydata getWebhookInfo = check discord->/channels/[channel_id]/webhooks();
    test:assertTrue((getWebhookInfo.count()> 0));	
}
