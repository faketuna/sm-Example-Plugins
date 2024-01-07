#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "0.0.1"

public Plugin myinfo =
{
    name = "Translation",
    author = "faketuna",
    description = "",
    version = PLUGIN_VERSION,
    url = ""
}

public void OnPluginStart()
{
    LoadTranslations("test_trans.phrases");
    RegConsoleCmd("sm_trans", CommandTranslation, "Translation test command");
    RegConsoleCmd("sm_thw", CommandTranslatedHelloWorld, "Send translated hello world");
}

public Action CommandTranslation(int client, int args) {
    if(client == 0) {
        return Plugin_Handled;
    }

    SetGlobalTransTarget(client);
    if(args == 0) {
        ReplyToCommand(client, "%t", "not enough arguments");
        return Plugin_Handled;
    }
    else if(args > 1) {
        ReplyToCommand(client, "%t", "too many arguments", args);
        return Plugin_Handled;
    }

    char cmdArg1[32], cmdName[32], playerName[64];
    GetCmdArg(0, cmdName, sizeof(cmdName));
    GetCmdArg(1, cmdArg1, sizeof(cmdArg1));
    GetClientName(client, playerName, sizeof(playerName));
    PrintToChatAll("%t", "notify", playerName, cmdName, cmdArg1);
    return Plugin_Handled;
}

public Action CommandTranslatedHelloWorld(int client, int args) {
    SetGlobalTransTarget(client);
    ReplyToCommand(client, "%t", "hello world");
    return Plugin_Handled;
}