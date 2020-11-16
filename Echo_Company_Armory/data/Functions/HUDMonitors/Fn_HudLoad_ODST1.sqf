/*
This scirpt is a crap temp solution and should be changed in the future. 
*/
private ["_primeWeaponPic","_seconWeaponPic","_throwWeaponPic","_AT___WeaponPic","_1","_2","_3","_4","_5","_Da","_Db","_Dc"];

disableSerialization;
_display = _this select 0; 

// Dir Compass Controls 
_Da = _display displayCtrl 10001;
_Db = _display displayCtrl 10002;
_Dc = _display displayCtrl 10003;

// Picture Controls
_primeWeaponPic = _display displayCtrl 120;
_seconWeaponPic = _display displayCtrl 121;
_throwWeaponPic = _display displayCtrl 122;
_AT___WeaponPic = _display displayCtrl 123;

// Text Controls 
_text_100 = _display displayCtrl 300; // Fire Mode + Zeroing
_text_101 = _display displayCtrl 301; // Grenade Type 
_text_102 = _display displayCtrl 302; // Cur Weapon Name 
_text_103 = _display displayCtrl 303; // DirReadOut

// Pic Number Controls 
// Prime Mag Count
_1 = _display displayCtrl 101;
_2 = _display displayCtrl 102;
_3 = _display displayCtrl 103;
// Cur Throw Count
_4 = _display displayCtrl 104;
_5 = _display displayCtrl 105;

// Compass 
_compass3D = _display displayCtrl 880;
_compass3D_objectiveMarker = _display displayCtrl 881;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// Set Initial Colours And Animations ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

sleep 0.1; 

// Set Picture Controls Colour
{
	_x ctrlSetTextColor OPTRE_Hud_ColorScheme_Pictures;
} forEach [_AT___WeaponPic,_throwWeaponPic,_seconWeaponPic,_primeWeaponPic];

// Text + Number Pic Color's
{
	_x ctrlSetTextColor OPTRE_Hud_ColorScheme_Text;
} forEach [_text_100,_text_101,_text_102,_text_103,_1,_2,_3,_4,_5,(_display displayCtrl 200),_Da,_Db,_Dc];

// If hud on first time and not refresh from menu do animations: 
if !OPTRE_Hud_On then {
	showHUD [true, false, true, false, true, true, false, true, true]; 
	[player, "OPTRE_Sounds_HUD_Visor", 50] call CBA_fnc_globalSay3d;
	OPTRE_Hud_On = true;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// Set Initial HUD Conditions ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if OPTRE_HUD_CompassWanted then {	
	{
		_compass3DompassPostion = (profileNamespace getVariable ["OPTRE_HUD_ODST3DCompassConfiger_3DCompassPostion",[0.5,1.4215,-0.218458]]);
		_x ctrlSetModelScale (_compass3DompassPostion select 1); 
		_x ctrlSetPosition [0.5,(_compass3DompassPostion select 0),(_compass3DompassPostion select 2)];
	} forEach [_compass3D,_compass3D_objectiveMarker];
};

OPTRE_HUD_compass3DurrentThrowCheck = "";
OPTRE_HUD_stringNumbs = ""; 
OPTRE_HUD_WepCurrent = ""; 

OPTRE_HUD_UPDATEALL_Throw = true; 
OPTRE_HUD_UPDATEALL_Main = true;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////// Main Monitor /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

