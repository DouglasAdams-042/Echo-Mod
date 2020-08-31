class cfgPatches
{
    class CfgMods
    {
        class Mod_Base;
        class EchoTB: Mod_Base
        {
            logo = "";
            picture = "";
            name = "EchoTB";
        };
    };
    class Echo_Test_Branch
    {
        author="MacTavish"
        name="Echo Test Branch Mod"
        //Add all Soldiers to units[]
        units[]={
        "VES_MQ49_SD_Test",
        "VES_MQ49_RD_Test",
    };
        //Add all vests, helmets and weapons to weapons[]
        magazines[]={};
        ammo[]={};
        requiredVersion=0.1;
        //If you are using assets from other mods, add the pbo name to requiredAddons[]
        requiredAddons[]={"3DEN","V_FZ_Armor","OPTRE_FC_Core","OPTRE_Core","LM_OPCAN3.0"};
    };
};


class cfgGlasses{

};

class cfgWeapons{
    
    // <- This is not read by the system
    /*
        Anything between these two are also not read.
    */
    // OPTRE_CTF_Flag_GreenArmy
// V_FZ_Armor\Data\Helmets\V_CH252D_SLV_V_CO (Polarised ODST)
// V_FZ_Armor\Data\Helmets\V_CH252_SLV_V_CO.paa (Polarised Marine)
    class VES_CH252_MAR_Light;
	class LM_OPCAN_CH252_AR_T;
	class OPTRE_UNSC_PatrolCap_Army;
    class VES_CH252_MAR_Vacuum;
      class VES_CH252_MAR_Vacuum_dp; // needed. "DePolarized"
	  class ItemInfo; class VestItem; 
    //Start One helmet  
	class ETB_Base_OPCAN_Test_CH252: LM_OPCAN_CH252_AR_T
	{
		dlc="EchoTB";
		scope = 2;
		author="MacTavish and OPCAN"
		displayName="[ETB] CH252 MacTavish Woodland"
		 hiddenSelectionsTextures[]={"Echo_Test_Branch\Data\Headgear\ETB_H_MacTavish_Woodland_co.paa", ""};
        class ItemInfo: ItemInfo
        {
            hiddenSelectionsTextures[]={"Echo_Test_Branch\Data\Headgear\ETB_H_MacTavish_Woodland_co", ""};
        };
    }; 
    class ETB_Base_TST_CH252: VES_CH252_MAR_Light
    {
        dlc="EchoTB";
        scope = 2;
        author="MacTavish and Vespade";
        displayName="[ETB] CH252 (Base)(Test)";
        hiddenSelectionsTextures[]={"Echo_Test_Branch\Data\Headgear\ETB_T_co.paa", ""};
        class ItemInfo: ItemInfo
        {
            hiddenSelectionsTextures[]={"Echo_Test_Branch\Data\Headgear\ETB_T_co.paa", ""};
        };
    }; 
	//End One helmet
	class ETB_Patrol_Cap_MCAM_B: OPTRE_UNSC_PatrolCap_Army
    {
        dlc = "EchoTB";
        scope = 2;
        author = "MacTavish and A2S";
        displayName = "[ETB] Patrol Cap (Multicam Black)";
        hiddenSelectionsTextures[]  = {"Echo_Test_Branch\Data\Headgear\ETB_PatrolCap_MCAM_co.paa"};
    };

	class ETB_VAC_TST_CH252: VES_CH252_MAR_Vacuum
    {
        dlc="EchoTB";
        author="MacTavish and Vespade";
        displayName="[ETB] CH252 Helmet (Vac)(Test)";
        hiddenSelectionsTextures[]=
        {
            "Echo_Test_Branch\Data\Headgear\ETB_T_co.paa",
            // Visor
            "V_FZ_Armor\Data\Helmets\V_CH252_SLV_V_CO.paa"
        };
        class ItemInfo: ItemInfo
        {
            hiddenSelectionsTextures[]=
            {
                "Echo_Test_Branch\Data\Headgear\ETB_T_co.paa",
                   // Visor
                "V_FZ_Armor\Data\Helmets\V_CH252_SLV_V_CO.paa"
            };
        };
    };
    class ETB_VAC_TST_CH252_dp: VES_CH252_MAR_Vacuum_dp
    {
        dlc="EchoTB";
        author="MacTavish and Vespade";
        displayName="[ETB] CH252 Helmet (Vac)(Test)[OFF]";
        hiddenSelectionsTextures[]=
        {
            "Echo_Test_Branch\Data\Headgear\ETB_T_co.paa",
            "optre_unsc_units\army\data\helmet_visor_ca.paa"
        };
        class ItemInfo: ItemInfo
        {
            hiddenSelectionsTextures[]=
            {
                "Echo_Test_Branch\Data\Headgear\ETB_T_co.paa",
                "optre_unsc_units\army\data\helmet_visor_ca.paa"
            };
        };
    };
	class ETB_Army_TST_CH252: VES_CH252_MAR_Light
    {
        dlc="EchoTB";
        scope = 2;
        author="Barais and Vespade";
        displayName="[ETB] CH252 (Barais)(Test)";
        hiddenSelectionsTextures[]={"Echo_Test_Branch\Data\Headgear\ETB_Thomas_H_co.paa", ""};
        class ItemInfo: ItemInfo
        {
            hiddenSelectionsTextures[]={"Echo_Test_Branch\Data\Headgear\ETB_Thomas_H_paa", ""};
        };
    }; 
};//CfgWeapons

class CfgVehicles
{
	class OPTRE_CTF_Flag_Base;
	
	class ETB_CTF_Flag_Echo: OPTRE_CTF_Flag_Base
    {
        scope=2;
        scopeCurator=2;
        displayName="[ETB] CTF Flag (Echo)";
        hiddenSelections[]                = {"camo1"};
        hiddenSelectionsTextures[]        = {"Echo_Test_Branch\Data\Flags\flag_guidon_EchoUNSC_co.paa"};
    };
};//CfgVehicles