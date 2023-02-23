/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/
 
private["_markerName","_display","_mapControl"];
disableSerialization;
_markerName = _this;
_display = uiNamespace getVariable ["DMS_MissionClaim",displayNull];
_mapControl = _display displayCtrl 1300;



_mapControl ctrlMapAnimAdd [
									1, 								/// time it takes to move to the map location
									0.5, 							/// zoom level 			0 to 1.0     LOW the Number the more the map zooms in
									getMarkerPos _markerName		/// position to move map zoom to
							]; 
ctrlMapAnimCommit _mapControl;


true