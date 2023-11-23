#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "0.0.1"

public Plugin myinfo =
{
    name = "[CS:GO] Hook game event",
    author = "faketuna",
    description = "",
    version = PLUGIN_VERSION,
    url = ""
}

public void OnPluginStart()
{
    // キャンセルしないHook
    HookEvent("player_spawned", OnPlayerSpawned, EventHookMode_Post);
    // キャンセルするHook
    HookEvent("player_ping", OnPlayerPing, EventHookMode_Pre);  
}

public void OnPlayerSpawned(Event event, const char[] name, bool dontBroadcast) {
    int client = GetClientOfUserId(GetEventInt(event, "userid"));
    PrintToChatAll("%N spawned!", client);
}

public Action OnPlayerPing(Event event, const char[] name, bool dontBroadcast) {
    bool isUrgent = GetEventBool(event, "urgent", false);
    if(isUrgent) {
        return Plugin_Handled;
    }
    return Plugin_Continue;
}