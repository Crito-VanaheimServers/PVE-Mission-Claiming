/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/

/*
This system was made for DMS mission but ended up growing into more. Most common mission systems like 
DMS, VMF, Shipwrecks, are already built into it. You can add marker types in this config to 
add other missions systems.
 
KNOWN ISSUES:
Players who have a UAV in the air will not have option to claim mission until UAV is taken down.
This is due to the UAV adding players name to a marker on the map and this script relys on checking
map markers for players name to limit them from being able to claim more than one mission at a time.

DMS AI count turned on will break this script this is because when player claims mission it changes
the mission name to read "MissionName Claimed By PlayerName". When they claim a mission that mission
is put into a box for player to unclaim if necessary. Once an ai dies at mission DMS then changes the
mission name to update the AI count at this point the player claim on marker is no longer there.
*/

Use_MissionClaimDistanceCheck = true;		// turns on/off distance checks from mission
MissionClaimDistanceCheck = 2000;			// max distance a player can be from a mission to claim it

Use_MissionCLaimAlt_SpeedCheck  = true;		// turns on/off all altatude and speed checks
MissionCLaimAlt_Limit = 500;				// max altitude a player can be to claim a mission
MissionCLaimSpeed_Limit = 200;				// max speed a player can be traveling to claim a mission

pMisssionCount = 1;							//If you use some sort of player marker system that involves 
											//player names showing where each player is on the map than set to 2.
											//Default is 1. Anything higher will cause players to be able to calim more than one mission.

//// used as a gate check when looking for marker types to add to the mission claim list box
/// If missions have markers that are not listed here you will need to add them for the mission claim to work on them///////
claimMrkrArray = [
				
					"ExileMissionHardcoreIcon",
					"ExileMissionDifficultIcon",
					"ExileMissionModerateIcon",
					"ExileMissionEasyIcon",
					"ExileMissionCapturePointIcon",
					"o_naval",
					"o_art",
					"Artillary",
					"mil_box",					
					"mil_objective",
					"o_air"
				];
				
				
//// map markers that do not have text, used to determine whether to remove the word Claimed by from a map marker or just clear the map marker text
/// If your mission markers do not have a text next to them on map and are just a marker you will need to add them here also////				
CancelMrkrArray = [
								
					"o_naval",
					"o_art",
					"Artillary",
					"mil_box",					
					"mil_objective"
				];	

///////////If your not sure about the folloing setting do not change them////////////////////////////////////////////////////
Use_ClearBrokenMakers = true;				// used to clear DMS Win Lose markers that break some times and dont clear
Use_ClearBrokenMakers_Message = true;		// sends pop down message to notify players that broken markers were cleared when opening the mission claim script
DMS_MissionMarkerWinDot_Type = "mil_start";	//broken marker types to clear
DMS_MissionMarkerLoseDot_Type =  "mil_end";	//broken marker types to clear
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
				

				