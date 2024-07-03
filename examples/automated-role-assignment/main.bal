// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.com).
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
import ballerina/io;

public function main() returns error? {
    check sendRoleAssignmentMessage();
    check addReactionsToMessage();
    check startRoleAssignmentListener();
}

function sendRoleAssignmentMessage() returns error? {
    http:Client discord = check new ("https://discord.com/api/v9");

    json message = {
        "content": "React to this message with the following emojis to get your roles:\n\n🔴 - Role1\n🔵 - Role2\n🟢 - Role3"
    };

    http:Request request = new;
    request.setPayload(message);
    request.addHeader("Authorization", "Bot BOT_TOKEN");
    request.addHeader("Content-Type", "application/json");

    http:Response response = check discord->post("/channels/762316177417961504/messages", request);
    io:println("Role Assignment Message Sent: ", response.getJsonPayload());
}

function addReactionsToMessage() returns error? {
    http:Client discord = check new ("https://discord.com/api/v9");

    string messageId = "YOUR_MESSAGE_ID"; 

    string[] emojis = ["🔴", "🔵", "🟢"];
    foreach var emoji in emojis {
        string url = string `"/channels/762316177417961504/messages/${messageId}/reactions/${emoji}/@me"`;
        http:Request request = new;
        request.addHeader("Authorization", "Bot BOT_TOKEN");

        http:Response|anydata put = check discord->put(url,request);
    }
    io:println("Reactions Added to Message");
}

function startRoleAssignmentListener() returns error? {
    listener http:Listener discordListener = new(9090);

    service / on discordListener {
        resource function post reactions(http:Caller caller, http:Request req) returns error? {
            json payload = check req.getJsonPayload();

            string eventType = check payload["t"].toString();
            if eventType == "MESSAGE_REACTION_ADD" {
                json d = check payload["d"];
                string userId = check d["688069266636800112"].toString();
                string emoji = check d["emoji"]["name"].toString();

                // Map emojis to role IDs
                map<string> roleMap = {
                    "🔴": "ROLE_ID_1",
                    "🔵": "ROLE_ID_2",
                    "🟢": "ROLE_ID_3"
                };

                if (roleMap.hasKey(emoji)) {
                    string roleId = roleMap[emoji] ?: "";
                    check assignRoleToUser(userId, roleId);
                }
            }

            check caller->respond("OK");
        }
    }
}

function assignRoleToUser(string userId, string roleId) returns error? {
    http:Client discord = check new ("https://discord.com/api/v9");

    http:Request request = new;
    request.addHeader("Authorization", "Bot BOT_TOKEN");

    string url = string `"/guilds/YOUR_GUILD_ID/members/${userId}/roles/${roleId}"`;
    http:Response|anydata put = check discord->put(url, request);
    io:println("Role Assigned to User");
}