While {OPTRE_Hud_On AND cameraView != "EXTERNAL"} do {

	// Compass 
	if OPTRE_HUD_CompassWanted then {	
		//_grpPlayer = group player;
		_dirPlayer = getDir player; 
		/*_dirString = str (round _dirPlayer); // Will be used when font is created. // _text_103 ctrlSetText ((switch (count (toArray _dirString)) do {case 1: {"00"}; case 2: {"0"}; default {""};}) + _dirString); */
		_stringNumbsDir =  str (round _dirPlayer) splitString '';
		0 = switch ((count _stringNumbsDir)) do {
			case 1: { 
						_Dc ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbsDir select 0]);
						_Db ctrlSetText "OPTRE_Hud\Data\Numbers\0.paa"; 								   
						_Da ctrlSetText "OPTRE_Hud\Data\Numbers\0.paa";										
					};
			case 2: { 
						_Dc ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbsDir select 1]);
						_Db ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbsDir select 0]);									
						_Da ctrlSetText "OPTRE_Hud\Data\Numbers\0.paa";	
					};
			case 3: { 
						_Dc ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbsDir select 2]);
						_Db ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbsDir select 1]);
						_Da ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbsDir select 0]); 
					};
		};
		
		_vD = vectorDir player; 
		_compass3D ctrlSetModelDirAndUp [[(_vD select 0),(_vD select 1),0],[0,0,1]];
		
		_task = currentTask player;
		_taskDest = taskDestination currentTask player;
		if (!isNil "_taskDest" AND !isNil "_task" AND str _task != "No task") then { _compass3D_objectiveMarker ctrlSetModelDirAndUp ([player,_taskDest,-_dirPlayer] call OPTRE_fnc_ModelToWorldCalcPitchBankYaw);} else {_compass3D_objectiveMarker ctrlSetModelDirAndUp ([[0,0,0],[0,1,0], 180] call OPTRE_fnc_ModelToWorldCalcPitchBankYaw);};
		//_dirGroupLeader = (getDir leader _grpPlayer); _W2 ctrlSetModelDirAndUp ([[0,0,0],[0,0,0], (_dirGroupLeader - _dirPlayer) ] call OPTRE_fnc_ModelToWorldCalcPitchBankYaw);
		//_compass3DurrentWaypointPos = (waypointPosition [_grpPlayer, (currentWaypoint _grpPlayer)]); if (str _compass3DurrentWaypointPos != "[0,0,0]") then { _W3 ctrlSetModelDirAndUp ([player,(waypointPosition [_grpPlayer, (currentWaypoint _grpPlayer)]), -_dirPlayer] call OPTRE_fnc_ModelToWorldCalcPitchBankYaw);} else {_W3 ctrlSetModelDirAndUp ([[0,0,0],[0,0,0], 180] call OPTRE_fnc_ModelToWorldCalcPitchBankYaw);};
	};

	// Monitor Weapons Function
	_text_100 ctrlSetText (format ["%1  %2m",(currentWeaponMode player),(currentZeroing  player)]);  // ,(getText (configFile >> "CfgMagazines" >> _compass3DurMag >> "displayName"))
	
	
	// Common Weapon Variable 
	_compass3DurrentWeapon = currentWeapon player; 
	_magazinesPlayer = magazines player;
	//_stringNumbs = str ({_x == (currentMagazine player)} count _magazinesPlayer) splitString '';
	_weaponMagsAllowed = (getArray (configfile >> "CfgWeapons" >> _compass3DurrentWeapon >> "magazines")); 
	_stringNumbs = str ({_x in _weaponMagsAllowed} count _magazinesPlayer) splitString '';
	
	
	// Monitor Weapons
	if (OPTRE_HUD_UPDATEALL_Main OR OPTRE_HUD_stringNumbs != str _stringNumbs OR OPTRE_HUD_WepCurrent != _compass3DurrentWeapon) then {
		_secondaryWeapon = secondaryWeapon player; 
		OPTRE_HUD_stringNumbs = str _stringNumbs;
		_primeWeaponPic ctrlSetText (getText (configFile >> 'CfgWeapons' >> _compass3DurrentWeapon >> 'pictureWire'));
		_text_102 ctrlSetText (getText (configFile >> 'CfgWeapons' >> _compass3DurrentWeapon >> 'displayName'));
		if (_compass3DurrentWeapon != "" AND ctrlText _primeWeaponPic == "") then {_primeWeaponPic ctrlSetText "\OPTRE_Hud\data\UknownWireWeapons\UnknownWeapon.paa";};
		0 = switch ((count _stringNumbs)) do {
			case 1: { _1 ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs select 0]);_2 ctrlSetText ""; _3 ctrlSetText "";};
			case 2: { _1 ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs select 1]);_2 ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs select 0]);_3 ctrlSetText ""; };
			case 3: { _1 ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs select 2]);_2 ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs select 1]);_3 ctrlSetText (format ["OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs select 0]);};
			default { _1 ctrlSetText "OPTRE_Hud\Data\Numbers\0.paa"; _2 ctrlSetText ""; _3 ctrlSetText ""; };
		};
		_seconWeaponPic ctrlSetText (if (_compass3DurrentWeapon == primaryWeapon player) then { (getText (configFile >> 'CfgWeapons' >> (handgunWeapon player) >> 'pictureWire')) } else { (getText (configFile >> 'CfgWeapons' >> (primaryWeapon player) >> 'pictureWire')) });
		if (( (handgunWeapon player != "") AND (_compass3DurrentWeapon != handgunWeapon player) AND (ctrlText _seconWeaponPic == "") ) OR ( (primaryWeapon player != "") AND (_compass3DurrentWeapon != primaryWeapon player) AND (ctrlText _seconWeaponPic == "") )) then {_seconWeaponPic ctrlSetText "\OPTRE_Hud\data\UknownWireWeapons\UnknownWeapon.paa";};
		if (_compass3DurrentWeapon != _secondaryWeapon) then { _AT___WeaponPic ctrlSetText (getText (configFile >> 'CfgWeapons' >> _secondaryWeapon >> 'pictureWire')); if (_secondaryWeapon != "" AND ctrlText _AT___WeaponPic == "") then {_AT___WeaponPic ctrlSetText "\OPTRE_Hud\data\UknownWireWeapons\UnknownWeapon.paa";}; } else { _AT___WeaponPic ctrlSetText ""; };
		if OPTRE_HUD_UPDATEALL_Main then {OPTRE_HUD_UPDATEALL_Main = false;}; 
		0 = [true] call OPTRE_Fnc_SetAmmoCounterState;
	};
	
	// Monitor Throws
	_grenDetail = currentThrowable player;
	 if (count _grenDetail > 0) then { 
		_gren = _grenDetail select 0;
		if (OPTRE_HUD_compass3DurrentThrowCheck != _gren OR OPTRE_HUD_UPDATEALL_Throw) then { // Only Update if Needed. 
			_throwWeaponPic ctrlSetText (getText (configFile >> 'CfgMagazines' >> _gren >> 'pictureWire')); 
			if (_gren != "" AND ctrlText _throwWeaponPic == "") then {_throwWeaponPic ctrlSetText "\OPTRE_Hud\data\UknownWireWeapons\UnknownThrow.paa";};
			_text_101 ctrlSetText ( format ["%1",(getText (configFile >> "CfgMagazines" >> _gren >> "displayName"))] );
			_stringNumbs1 = ( format ["%1 |", ({_x == _gren} count _magazinesPlayer) ] ) splitString '';	
			0 = switch (count _stringNumbs1) do {
				case 3: { _4 ctrlSetText (format ["\OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs1 select 0]); _5 ctrlSetText ""; };
				case 4: { _4 ctrlSetText (format ["\OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs1 select 0]); _5 ctrlSetText (format ["\OPTRE_Hud\Data\Numbers\%1.paa",_stringNumbs1 select 1]); };
				default { _4 ctrlSetText ""; _5 ctrlSetText ""; };
			};
			OPTRE_HUD_compass3DurrentThrowCheck = _gren;
			if OPTRE_HUD_UPDATEALL_Throw then {OPTRE_HUD_UPDATEALL_Throw = false;}; 
		};
	} else { { _x ctrlSetText ""; } forEach [_text_101,_4,_5,_throwWeaponPic]; };
	
	OPTRE_HUD_WepCurrent = _compass3DurrentWeapon;
	 
	// Pause Time 
	sleep 0.0166667;

};

// External Mode: 
if OPTRE_Hud_On then {

	{_x cutFadeOut 0;} forEach [300,301,302];  
	showHUD [true, true, true, true, true, true, false, true, true]; 
	
	waitUntil {cameraView != "EXTERNAL" OR !OPTRE_Hud_On};
	
	if OPTRE_Hud_On then {
		
		300 cutRsc [OPTRE_Hud_MainCurrent,"PLAIN",-1, false];
		301 cutRsc [OPTRE_Hud_HealthCurrent,"PLAIN",-1, false]; 
		//302 cutRsc [OPTRE_Hud_AmmoCurrent,"PLAIN",-1, false];
		0 = [true] call OPTRE_Fnc_SetAmmoCounterState;
		
		showHUD [true, true, true, false, true, true, false, true, true]; 

	};
	
};

// Hud has been turned off by user:
if !OPTRE_Hud_On then {

	{_x cutFadeOut 1;} forEach [300,301,302,303];  
	showHUD [true, true, true, true, true, true, true, true, true]; 
	[player, "OPTRE_Sounds_HUD_Visor", 50] call CBA_fnc_globalSay3d;
	
	if ( cameraView != "EXTERNAL" OR (str (findDisplay 11000) != "No display") ) then {

		titleCut ["", "BLACK FADED", 999];
				
		"dynamicBlur" ppEffectEnable true;   
		"dynamicBlur" ppEffectAdjust [6];   
		"dynamicBlur" ppEffectCommit 0;     
		"dynamicBlur" ppEffectAdjust [0.0];  
		"dynamicBlur" ppEffectCommit 1;  

		titleCut ["", "BLACK IN", .5];
	
	};
	
};

OPTRE_Hud_UnFullyLoaded = true; 