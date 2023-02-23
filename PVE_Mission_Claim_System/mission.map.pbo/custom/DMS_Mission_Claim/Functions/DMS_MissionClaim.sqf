/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/
	 
	 private ["_MissionSelection","_MarkerTextChanged","_CurrentMarkerText"];
	


	_display = uiNamespace getVariable ["DMS_MissionClaim",displayNull];

	//// adds missions to the currently claimed mission box ///
	_listBox = _display displayCtrl 1501;

	////  defines the Modified Marker name to include "CLAIMED by (The Players Name)"  /////
	_myPlayerName = call BIS_fnc_playerName;
	_myPlayerName = format ["CLAIMED by %1",_myPlayerName];
	uiNamespace setVariable ["ClaimedMissionVarName",_myPlayerName];

		  


	_CurrentMarkerText = markertext DMS_SelectedMissionMarkerName;	
	if (_CurrentMarkerText == "" ) then
	{	
		switch (true) do
		{
			case (getMarkerType DMS_SelectedMissionMarkerName == "o_naval"):
			{
				_CurrentMarkerText = "Ship Wreck";
			};							
			case (getMarkerType DMS_SelectedMissionMarkerName == "Artillary");case(getMarkerType DMS_SelectedMissionMarkerName == "o_art"):
			{
				_CurrentMarkerText = "Town Invasion";
				
			};	
			case(getMarkerType DMS_SelectedMissionMarkerName == "loc_car"):
			{
				_CurrentMarkerText = "Convoy";
			};
		};
		
    };	
	
	///////////// Formats Marker Text to show claimed status  /////////////
	_MarkerTextChanged = format ["%1 %2", _CurrentMarkerText,_myPlayerName];		
	DMS_SelectedMissionMarkerName setmarkertext _MarkerTextChanged;		

	[true] remoteExecCall ["DMS_Mission_Location_show",0];				//// calls location_show to refresh the list boxes for all players
	
	format ["%1", _MarkerTextChanged] remoteExecCall ["systemChat",0];			/// sends claim message to all players
	format ["%1", _MarkerTextChanged] remoteExecCall ["globalChat",0];			/// sends claim message to all players

	missionclaim = [_MarkerTextChanged];
	publicVariableServer "missionclaim";

	true