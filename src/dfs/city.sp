#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#pragma semicolon 1

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
	if(!IsValidClient(target)) return;

	decl String:strName[50];
	GetEntPropString(index, Prop_Data, "m_iName", strName, sizeof(strName));

	if(StrEqual(strName, "teleport_city"))
	{
		TeleportToLocation(target, CITY);
	}
	else return;
}

TeleportToLocation(client, location)
{

}