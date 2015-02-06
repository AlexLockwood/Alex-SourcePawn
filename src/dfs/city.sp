#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#pragma semicolon 1

CITY = 0;

static const Float:g_fCitySpawn[][]
{
	{72.0, 11.0, 68.0}
};

public Plugin:myinfo =
{
	name = "The City - Teleports",
	author = "Kool",
	description = "Powers the teleporters in DFS's city",
	version = "1.0.0",
	url = "http://www.sourcemod.net/"
};

public OnPluginStart()
{
	HookEntityOutput("trigger_multiple", "OnStartTouch", StartTouch);
}

public StartTouch(const String:name[], caller, activator, Float:delay)
{
	if(!IsValidClient(activator)) return;

	decl String:strName[50];
	GetEntPropString(index, Prop_Data, "m_iName", strName, sizeof(strName));

	if(StrEqual(strName, "teleport_city"))
	{
		TeleportToLocation(activator, CITY);
	}
	else return;
}

TeleportToLocation(client, location)
{
	if(!IsValidClient(client)) return;

	TeleportEntity(client, g_fCitySpawn[CITY], NULL_VECTOR, NULL_VECTOR);
	return Plugin_Handled;
}