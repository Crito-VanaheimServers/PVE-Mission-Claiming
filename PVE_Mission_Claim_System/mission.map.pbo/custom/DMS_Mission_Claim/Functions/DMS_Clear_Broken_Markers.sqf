/**
This Mission Claim script was created for use with DMS Mission System to claim mission with automated mission marker generation.
This code is the intellectual property of Ketanna and Crito, you may modify it as you see fit, but no monitary gains are permitted
using any portion of this code or its core function.

Mission Claim
By Ketanna & Crito @Vanaheim Gaming Servers
https://discord.gg/WEFzqPa
v1.0 10/02/2022
*/
	 
	private[ "_MissionMarkerArray","_Win_DMSMarkers_checker","_Loss_DMSMarkers_checker","_MissionMarkerArray_Counter"];
					
	disableSerialization;

	/// checks to see if DMS Mission System is being used by looking for the DMS_MissionMarkerLoseDot_Type and DMS_MissionMarkerWinDot_Type Marker Setting
	_Win_DMSMarkers_checker =  isnil "DMS_MissionMarkerWinDot_Type";			
	_Loss_DMSMarkers_checker =  isnil "DMS_MissionMarkerLoseDot_Type";	
	
	_MissionMarkerArray_Counter = 0;		

	if (!_Win_DMSMarkers_checker && !_Win_DMSMarkers_checker) then
	{
		_MissionMarkerArray = []; 
		{ 
			if (markerType _x == DMS_MissionMarkerWinDot_Type || markerType _x == DMS_MissionMarkerLoseDot_Type ) then
			{
					_MissionMarkerArray pushback _x;
			};
		}foreach allmapmarkers; 

		_MissionMarkerArray_Counter = count _MissionMarkerArray;
		{
			if (_MissionMarkerArray_Counter >= 1) then
			{
				deleteMarker _x;
			};
		}foreach _MissionMarkerArray;	

		if (_MissionMarkerArray_Counter >= 1 && Use_ClearBrokenMakers_Message) then
		{
			["InfoTitleAndText", ["<t color='#F2BA32' align='center'>Clearing Broken Markers</t>", format ["<t color='#FF0000' align='center'>(%1) </t> <t align='center'> Markers Cleared</t>", count _MissionMarkerArray]]] call ExileClient_gui_toaster_addTemplateToast;		
		};
	};	
	true