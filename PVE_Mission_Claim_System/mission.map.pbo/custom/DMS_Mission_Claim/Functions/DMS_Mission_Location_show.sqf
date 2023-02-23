/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/
	 
	private[
				"_display","_ClaimMissionBtn","_CancelMissionBtn","_tipText","_tipTextList","_AvailableMissionListBox","_ClaimedMissionListBox",
				"_listItemIndex","_numberOfSpawnPoints","_randNum",	"_randData","_randomSpawnIndex","_isInString","_myPlayerName",
				"_DMS_Easy","_DMS_Moderate","_DMS_Difficult","_DMS_Hardcore","_markerIcon","_Mission_Location_Update_Var","_i",
				"_DistanceAdjust","_K_add","_SpeedAdjust","_AltAdjust","_MissionMarkerArray","_K_add_Alt","_K_add_Speed","_K_add_Distance",
				"_PVPZoneArray","_PVPZoneLoc","_PVPZoneRadius","_PVPZoneRadius","_currentMarkerChecked","_PvPMarkerVarCheck"
				
				
			];
				
	disableSerialization;
	DMS_SelectedMissionDone = false;
	DMS_SelectedMissionMarkerName = "";
	DMS_CancelSelectedMissionMarkerName = "";

	_isInString = false;
	_isplayerMission = false;
	_Mission_Location_Update_Var = _this select 0;		/// gets true/false depending on claim/cancel status (true) or openingdialog (false)
	_K_add = "";

	if (!_Mission_Location_Update_Var) then
	{
		createDialog "DMS_MissionClaim";
	};

	_display = uiNamespace getVariable ["DMS_MissionClaim",displayNull];
	_display displayAddEventHandler ["KeyDown", "_this select 1 call ExileClient_gui_loadingScreen_event_onKeyDown"];

	_ClaimMissionBtn = _display displayCtrl 1600;
	_ClaimMissionBtn ctrlEnable false;

	_CancelMissionBtn = _display displayCtrl 1601;
	_CancelMissionBtn ctrlEnable false;

	_tipText = _display displayCtrl 1204;

	_AvailableMissionListBox = _display displayCtrl 1500;
	_ClaimedMissionListBox = _display displayCtrl 1501;


	_ClaimableText = "CLAIMABLE MISSIONS";
	_ClaimableTextBar = _display displayCtrl 1205;
	_ClaimableTextBar ctrlSetStructuredText (parseText format["<t size='1.5' font='puristaMedium' align='center'>%1</t>", _ClaimableText]);

	_ClaimedText = "CLAIMED MISSIONS";
	_ClaimedTextBar = _display displayCtrl 1206;


	_ClaimedTextBar ctrlSetStructuredText (parseText format["<t size='1.5' font='puristaMedium' align='center'>%1</t>", _ClaimedText]);


	if (MissionCLaimAlt_Limit >= 1000) then
	{
		_AltAdjust = MissionCLaimAlt_Limit / 100;
		_AltAdjust =  floor _AltAdjust;
		_AltAdjust = _AltAdjust / 10;
		_K_add_Alt = "k ft";
	}else{
		_K_add_Alt = "ft";
		_AltAdjust = MissionCLaimAlt_Limit;
	};	
	_AltBarMax = _display displayCtrl 1210;
	_AltBarMax ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' align='left' >  Max Alt: %1%2<size='.8' shadow='true' /></t>", _AltAdjust,_K_add_Alt]);


	if (MissionClaimDistanceCheck >= 1000) then
	{
		_DistanceAdjust = MissionClaimDistanceCheck / 100;
		_DistanceAdjust =  floor _DistanceAdjust;
		_DistanceAdjust = _DistanceAdjust / 10;
		_K_add_Distance = "km";
	}else{
		_K_add_Distance = "m";
		_DistanceAdjust = MissionClaimDistanceCheck;
	};	

	_DistanceBarMax = _display displayCtrl 1207;	
	_DistanceBarMax ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' align='left' >  Max Dist: %1%2<size='.8' shadow='true' /></t>", _DistanceAdjust,_K_add_Distance]);
	
	
	
	if (MissionCLaimSpeed_Limit >= 1000) then
	{
		_SpeedAdjust = MissionCLaimSpeed_Limit / 100;
		_SpeedAdjust =  floor _SpeedAdjust;
		_SpeedAdjust = _SpeedAdjust / 10;
		_K_add_Speed = "k mph";
	}else{
		_K_add_Speed = "mph";
		_SpeedAdjust = MissionCLaimSpeed_Limit;
	};
	
	_SpeedBarMax = _display displayCtrl 1211;	
	_SpeedBarMax ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' align='left' >  Max Spd: %1%2<size='.8' shadow='true' /></t>", _SpeedAdjust,_K_add_Speed]);

	//	ctrlShow [1204, false];

		for "_i" from 1207 to 1212 do
		{
			ctrlShow [_i, false];
		};
		
		for "_i" from 1213 to 1215 do
		{
			ctrlShow [_i, false];
		};
		
	
		

	lbClear _AvailableMissionListBox;
	lbClear _ClaimedMissionListBox;
	{	

		_DMS_Easy =  "easy" in markertext _x;
		_DMS_Moderate = "moderate" in markertext _x;
		_DMS_Difficult = "difficult" in markertext _x;
		_DMS_Hardcore = "hardcore" in markertext _x; 
		
		if (getMarkerType _x in claimMrkrArray) then	
		{	
		
			if (!_DMS_Easy && !_DMS_Moderate && !_DMS_Difficult && !_DMS_Hardcore) then		/// checks for easy, difficult, moderate, hardcore in the mission name and ignores the marker if true
			{
				_isInString = "CLAIMED" in markerText _x;
				_myPlayerName = call BIS_fnc_playerName;
				_isplayerMission = _myPlayerName in markerText _x;
				if (_isInString) then
				{							
								
					_listItemIndex = _ClaimedMissionListBox lbAdd (markerText _x);
					_ClaimedMissionListBox lbSetData [_listItemIndex, _x];
															
					if (_isplayerMission) then
					{
						_ClaimedMissionListBox lbSetColor [_listItemIndex, [0, 1, 0, 0.5]];
					};
					
				}
				else
				{	
					_listItemIndex = _AvailableMissionListBox lbAdd (markerText _x);
					_AvailableMissionListBox lbSetData [_listItemIndex, _x];
		
					if (MarkerText _x == "" ) then
					{
					
						switch (true) do
						{
							case (getMarkerType _x == "o_naval"):
							{
								_AvailableMissionListBox lbSetText [_listItemIndex, "Ship Wreck"];
							};							
							case (getMarkerType _x == "Artillary");case(getMarkerType _x == "o_art"):
							{
								_AvailableMissionListBox lbSetText [_listItemIndex, "Town Invasion"];
							};	
						};
					};					
				};
			};
		};		
	}forEach allMapMarkers;


	/// sorts the list boxes alphabetically 
	_AvailableMissionListBox lbSortBy ["TEXT", false, false];
	_ClaimedMissionListBox lbSortBy ["TEXT", false, false];



	if (!_Mission_Location_Update_Var) then
	{
		_tipTextList = selectRandom 
		[
			"Use the Right List Box to Select and Claim a Mission"
		];
		 _tipText ctrlSetStructuredText parseText format["<t size ='1.8 / (getResolution select 5)' valign='middle' align='center' color='#FFD600' >[ %1 ]</t>",_tipTextList];
	};
	
	//// sometimes DMS Markers dont clear properly, this script in theory clears all broken markers
	if (Use_ClearBrokenMakers) then
	{
		remoteExecCall ["DMS_Clear_Broken_Markers",2];
	};	
	true