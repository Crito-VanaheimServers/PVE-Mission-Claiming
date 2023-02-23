/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/
	 
	 //////////// centers the map when opening the claim mission tab //////////
	 
	private["_display","_mapControl"];
	disableSerialization;

	_display = uiNamespace getVariable ["DMS_MissionClaim",displayNull];
	_mapControl = _display displayCtrl 1300;

	_mapcenter = worldsize /2;
	_mapControl = _display displayCtrl 1300;


	_mapControl ctrlMapAnimAdd [
									1, 							/// time it takes to move to the map location
									0.8, 						/// zoom level 			0 to 1.0     Lower the Number the more the map zooms in
									[_mapcenter,_mapcenter]		/// position to move map zoom to
								]; 
	ctrlMapAnimCommit _mapControl;



	true