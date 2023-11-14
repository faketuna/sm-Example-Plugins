#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "0.0.1"

ConVar g_cvPluginEnabled;

public Plugin myinfo =
{
    name = "ConVar",
    author = "faketuna",
    description = "",
    version = PLUGIN_VERSION,
    url = ""
}

public void OnPluginStart()
{
    g_cvPluginEnabled = CreateConVar("sm_plugin_enabled", "1", "Disable/Enable Plugin", FCVAR_NONE, true, 0.0, true, 1.0);
    g_cvPluginEnabled.AddChangeHook(OnCvarChanged);

    RegConsoleCmd("sm_convar", CommandConVarTest, "ConVar test command");
    RegConsoleCmd("sm_setcvar", CommandCvarSet, "ConVar test command");
    RegConsoleCmd("sm_findcvar", CommandFindCvar, "ConVar test command");
}

public Action CommandConVarTest(int client, int args) {
    if(GetConVarBool(g_cvPluginEnabled)) {
        ReplyToCommand(client, "Plugin is currently enabled");
        return Plugin_Handled;
    }

    ReplyToCommand(client, "Plugin is currently disabled");
    return Plugin_Handled;
}

public Action CommandCvarSet(int client, int args) {
    if(args == 0) {
        ReplyToCommand(client, "Not enough arguments!");
        return Plugin_Handled;
    }
    int value;
    
    if(!GetCmdArgIntEx(1, value)) {
        ReplyToCommand(client, "Invalid value!");
        return Plugin_Handled;
    }

    SetConVarInt(g_cvPluginEnabled, value);
    return Plugin_Handled;
}

public Action CommandFindCvar(int client, int args) {
    if(args == 0) {
        ReplyToCommand(client, "Not enough arguments!");
        return Plugin_Handled;
    }
    
    char conVarName[64], conVarValue[32];
    ConVar find;
    
    GetCmdArg(1, conVarName, sizeof(conVarName));

    find = FindConVar(conVarName);

    if(find == INVALID_HANDLE) {
        ReplyToCommand(client, "Specified ConVar not found!");
        return Plugin_Handled;
    }

    GetConVarString(find, conVarValue, sizeof(conVarValue));
    ReplyToCommand(client, "ConVar found: %s\nValue: %s", conVarName, conVarValue);
    return Plugin_Handled;
}

public void OnCvarChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
    char cvarName[64];
    convar.GetName(cvarName, sizeof(cvarName));
    PrintToChatAll("ConVar: %s value changed to %s!", cvarName, newValue);
}