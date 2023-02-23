

class DMS_MissionClaim
{
	idd = 86000;
	access = 3;
	duration = -1;
	onLoad = "uiNamespace setVariable ['DMS_MissionClaim', _this select 0]; [_this]call DMS_ClaimMapOpen";
	onUnload = "uiNamespace setVariable ['DMS_MissionClaim', displayNull];";
	
	class Controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Pfc. Ketanna, v1.063, #Tisoni)
		////////////////////////////////////////////////////////


				class DMS_MissionClaimBG: DMS_ClaimMissionRscPicture
				{
					idc = 1100;

					x = 5.00098e-005 * safezoneW + safezoneX;
					y = -5.99921e-005 * safezoneH + safezoneY;
					w = safezoneW;
					h = safezoneH;				
					
					text = "custom\DMS_Mission_Claim\Images\MissionClaimBG2.jpg";
				};
				
				///////// Claim Mission Button  ///////
				class DMS_ClaimMissionBtn: DMS_MissionRscButton
				{
					idc = 1600;
					
					text = "CLAIM MISSION"; //--- ToDo: Localize;
					
					
					x = 0.806281 * safezoneW + safezoneX;
					y = 0.76356 * safezoneH + safezoneY;
					w = 0.0984375 * safezoneW;
					h = 0.0559999 * safezoneH;
					colorBackground[] = {"199/255","38/255","81/255",1};
					colorText[] = {1,1,1,1};
					shadow = 0;
					font = "RobotoMedium";
					sizeEx = "30 * pixelH";
					colorFocused[] = {"199/255","38/255","81/255",0.8};
					colorBackgroundActive[] = {"199/255","38/255","81/255",0.8};
			
					onButtonClick =  "call DMS_MissionClaim";						
					tooltip = "Claims the Currently Selected Mission"; //--- ToDo: Localize;
					
				};
				
				///////// Cancel Selected Mission Button  /////////
				class DMS_CancelMissionBtn: DMS_MissionRscButton
				{
					idc = 1601;				
					text = "CANCEL MISSION"; //--- ToDo: Localize;
					x = 0.0969875 * safezoneW + safezoneX;
					y = 0.76356 * safezoneH + safezoneY;
					w = 0.0984375 * safezoneW;
					h = 0.0559999 * safezoneH;
					
					colorBackground[] = {"199/255","38/255","81/255",1};
					colorText[] = {1,1,1,1};
					shadow = 0;
					font = "RobotoMedium";
					sizeEx = "30 * pixelH";
					colorFocused[] = {"199/255","38/255","81/255",0.8};
					colorBackgroundActive[] = {"199/255","38/255","81/255",0.8};					
		
					onButtonClick = "call DMS_MissionCancel";					
					tooltip = "Cancels the Currently Selected Mission"; //--- ToDo: Localize;
			
				};
				///// Close Mission Display
				class DMS_CancelBtn: DMS_MissionRscButton
				{
					idc = 1602;			
					text = "CLOSE DISPLAY"; //--- ToDo: Localize;
					x = 0.453594 * safezoneW + safezoneX;
					y = 0.819 * safezoneH + safezoneY;
					w = 0.0984375 * safezoneW;
					h = 0.0559999 * safezoneH;
									
					colorBackground[] = {"199/255","38/255","81/255",1};
					colorText[] = {1,1,1,1};
					shadow = 0;
					font = "RobotoMedium";
					sizeEx = "30 * pixelH";
					colorFocused[] = {"199/255","38/255","81/255",0.8};
					colorBackgroundActive[] = {"199/255","38/255","81/255",0.8};
					
					onButtonClick = "closeDialog 0;";					
					tooltip = "closes the Mission Selection Display"; //--- ToDo: Localize;
				
				};
	
				
				
				class DMS_ClickMissionBtn: DMS_MissionRscListBox
				{
					idc = 1500;			
					onLBSelChanged = "[_this] call DMS_Mission_ListBoxSelectionChanged";

					x = 0.75575 * safezoneW + safezoneX;
					y = 0.23732 * safezoneH + safezoneY;
					w = 0.195562 * safezoneW;
					h = 0.518001 * safezoneH;
					colorBackground[] = {0,0,0,0.5};
				};

				/////////// Confirm Selected Mission Choice ///////////
				class DMS_ClickClaimedMissionBtn: DMS_MissionRscListBox
				{
					idc = 1501;				
					onLBSelChanged = "[_this] call DMS_Mission_CancelListBoxSelectionChanged";

					x = 0.0494584 * safezoneW + safezoneX;
					y = 0.236 * safezoneH + safezoneY;
					w = 0.195562 * safezoneW;
					h = 0.518001 * safezoneH;
					colorBackground[] = {0,0,0,0.5};
				};

