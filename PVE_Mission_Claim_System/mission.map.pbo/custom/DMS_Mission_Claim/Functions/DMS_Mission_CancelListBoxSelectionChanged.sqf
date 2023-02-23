/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/
	 
	private["_listboxArray", "_listBoxControl","_listBoxControlIndex","_display","_MissionClaimBtn","_MissionCancelBtn"];
	disableSerialization;

	_listboxArray = _this;

	_listBoxControl = (_listboxArray select 0) select 0;
	_listBoxControlIndex = (_listboxArray select 0) select 1;
	_display = uiNamespace getVariable ["DMS_MissionClaim",displayNull];



	DMS_CancelSelectedMissionMarkerName = _listBoxControl lbData _listBoxControlIndex;
	[DMS_CancelSelectedMissionMarkerName] call ZoomToMission;



	_myPlayerName = call BIS_fnc_playerName;
	_isplayerMission = _myPlayerName in markerText DMS_CancelSelectedMissionMarkerName;

	if (_isplayerMission) then 
	{
			_MissionCancelBtn = _display displayCtrl 1601;
			_MissionCancelBtn ctrlEnable true;
	}else{

			_MissionCancelBtn = _display displayCtrl 1601;
			_MissionCancelBtn ctrlEnable false;
	};

true