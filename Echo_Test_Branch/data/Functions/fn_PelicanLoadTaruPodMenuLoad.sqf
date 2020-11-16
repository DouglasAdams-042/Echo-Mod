_podArray = (OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject getVariable ["OPTRE_Pelican_AttachedToVehiclesEffect",[]]);

if (
	(
		{
			["Land_Pod_Heli_Transport_04_covered_F", (typeOf _x)] call BIS_fnc_inString
		} count _podArray < 1
	) AND (
		count _podArray > 0
	)
) exitWith {
	hint "YOU MUST UNLOAD THE ATTACHED VEHICLE BEFORE TRYING TO LOAD SUPPLY PODS.";
};

// Clear Current Pods Attached
{
	deleteVehicle _x;
} forEach (OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject getVariable ["OPTRE_Pelican_AttachedToVehiclesEffect",[]]);
OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject setVariable ["OPTRE_Pelican_AttachedToVehiclesEffect",[],true];

// Add New pods / Create Array Containing Pods
_podArray = [];

for "_i" from 10 to 15 do {

	_control = ((findDisplay 10293) displayCtrl _i);
	_index = if ((lbCurSel _control) == 1) then {(round (2 + (random 9)));} else {lbCurSel _control;};
	_podClassname = _control lbData _index;

	if (_podClassname != "none") then {

		_pod = _podClassname createVehicle [0,0,0];
		_pod disableCollisionWith OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject;
		OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject disableCollisionWith _pod;

		_pod attachTo [

			OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject,
			(
				switch _i do {
					case 10: { [-0.85,-5.7,-.4] };
					case 11: { [ 0.85,-5.7,-.4] };
					case 12: { [-0.85,-4.7,-.4] };
					case 13: { [ 0.85,-4.7,-.4] };
					case 14: { [-0.85,-3.7,-.4] };
					case 15: { [ 0.85,-3.7,-.4] };
				}
			)
		];

		_podArray pushback _pod;

	};

};

// Add New Pods to Global Variable
OPTRE_PelicanLoadSupplyPods_Menu_PelicanObject setVariable ["OPTRE_Pelican_AttachedToVehiclesEffect",_podArray,true];

true