				///////////  Mission Map Controler , shows the current map  ////////
				class Map: DMS_MissionClaimRscMapControl
				{
					idc = 1300;
					maxSatelliteAlpha = 0.75;
					alphaFadeStartScale = 1.15;
					alphaFadeEndScale = 1.29;

					x = 0.250437 * safezoneW + safezoneX;
					y = 0.20212 * safezoneH + safezoneY;
					w = 0.49875 * safezoneW;
					h = 0.601999 * safezoneH;
				};
				
			/// hint text bar if used /////////
				class textbar: DMS_MissionClaimRscStructuredText
				{
					idc = 1204;
					font = "RobotoMedium";

					x = 0.218469 * safezoneW + safezoneX;
					y = 0.0974 * safezoneH + safezoneY;
					w = 0.572344 * safezoneW;
					h = 0.055 * safezoneH;
					colorBackground[] = {0,0,0,0.5};
				};
				
				
			class ClaimBar: DMS_MissionClaimRscStructuredText
			{
				idc = 1205;
				font = "RobotoMedium";

				x = 0.755751 * safezoneW + safezoneX;
				y = 0.1678 * safezoneH + safezoneY;
				w = 0.195936 * safezoneW;
				h = 0.066 * safezoneH;
				colorBackground[] = {0,0,0,0.8};
			};
			class CancelBar: DMS_MissionClaimRscStructuredText
			{
				idc = 1206;
				font = "RobotoMedium";

				x = 0.0493439 * safezoneW + safezoneX;
				y = 0.1656 * safezoneH + safezoneY;
				w = 0.195936 * safezoneW;
				h = 0.066 * safezoneH;
				colorBackground[] = {0,0,0,0.8};
			};
		
		
		
		
			class DistanceBarMax: DMS_MissionClaimRscStructuredText
			{
				idc = 1207;
				font = "RobotoMedium";

				x = 0.110187 * safezoneW + safezoneX;
				y = 0.2074 * safezoneH + safezoneY;
				w = 0.0742501 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class DistanceBar: DMS_MissionClaimRscStructuredText
			{
				idc = 1208;
				font = "RobotoMedium";

				x = 0.812469 * safezoneW + safezoneX;
				y = 0.2096 * safezoneH + safezoneY;
				w = 0.0825 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class AltitudeBar: DMS_MissionClaimRscStructuredText
			{
				idc = 1209;
				font = "RobotoMedium";

				x = 0.757813 * safezoneW + safezoneX;
				y = 0.2096 * safezoneH + safezoneY;
				w = 0.0639374 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class AltitudeBarMax: DMS_MissionClaimRscStructuredText
			{
				idc = 1210;
				font = "RobotoMedium";

				x = 0.050375 * safezoneW + safezoneX;
				y = 0.2074 * safezoneH + safezoneY;
				w = 0.0701249 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class SpeedBarMax: DMS_MissionClaimRscStructuredText
			{
				idc = 1211;
				font = "RobotoMedium";

				x = 0.174125 * safezoneW + safezoneX;
				y = 0.2074 * safezoneH + safezoneY;
				w = 0.0701246 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			class SpeedBar: DMS_MissionClaimRscStructuredText
			{
				idc = 1212;
				font = "RobotoMedium";

				x = 0.885687 * safezoneW + safezoneX;
				y = 0.2096 * safezoneH + safezoneY;
				w = 0.0639373 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {0,0,0,0};
			};
			
			
			
			class textbar_Speed: DMS_MissionClaimRscStructuredText
			{
				idc = 1213;
				font = "RobotoMedium";

				x = 0.0514062 * safezoneW + safezoneX;
				y = 0.027 * safezoneH + safezoneY;
				w = 0.897187 * safezoneW;
				h = 0.044 * safezoneH;
				colorBackground[] = {0,0,0,0.9};
			};
			class textbar_Alt: DMS_MissionClaimRscStructuredText
			{
				idc = 1214;
				font = "RobotoMedium";

				x = 0.0514062 * safezoneW + safezoneX;
				y = 0.071 * safezoneH + safezoneY;
				w = 0.897187 * safezoneW;
				h = 0.044 * safezoneH;
				colorBackground[] = {0,0,0,0.9};
			};
			class textbar_Distance: DMS_MissionClaimRscStructuredText
			{
				idc = 1215;
				font = "RobotoMedium";

				x = 0.0514062 * safezoneW + safezoneX;
				y = 0.115 * safezoneH + safezoneY;
				w = 0.897187 * safezoneW;
				h = 0.044 * safezoneH;
				colorBackground[] = {0,0,0,0.9};
			};
				


////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

	};
};
