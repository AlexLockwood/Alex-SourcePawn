#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <tf2>
#pragma semicolon 1

static const Float:g_fCitySpawn[] = {72.0, 11.0, 68.0};

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
	HookEvent("teamplay_round_start", Event_Round);
}

public Action:Event_Round(Handle:event, const String:name[], bool:dontBroadcast)
{
	RemoveMpex();
}

public StartTouch(const String:name[], caller, activator, Float:delay)
{
	if(!IsValidEntity(activator)) return;

	decl String:strName[50];
	GetEntPropString(caller, Prop_Data, "m_iName", strName, sizeof(strName));

	if(StrEqual(strName, "teleport_city"))
	{
		TeleportToLocation(activator);
	}
	else return;
}

RemoveMpex()
{
	decl String:className[64];
	for(new i=1; i<=GetMaxEntities(); i++)
	{
		if(IsValidEdict(i))
		{
			GetEntPropString(i, Prop_Data, "m_iName", className, sizeof(className));
			if(StrEqual(className, "mpex_trig3") || StrEqual(className, "mpex") )
				RemoveEdict(i);
		}
	}
}



TeleportToLocation(client)
{
	if(!IsValidEntity(client)) return Plugin_Handled;

	TeleportEntity(client, g_fCitySpawn, NULL_VECTOR, NULL_VECTOR);

	return Plugin_Handled;
}