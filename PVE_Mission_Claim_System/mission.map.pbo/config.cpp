	class XM8_App03_Button: RscExileXM8AppButton1x1
	{
		textureNoShortcut = "custom\DMS_Mission_Claim\Images\missionClaimIcon.paa";
		text = "Mission Claiming";
		onButtonClick = "[false, _this] call DMS_Mission_Location_Show;";
		resource = "";
	};
