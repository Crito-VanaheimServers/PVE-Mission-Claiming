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
				"_listboxArray", "_listBoxControl","_listBoxControlIndex","_display","_MissionClaimBtn","_MissionCancelBtn","_myPlayerName",
				"_isplayerMission","_playerMissionCounter","_distanceCheck","_PlayerSpeed","_playerPos","_playerAlt","_DynamicColor",
				"_SpeedAdjust","_DistanceAdjust","_AltAdjust","_K_add_Alt","_K_add_Speed","_K_add_Distance","_tipText_D","_tipText_S","_tipText_A",
				"_tipTextSpeed","_tipTextAltitude","_tipTextDistance"
		];
		
disableSerialization;

_listboxArray = _this;

_listBoxControl = (_listboxArray select 0) select 0;
_listBoxControlIndex = (_listboxArray select 0) select 1;
_display = uiNamespace getVariable ["DMS_MissionClaim",displayNull];

_tipText_S = _display displayCtrl 1213;
_tipText_A = _display displayCtrl 1214;
_tipText_D = _display displayCtrl 1215;


		DMS_SelectedMissionMarkerName = _listBoxControl lbData _listBoxControlIndex;
	
		_playerPos =  getposatl player;
		_markerPos = getmarkerpos DMS_SelectedMissionMarkerName;	
		_distanceCheck = _playerPos distance2d _markerPos;
		_playerAlt = round (_playerPos select 2);
		_myPlayerName = call BIS_fnc_playerName;		
		_PlayerSpeed = speed vehicle player;
		
		_playerMissionCounter = 0;
		{
			_isplayerMission = _myPlayerName in markerText _x;
		
			if (_isplayerMission) then
			{
				_playerMissionCounter = _playerMissionCounter + 1;			
			};
		}foreach allmapmarkers;
		
		
		
		
	if (_playerAlt >= 1000) then
	{
		_AltAdjust = _playerAlt / 100;
		_AltAdjust =  floor _AltAdjust;
		_AltAdjust = _AltAdjust / 10;
		_K_add_Alt = "k ft";
	}else{
		_K_add_Alt = "ft";
		_AltAdjust = round _playerAlt;
	};
	
	if (_distanceCheck >= 1000) then
	{
		_DistanceAdjust = _distanceCheck / 100;
		_DistanceAdjust =  floor _DistanceAdjust;
		_DistanceAdjust = _DistanceAdjust / 10;
		_K_add_Distance = "km";		
	}else{
		_K_add_Distance = "m";
		_DistanceAdjust = round _distanceCheck;
	};	
	
	if (_PlayerSpeed >= 1000) then
	{
		_SpeedAdjust = _PlayerSpeed / 100;
		_SpeedAdjust =  floor _SpeedAdjust;
		_SpeedAdjust = _SpeedAdjust / 10;
		_K_add_Speed = "k mph";
	}else{
		_K_add_Speed = "mph";
		_SpeedAdjust = round _PlayerSpeed;
	};	
			
		
		

	_SpeedBar = _display displayCtrl 1212;
	if (_PlayerSpeed > MissionCLaimSpeed_Limit) then
	{
		/// red color
		_SpeedBar ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' align='left' color= '#B71C1C' >  Speed: %1%2</t>", _SpeedAdjust,_K_add_Speed]);

	}else{
		/// green color
		_SpeedBar ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' align='left' color=  '#1B5E20' >  Speed: %1%2</t>", _SpeedAdjust,_K_add_Speed]);
	};
	
	_DistanceBar = _display displayCtrl 1208;
	if (_distanceCheck > MissionClaimDistanceCheck) then
	{
		/// red color
		_DistanceBar ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' color = '#B71C1C' align='left'>  Distance: %1%2</t>", _DistanceAdjust,_K_add_Distance]);
	}else{
		/// green color
		_DistanceBar ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' color = '#1B5E20' align='left'>  Distance: %1%2</t>", _DistanceAdjust,_K_add_Distance]);
	};
	
	_AltitudeBar = _display displayCtrl 1209;
	if (_playerAlt > MissionCLaimAlt_Limit) then
	{
		/// red color
		_AltitudeBar ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' color = '#B71C1C' align='left'>  Alt: %1%2</t>",_AltAdjust,_K_add_Alt]);

	}else{
	
		/// green color
		_AltitudeBar ctrlSetStructuredText (parseText format["<t size='.7' font='puristaMedium' color = '#1B5E20' align='left'>  Alt: %1%2</t>",_AltAdjust,_K_add_Alt]);

	};

	if (Use_MissionCLaimAlt_SpeedCheck) then
	{
		for "_i" from 1209 to 1212 do
		{
			ctrlShow [_i, true];
		};	
	};

	if (Use_MissionClaimDistanceCheck) then
	{
		for "_i" from 1207 to 1208 do
		{
			ctrlShow [_i, true];
		};	
	};



	//// ensures a player cannot select more than one mission or fly over in a jet and claim a mission or be over x amount of distance from a mission to claim or get too high...				////
	///	the idea is to keep a player from rapidly wiping missions or hording missions  																											////
	if (
			_playerMissionCounter >= pMisssionCount || 
			/// ensures a player cannot claim more than one mission
			(Use_MissionClaimDistanceCheck && _distanceCheck > MissionClaimDistanceCheck) || 																						/// distance check so players cant claim a mission from across the map
			(Use_MissionCLaimAlt_SpeedCheck && _playerAlt > MissionCLaimAlt_Limit || _PlayerSpeed > MissionCLaimSpeed_Limit)			/// speed and alt check, so players cant buzz a mission in a jet and claim it
	
	) then	{
					

					_MissionClaimBtn = _display displayCtrl 1600;
					_MissionClaimBtn ctrlEnable false;
					ctrlShow [1204, false];
					
					if (_playerAlt > MissionCLaimAlt_Limit) then
					{
						ctrlShow [1214, true];
						_tipTextAltitude = format ["You are Too High to Claim a Mission, your Altitude is %1%2 (Max Alt is %3)", _AltAdjust,_K_add_Alt,MissionCLaimAlt_Limit];		
						_tipText_A ctrlSetStructuredText parseText format["<t size ='1.3 / (getResolution select 5)'  align='Center' color='#B71C1C' >[ %1 ]</t>",_tipTextAltitude];
					};
					if (_PlayerSpeed > MissionCLaimSpeed_Limit) then
					{
						ctrlShow [1213, true];
						_tipTextSpeed = format ["You are Traveling Too Fast to Claim a Mission, your speed is %1%2 (Max Speed is %3)", _SpeedAdjust ,_K_add_Speed,MissionCLaimSpeed_Limit];		
						_tipText_S ctrlSetStructuredText parseText format["<t size ='1.3 / (getResolution select 5)'  align='Center' color='#B71C1C' >[ %1 ]</t>",_tipTextSpeed];
					};
					
					if (_distanceCheck > MissionClaimDistanceCheck) then
					{
						ctrlShow [1215, true];					
						_tipTextDistance = format ["You are Too Far Away From Your Selected Mission to Make a Claim, your Distance is %1%2 (Max Distance is %3)", _DistanceAdjust,_K_add_Distance ,MissionClaimDistanceCheck];		
						_tipText_D ctrlSetStructuredText parseText format["<t size ='1.3 / (getResolution select 5)'  align='Center' color='#B71C1C' >[ %1 ]</t>",_tipTextDistance];					
					};
					
							
				}else{

						for "_i" from 1213 to 1215 do
						{
							ctrlShow [_i, false];
						};

						_MissionClaimBtn = _display displayCtrl 1600;
						_MissionClaimBtn ctrlEnable true;
					};


	[DMS_SelectedMissionMarkerName] call ZoomToMission;

	true