////////////// Mission Claim File Compilers ///////////////////

/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/

private["_code"];

{
    _code = compileFinal (preprocessFileLineNumbers (_x select 1));
    missionNamespace setVariable [(_x select 0), _code];
}
forEach
[
	['DMS_ClaimMapOpen','custom\DMS_Mission_Claim\Functions\DMS_ClaimMapOpen.sqf'],
	['DMS_Mission_CancelListBoxSelectionChanged','custom\DMS_Mission_Claim\Functions\DMS_Mission_CancelListBoxSelectionChanged.sqf'],
	['DMS_Mission_ListBoxSelectionChanged','custom\DMS_Mission_Claim\Functions\DMS_Mission_ListBoxSelectionChanged.sqf'],
	['DMS_Mission_Location_show','custom\DMS_Mission_Claim\Functions\DMS_Mission_Location_show.sqf'],
	['DMS_MissionCancel','custom\DMS_Mission_Claim\Functions\DMS_MissionCancel.sqf'],
	['DMS_MissionClaim','custom\DMS_Mission_Claim\Functions\DMS_MissionClaim.sqf'],
	['ZoomToMission','custom\DMS_Mission_Claim\Functions\ZoomToMission.sqf'],
	['DMS_Clear_Broken_Markers','custom\DMS_Mission_Claim\Functions\DMS_Clear_Broken_Markers.sqf']

];

 call compile preprocessFileLineNumbers "custom\DMS_Mission_Claim\config.sqf";