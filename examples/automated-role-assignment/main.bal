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

import ballerina/log;
import ballerina/mime;
import ballerina/task;
import ballerinax/discord;
import ballerina/http;
import ballerina/time;

const string CHANNEL_ID = "YOUR_CHANNEL_ID";
const string GUILD_ID = "YOUR_GUILD_ID";

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string[] scopes = ?;

discord:ConnectionConfig discordConfig = {
    auth: {
        clientId,
        clientSecret,
        scopes
    }
};
final discord:Client discord = check new (discordConfig);

public function main() returns error? {
    discord:Create_messageHeaders headers = {
        Content\-Type: mime:APPLICATION_FORM_URLENCODED
    };
    discord:channel_id_messages_body payload = {
        content: "React to this message with the following emojis to get your roles:\n\n🔴 - Role1\n🔵 - Role2\n🟢 - Role3"
    };

    discord:MessageResponse|error createMessageResponse = discord->/channels/[CHANNEL_ID]/messages.post(headers, payload);
    if createMessageResponse is error {
        log:printError("Error sending the message: ", createMessageResponse);
        return;
    }

    // schedule a task to be executed after 24 hours
    time:Utc scheduledTime = time:utcAddSeconds(time:utcNow(), 86400);
    task:JobId _ = check task:scheduleOneTimeJob(new RoleAssignmentJob(createMessageResponse.id), time:utcToCivil(scheduledTime));
}

class RoleAssignmentJob {
    *task:Job;

    private final string messageId;
    private final map<string> roles = {
        "🔴": "ROLE_ID_1",
        "🔵": "ROLE_ID_2",
        "🟢": "ROLE_ID_3"
    };

    public function init(string messageId) {
        self.messageId = messageId;
    }

    public function execute() {
        discord:MessageResponse|error messageResponse = discord->/channels/[CHANNEL_ID]/messages/[self.messageId];
        if messageResponse is error {
            log:printError("Error occurred while retrieving the message: ", messageResponse);
            return;
        }

        discord:MessageReactionResponse[]? reactions = messageResponse?.reactions;
        if reactions is () {
            log:printWarn("No reactions found for the message");
            return;
        }

        foreach discord:MessageReactionResponse reaction in reactions {
            string? emoji = reaction.emoji?.name;
            if emoji is () {
                continue;
            }
            
            string? role = self.roles[emoji];
            if role is () {
                log:printWarn("Could not find the role for the emoji");
                continue;
            }

            discord:UserResponse[]|error reactedUsers = discord->/channels/[CHANNEL_ID]/messages/[self.messageId]/reactions/[emoji];
            if reactedUsers is error {
                log:printError("Error occurred while retrieving the reacted users: ", reactedUsers);
                return;
            }

            foreach discord:UserResponse user in reactedUsers {            
                http:Response|error roleAssignedResponse = discord->/guilds/[GUILD_ID]/members/[user.id]/roles/[role].put();
                if roleAssignedResponse is error {
                    log:printError("Error occurred while assigning roles to the user: ", roleAssignedResponse);
                    return;
                }

                int responseStatus = roleAssignedResponse.statusCode;
                if responseStatus == http:STATUS_NO_CONTENT {
                    log:printInfo("User role update is successful");
                }
            }
        }
    }
}
