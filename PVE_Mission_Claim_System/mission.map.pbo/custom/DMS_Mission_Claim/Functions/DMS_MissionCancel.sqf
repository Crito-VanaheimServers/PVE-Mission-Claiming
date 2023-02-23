/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/

  private [
			"_MissionCancel","_MissionCancelNameVar","_currentmarkertext","_newmarkername","_myPlayerName","_systemChatMessage","_MarkerTextCancel"
		  ];
 
 
	_currentmarkertext = markertext DMS_CancelSelectedMissionMarkerName;
	_newmarkername = _currentmarkertext splitstring " ";
	_myPlayerName = "";
	_myPlayerName = call BIS_fnc_playerName;

	/// removed the CLAIMED by Player Name text and leaves the original Mission Marker Name
	_nextmarkername = "";
	{
		if (_x == "CLAIMED") exitwith {};				/// looks for the word claimed, and stops the new marker name creation, essentially deleting the CLAIMED by player part of the marker name	
		_nextmarkername = _nextmarkername + _x;			/// the current marker word to the new marker name
		_nextmarkername = _nextmarkername + " ";		/// adds a space between each word
	}foreach _newmarkername;

	_systemChatMessage = _nextmarkername;

	/// looks for certain markers and sets their marker text to ""
	_CurrentMarkerType = getMarkerType DMS_CancelSelectedMissionMarkerName;	
	if (_CurrentMarkerType in CancelMrkrArray ) then
	{
		_nextmarkername = "";		
    };



	DMS_CancelSelectedMissionMarkerName setmarkertext _nextmarkername;			/// defines the new marker name after mission claim cancel

	
	
	[true] remoteExecCall ["DMS_Mission_Location_show",0];
	
	/// sends message to all player about the mission being unclaimed by a player  ////////
	_MarkerTextCancel = format ["%1 UnClaimed by %2", _systemChatMessage,_myPlayerName];
	format ["%1", _MarkerTextCancel]  remoteExecCall ["systemChat",0];	
	format ["%1", _MarkerTextCancel]  remoteExecCall ["globalChat",0];

	["MissonClaims",_MarkerTextCancel] call FNC_A3_CUSTOMLOG;		
	
	missionclaim = [_MarkerTextCancel];
	publicVariableServer "missionclaim";

	DMS_CancelSelectedMissionMarkerName = "";		/// resets the cancel marker variable
	true
	
	
	
	
	