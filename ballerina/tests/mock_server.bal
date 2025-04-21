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

import ballerina/http;
import ballerina/log;

listener http:Listener httpServer = new (9090);

http:Service mockService = service object {

    resource function get users/[string userId]() returns UserResponse|error => {
        id: userId,
        username: "exampleUser",
        discriminator: "1234",
        publicFlags: 0,
        flags: 0,
        bot: false,
        system: false,
        avatar: "avatar_url",
        banner: "banner_url",
        accentColor: 16777215,
        globalName: "globalExampleUser"
    };

    resource function get channels/[string channelId]/invites() returns anydata => ["Invite1", "Invite2"];

    resource function get channels/[string channelId]/webhooks() returns anydata => ["Webhook1", "Webhook2"];
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock server initialization as the tests are running on live server");
        return;
    }

    log:printInfo("Initiating mock server");
    check httpServer.attach(mockService, "/");
    check httpServer.'start();
}
