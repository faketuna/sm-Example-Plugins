#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "0.0.1"

public Plugin myinfo =
{
    name = "Command arguments",
    author = "faketuna",
    description = "",
    version = PLUGIN_VERSION,
    url = ""
}

public void OnPluginStart()
{
    RegConsoleCmd("sm_argtest", CommandTest, "Arguments test command");
}

public Action CommandTest(int client, int args) {
    if(args == 0) {
        ReplyToCommand(client, "Not enough arguments!");
        return Plugin_Handled;
    }
    else {
        char buff[32];
        for(int i = 1; i <= args; i++) {
            GetCmdArg(i, buff, sizeof(buff));
            ReplyToCommand(client, "Argument %d: %s", i, buff);
        }
    }
    return Plugin_Handled;
}