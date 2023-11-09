#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "0.0.1"

public Plugin myinfo =
{
    name = "Command",
    author = "faketuna",
    description = "",
    version = PLUGIN_VERSION,
    url = ""
}

public void OnPluginStart()
{
    RegConsoleCmd("sm_test", CommandTest, "Test command");
    RegConsoleCmd("cmd_test", CommandTest, "Test command");

    RegAdminCmd("sm_admtest", CommandAdminTest, ADMFLAG_BAN, "Admin test command");
}

public Action CommandTest(int client, int args) {
    ReplyToCommand(client, "Test command!");
    return Plugin_Handled;
}

public Action CommandAdminTest(int client, int args) {
    ReplyToCommand(client, "Test admin command!");
    return Plugin_Handled;
}