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
import ballerina/task;
import ballerinax/discord;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string[] scopes = ?;

const GUILD_ID = "YOUR_GUILD_ID";

# Represents a Discord Channel.
public type Channel record {
    # ID of the channel
    string id;
};

# Represents a Discord Event.
public type Event record {
    # ID of the event
    string id;
    # Name of the event
    string name;
};

discord:ConnectionConfig discordConfig = {
    auth: {
        clientId,
        clientSecret,
        scopes
    }
};

discord:Client discord = check new (discordConfig);

public function main() returns error? {
    // Registers the scheduled event.
    discord:guild_id_scheduledevents_body payload = {
        name: "Community Meeting",
        description: "Join us for our monthly community meeting!",
        scheduled_start_time: "2024-12-31T23:59:59Z",
        scheduled_end_time: "2024-12-31T23:59:59Z",
        privacy_level: 2,
        entity_type: 1,
        entity_metadata: {
            location: "Virtual"
        }
    };

    Event|error eventResponse = discord->/guilds/[guildId]/scheduled\-events.post(payload);
    if eventResponse is error {
        log:printError("Error creating the scheduled event: ", eventResponse);
        return;
    }

    // Schedules the daily recurring task to send the event reminders to all the related channels.
    task:JobId _ = check task:scheduleJobRecurByFrequency(new EventReminderJob(eventResponse.id), 60 * 60 * 24);
}

# A Ballerina scheduled job that sends a given event reminder message to a list of Discord channels.
class EventReminderJob {
    *task:Job;

    private final string eventName;

    public function init(string eventName) {
        self.eventName = eventName;
    }

    public function execute() {
        anydata[]|error channelsResponse = discord->/guilds/[guildId]/channels();
        if channelsResponse is error {
            log:printError("Error getting the channels: ", channelsResponse);
            return;
        }

        Channel[]|error channelsResult = channelsResponse.ensureType();
        if channelsResult is error {
            log:printError("Error getting the channels: ", channelsResult);
            return;
        }

        foreach Channel channel in channelsResult {
            any|error reminderResponse = discord->/channels/[channel.id]/messages.post({
                    Content\-Type: "application/x-www-form-urlencoded"
                },
                {
                    content: string `⏰ Reminder: Our community meeting '${self.eventName}' is coming up soon! Don't forget to join us.`
                }
            );
            if reminderResponse is error {
                log:printError("Error sending the reminder message: ", reminderResponse);
                return;
            }
        }
    }
}
