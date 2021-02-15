package com.company.assembleegameclient.parameters {
import com.company.assembleegameclient.game.events.ReconnectEvent;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.ObjectProperties;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.options.Options;
import com.company.util.KeyCodes;
import com.company.util.MoreDateUtil;
import com.company.util.MoreStringUtil;
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.net.SharedObject;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

public class Parameters {
    public static const CLIENT_VERSION:String = "1.3.2.1.0";
    public static const PORT:int = 2050;
    public static const UNITY_LAUNCHER_VERSION:String = "2019.3.14f1";
    public static const UNITY_GAME_VERSION:String = "2019.4.9f1";
    public static const LOG_PACKETS:Boolean = false;

    public static const FELLOW_GUILD_COLOR:uint = 10944349;

    public static const NAME_CHOSEN_COLOR:uint = 16572160;

    public static const PLAYER_ROTATE_SPEED:Number = 0.003;

    public static const BREATH_THRESH:int = 20;

    public static const SERVER_CHAT_NAME:String = "";

    public static const CLIENT_CHAT_NAME:String = "*Client*";

    public static const ERROR_CHAT_NAME:String = "*Error*";

    public static const HELP_CHAT_NAME:String = "*Help*";

    public static const GUILD_CHAT_NAME:String = "*Guild*";

    public static const NAME_CHANGE_PRICE:int = 1000;

    public static const GUILD_CREATION_PRICE:int = 1000;

    public static const TUTORIAL_GAMEID:int = -1;

    public static const NEXUS_GAMEID:int = -2;

    public static const RANDOM_REALM_GAMEID:int = -3;

    public static const MAPTEST_GAMEID:int = -6;

    public static const MAX_SINK_LEVEL:Number = 18;

    public static const TERMS_OF_USE_URL:String = "http://legal.decagames.com/tos/";

    public static const PRIVACY_POLICY_URL:String = "http://legal.decagames.com/privacy/";

    public static const USER_GENERATED_CONTENT_TERMS:String = "/UGDTermsofUse.html";

    public static const RANDOM1:String = "5a4d2016bc16dc64883194ffd9";

    public static const RANDOM2:String = "c91d9eec420160730d825604e0";

    public static const RSA_PUBLIC_KEY:String = "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCKFctVrhfF3m2Kes0FBL/JFeOcmNg9eJz8k/hQy1kadD+XFUpluRqa//Uxp2s9W2qE0EoUCu59ugcf/p7lGuL99UoSGmQEynkBvZct+/M40L0E0rZ4BVgzLOJmIbXMp0J4PnPcb6VLZvxazGcmSfjauC7F3yWYqUbZd/HCBtawwIDAQAB\n-----END PUBLIC KEY-----";

    public static const skinTypes16:Vector.<int> = new <int>[1027,1028,1029,1030,10973,19494,19531,6346,30056,5505,7766,7769];

    public static const DefaultAAIgnore:Vector.<int> = new <int>[2312,2313,2370,2392,2393,2400,2401,3413,3418,3419,3420,3421,3427,3454,3638,3645,29594,29597,29710,29711,29742,29743,29746,29748,29781,30001];

    public static const DefaultAAException:Vector.<int> = new <int>[2309,2310,2311,3448,3449,3472,3334,5952,2354,2369,3368,3366,3367,3391,3389,3390,5920,2314,3412,3639,3634,2327,2335,2336,1755,24582,24351,24363,24135,24133,24134,24132,24136,3356,3357,3358,3359,3360,3361,3362,3363,3364,2352,2330,28780,28781,28795,28942,28957,28988,28938,29291,29018,29517,24338,29580,29712];

    public static const DefaultPriorityList:Vector.<int> = new Vector.<int>(0);

    public static const spamFilter:Vector.<String> = new <String>["reaimbags,net","r0tmg,0rg",
        "oryxsh0p.net","wh!tebag,net","wh!tebag.net","realmshop.info","realmshop.lnfo",
        "rotmgmarket.c","rpgstash,com","rpgstash.com","realmitems","reaimitems","reaimltems",
        "realmltems","realmpower,net","reaimpower.net","realmpower.net","reaimpower,net",
        "rea!mkings.xyz","buyrotmg.c","lifepot. org","rotmgmax.me","rotmgmax,me",
        "rotmgmax me","oryx.ln","rpgstash com","rwtmg","rotmg.io","jasonprimate",
        "rotmgmax","realmpower","reaimpower","oryxjackpot,com","realmstock.com",
        "reaimstock.com", "rpgstash,c0m", "rotmg,network", "reaimdupe.com"];

    public static const defaultExclusions:Vector.<int> = new Vector.<int>(0);

    public static const defaultInclusions:Vector.<int> = new <int>[600,601,602,603,2295,2296,2297,2298,2524,2525,2526,2527,8608,8609,8610,8611,8615,8617,8616,8618,8962,9017,9015,9016,9055,9054,9052,9053,9059,9058,9056,9057,9063,9062,9060,9061,32697,32698,32699,32700,3004,3005,3006,3007,3088,3100,3096,3091,3113,3114,3112,3111,3032,3033,3034,3035,3177,3266];

    public static const hpPotions:Vector.<int> = new <int>[2736,16874,1799,2594,2868,2870,2872,2874,2876,2836,2837,2838,2839,2689,2632,2633,2795,1799,3105,3090,3164,3163,3265,9077,10244,10243,28901];

    public static const mpPotions:Vector.<int> = new <int>[2595,2634,2797,2798,2840,2841,2842,2843,2796,2869,2871,2873,2875,2877,3098];

    public static const lmPotions:Vector.<int> = new <int>[2793,9070,5471,9730,2794,9071,5472,9731];

    public static const raPotions:Vector.<int> = new <int>[2591,5465,9064,9729,2592,5466,9065,9727,2593,5467,9066,9726,2612,5468,9067,9724,2613,5469,9068,9725,2636,5470,9069,9728];

    public static var isGoto:Boolean = false;

    public static var lastRecon:ReconnectEvent;

    public static var root:DisplayObject;

    public static var data:Object = null;

    public static var drawProj_:Boolean = true;

    public static var giftChestLootMode:int = 0;

    public static var player:Player = null;

    public static var reconNexus:ReconnectEvent = null;

    public static var followName:String = "";

    public static var followPlayer:GameObject;

    public static var followingName:Boolean = false;

    public static var questFollow:Boolean = false;

    public static var lowCPUMode:Boolean = false;

    public static var preload:Boolean = false;

    public static var forceCharId:int = -1;

    public static var ignoringSecurityQuestions:Boolean = false;

    public static var ignoredShotCount:int = 0;

    public static var receivingPots:Boolean;

    public static var givingPotions:Boolean;

    public static var recvrName:String;

    public static var autoAcceptTrades:Boolean;

    public static var autoDrink:Boolean;

    public static var watchInv:Boolean;

    public static var timerActive:Boolean;

    public static var phaseChangeAt:int;

    public static var phaseName:String;

    public static var realmName:String;

    public static var bazaarJoining:Boolean;

    public static var bazaarLR:String;

    public static var bazaarDist:Number;

    public static var manualTutorial:Boolean;

    public static var suicideMode:Boolean = false;

    public static var suicideAT:int = -1;

    public static var fpmGain:int = 0;

    public static var fpmStart:int = -1;

    public static var warnDensity:Boolean = false;

    public static var VHS:int = 0;

    public static var VHSRecordLength:int = -1;

    public static var VHSIndex:int = -1;

    public static var abi:Boolean = true;

    public static var keyHolders:String;

    public static var needToRecalcDesireables:Boolean = false;

    public static var needsMapCheck:int = 0;

    public static var paramIPJoinedOnce:Boolean = true;

    public static var paramServerJoinedOnce:Boolean = true;

    public static var savingMap_:Boolean = false;

    public static var swapINVandBP:Boolean = false;

    public static var swapINVandBPcounter:int = 0;

    public static var enteringRealm:Boolean = false;

    public static var RANDOM1_BA:ByteArray = new ByteArray();

    public static var RANDOM2_BA:ByteArray = new ByteArray();

    public static var appendage:Vector.<String> = new Vector.<String>(0);

    public static var filtered:Vector.<String> = new Vector.<String>(0);

    public static var dmgCounter:Array = [];

    public static var emptyOffer:Vector.<Boolean> = new <Boolean>[false,false,false,false,false,false,false,false,false,false,false,false];

    public static var potionsToTrade:Vector.<Boolean> = new <Boolean>[false,false,false,false,false,false,false,false,false,false,false,false];

    public static var timerPhaseTimes:Dictionary = new Dictionary();

    public static var timerPhaseNames:Dictionary = new Dictionary();

    public static var famePoint:Point = new Point(0,0);

    public static var VHSRecord:Vector.<Point> = new Vector.<Point>();

    public static var VHSNext:Point = new Point();

    public static var announcedBags:Vector.<int> = new Vector.<int>(0);

    public static var charNames:Vector.<String> = new Vector.<String>(0);

    public static var charIds:Vector.<int> = new Vector.<int>(0);

    public static var mystics:Vector.<String> = new Vector.<String>(0);

    private static var savedOptions_:SharedObject = null;

    private static var keyNames_:Dictionary = new Dictionary();


    public function Parameters() {
        super();
    }

    public static function load() : void {
        try {
            savedOptions_ = SharedObject.getLocal("options","/");
            data = savedOptions_.data;
        }
        catch(error:Error) {
            data = {};
        }
        setDefaults();
        setIgnores();
        setCustomPriorityList();
        RANDOM1_BA = MoreStringUtil.hexStringToByteArray("5a4d2016bc16dc64883194ffd9");
        RANDOM2_BA = MoreStringUtil.hexStringToByteArray("c91d9eec420160730d825604e0");
        setTimerPhases();
        setAutolootDesireables();
        fixFilter();
        save();
    }

    public static function setCustomPriorityList() : void {
        var _loc2_:* = null;
        var _loc4_:int = 0;
        var _loc3_:* = Parameters.data.CustomPriorityList;
        for each(var _loc1_ in Parameters.data.CustomPriorityList) {
            _loc2_ = ObjectLibrary.propsLibrary_[_loc1_];
            if(_loc2_) {
                _loc2_.customBoss_ = true;
            }
        }
    }

    public static function fixFilter() : void {
        var _loc7_:Boolean = false;
        var _loc9_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc6_:Boolean = false;
        var _loc1_:* = null;
        var _loc10_:* = null;
        filtered.length = 0;
        var _loc8_:Vector.<String> = new <String>["rwtmg","rwtstore","rwtshop",
            "rotmgrwt","realmgood","reaimgood","rpgrip","rpgrlp","realmshop",
            "reaimshop","realmsh0p","reaimsh0p","realmp0wer","reaimp0wer",
            "realmpower","reaimpower","relmgood","reimgood","hyuk3d","realmservices",
            "rotmgstore","nv9p4r","v4sfdb","wgajrj","4hzb5","realmrwt","rotmgcheap",
            "realmgen","reaimgen","guills","rwtrealm","rwtgang","rea1mgen","rwtking",
            "discordgg","discordio","discordcom","realmstock","r883q5c","oryxjackpot",
            "reaimstock", "r0tmg", "rpgstash", "rotmg,network", "reaimdupe"];
        var _loc15_:int = 0;
        var _loc14_:* = _loc8_;
        for each(var _loc11_ in _loc8_) {
            _loc7_ = false;
            var _loc13_:int = 0;
            var _loc12_:* = spamFilter;
            for each(var _loc2_ in spamFilter) {
                if(_loc11_ == _loc2_) {
                    _loc7_ = true;
                    break;
                }
            }
            if(!_loc7_) {
                filtered.push(_loc11_);
            }
        }
        filtered = filtered.concat(_loc8_);
        var _loc19_:int = 0;
        var _loc18_:* = spamFilter;
        for each(_loc2_ in spamFilter) {
            _loc2_ = _loc2_.toLowerCase();
            _loc1_ = [];
            _loc9_ = _loc2_.length;
            if(_loc9_ > 0) {
                _loc5_ = 0;
                while(_loc5_ < _loc9_) {
                    _loc4_ = _loc2_.charCodeAt(_loc5_);
                    if(_loc4_ >= 48 && _loc4_ <= 57 || _loc4_ >= 97 && _loc4_ <= 122) {
                        _loc1_.push(_loc4_);
                    }
                    _loc5_++;
                }
            }
            _loc10_ = String.fromCharCode.apply(String,_loc1_);
            if(_loc10_.length > 0) {
                _loc6_ = false;
                var _loc17_:int = 0;
                var _loc16_:* = filtered;
                for each(var _loc3_ in filtered) {
                    if(_loc3_ == _loc10_) {
                        _loc6_ = true;
                    }
                }
                if(!_loc6_) {
                    filtered.push(_loc10_);
                }
            }
        }
    }

    public static function setTimerPhases() : void {
        timerPhaseTimes["{\"key\":\"server.oryx_closed_realm\"}"] = 120000;
        timerPhaseTimes["{\"key\":\"server.oryx_minions_failed\"}"] = 12000;
        timerPhaseTimes["DIE! DIE! DIE!!!"] = 23000;
        timerPhaseNames["{\"key\":\"server.oryx_closed_realm\"}"] = "Realm Closed";
        timerPhaseNames["{\"key\":\"server.oryx_minions_failed\"}"] = "Oryx Shake";
        timerPhaseNames["DIE! DIE! DIE!!!"] = "Vulnerable";
    }

    public static function setAutolootDesireables() : void {
        var _loc1_:int = 0;
        var _loc3_:int = 0;
        var _loc4_:ObjectProperties = null;
        var _loc10_:* = null;
        var _loc9_:* = ObjectLibrary.xmlLibrary_;
        var _loc16_:int = 0;
        var _loc15_:* = ObjectLibrary.xmlLibrary_;
        for each(_loc10_ in ObjectLibrary.xmlLibrary_) {
            _loc3_ = _loc10_.@type;
            _loc4_ = ObjectLibrary.propsLibrary_[_loc3_];
            if(_loc4_ && _loc4_.isItem_) {
                _loc4_.desiredLoot_ = false;
                if(_loc4_.isPotion_ && desiredPotion(_loc3_)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootWeaponTier != 999 && desiredWeapon(_loc10_,_loc3_,Parameters.data.autoLootWeaponTier)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootAbilityTier != 999 && desiredAbility(_loc10_,_loc3_,Parameters.data.autoLootAbilityTier)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootArmorTier != 999 && desiredArmor(_loc10_,_loc3_,Parameters.data.autoLootArmorTier)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootRingTier != 999 && desiredRing(_loc10_,_loc3_,Parameters.data.autoLootRingTier)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootUTs && desiredUT(_loc10_)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootSkins && desiredSkin(_loc10_,_loc10_.@id)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootPetSkins && desiredPetSkin(_loc10_,_loc10_.@id,int(_loc10_.@type))) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootKeys && desiredKey(_loc10_,_loc10_.@id)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootMarks && String(_loc10_.@id).indexOf("Mark of ") != -1) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootConsumables && "Consumable" in _loc10_) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootSoulbound && "Soulbound" in _loc10_) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootEggs != -1 && desiredEgg(_loc10_,Parameters.data.autoLootEggs)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootFeedPower != -1 && desiredFeedPower(_loc10_,Parameters.data.autoLootFeedPower)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootXPBonus != -1 && desiredXPBonus(_loc10_,Parameters.data.autoLootXPBonus)) {
                    _loc4_.desiredLoot_ = true;
                } else if(Parameters.data.autoLootStackables && _loc4_.stackable_ || "Quantity" in _loc10_ && "ExtraTooltipData" in _loc10_ && _loc10_.ExtraTooltipData.EffectInfo.(@name == "Stack limit")) {
                    _loc4_.desiredLoot_ = true;
                }
            }
        }
        var _loc8_:* = Parameters.data.autoLootExcludes;
        var _loc18_:int = 0;
        var _loc17_:* = Parameters.data.autoLootExcludes;
        for each(_loc1_ in Parameters.data.autoLootExcludes) {
            _loc4_ = ObjectLibrary.propsLibrary_[_loc1_];
            if(_loc4_) {
                _loc4_.desiredLoot_ = false;
            }
        }
        var _loc6_:* = Parameters.data.autoLootIncludes;
        var _loc20_:int = 0;
        var _loc19_:* = Parameters.data.autoLootIncludes;
        for each(_loc1_ in Parameters.data.autoLootIncludes) {
            _loc4_ = ObjectLibrary.propsLibrary_[_loc1_];
            if(_loc4_) {
                _loc4_.desiredLoot_ = true;
            }
        }
    }

    public static function desiredPotion(param1:int) : Boolean {
        if(Parameters.data.autoLootHPPots) {
            if(hpPotions.indexOf(param1) >= 0) {
                return true;
            }
        }
        if(Parameters.data.autoLootMPPots) {
            if(mpPotions.indexOf(param1) >= 0) {
                return true;
            }
        }
        if(Parameters.data.autoLootLifeManaPots) {
            if(lmPotions.indexOf(param1) >= 0) {
                return true;
            }
        }
        if(Parameters.data.autoLootRainbowPots) {
            if(raPotions.indexOf(param1) >= 0) {
                return true;
            }
        }
        return false;
    }

    public static function desiredWeapon(param1:XML, param2:int, param3:int) : Boolean {
        if(!("SlotType" in param1 && "Tier" in param1)) {
            return false;
        }
        var _loc4_:Vector.<int> = new <int>[3,2,24,17,1,8];
        return param1.Tier >= param3 && _loc4_.indexOf(param1.SlotType) >= 0;
    }

    public static function desiredAbility(param1:XML, param2:int, param3:int) : Boolean {
        if(!("SlotType" in param1 && "Tier" in param1)) {
            return false;
        }
        var _loc4_:Vector.<int> = new <int>[13,16,21,18,22,15,23,12,5,25,19,11,4,20];
        return param1.Tier >= param3 && _loc4_.indexOf(param1.SlotType) >= 0;
    }

    public static function desiredArmor(param1:XML, param2:int, param3:int) : Boolean {
        if(!("SlotType" in param1 && "Tier" in param1)) {
            return false;
        }
        var _loc4_:Vector.<int> = new <int>[6,7,14];
        return param1.Tier >= param3 && _loc4_.indexOf(param1.SlotType) >= 0;
    }

    public static function desiredRing(param1:XML, param2:int, param3:int) : Boolean {
        if(!("SlotType" in param1 && "Tier" in param1)) {
            return false;
        }
        return param1.Tier >= param3 && param1.SlotType == 9;
    }

    public static function desiredUT(param1:XML) : Boolean {
        var _loc2_:int = 0;
        if(!("SlotType" in param1)) {
            return false;
        }
        if("BagType" in param1) {
            _loc2_ = param1.BagType;
            return _loc2_ == 6 || _loc2_ == 9;
        }
        return false;
    }

    public static function desiredST(param1:XML) : Boolean {
        var _loc2_:int = 0;
        if(!("SlotType" in param1)) {
            return false;
        }
        if("BagType" in param1) {
            _loc2_ = param1.BagType;
            return _loc2_ == 8;
        }
        return false;
    }

    public static function desiredSkin(param1:XML, param2:String) : Boolean {
        if(param1.Activate == "UnlockSkin") {
            return true;
        }
        if(param2.lastIndexOf("Mystery Skin") >= 0) {
            return true;
        }
        return false;
    }

    public static function desiredPetSkin(param1:XML, param2:String, param3:int) : Boolean {
        var _loc4_:Vector.<int> = new <int>[8973,8974,8975];
        if(param2.lastIndexOf("Pet Stone") >= 0) {
            return true;
        }
        if(_loc4_.indexOf(param3) >= 0) {
            return true;
        }
        return false;
    }

    public static function desiredKey(param1:XML, param2:String) : Boolean {
        if(param1.Activate == "CreatePortal") {
            return true;
        }
        if(param2.indexOf("Mystery Key") >= 0) {
            return true;
        }
        return false;
    }

    public static function desiredEgg(param1:XML, param2:int) : Boolean {
        var _loc3_:int = 0;
        if("Rarity" in param1) {
            if(param1.Rarity == "Common") {
                _loc3_ = 0;
            } else if(param1.Rarity == "Uncommon") {
                _loc3_ = 1;
            } else if(param1.Rarity == "Rare") {
                _loc3_ = 2;
            } else if(param1.Rarity == "Legendary") {
                _loc3_ = 3;
            }
            return _loc3_ >= param2;
        }
        return false;
    }

    public static function desiredFeedPower(param1:XML, param2:int) : Boolean {
        return "feedPower" in param1 && param1.feedPower >= param2;
    }

    public static function desiredXPBonus(param1:XML, param2:int) : Boolean {
        return "XPBonus" in param1 && param1.XPBonus >= param2;
    }

    public static function setIgnores() : void {
        var _loc2_:* = null;
        var _loc5_:int = 0;
        var _loc4_:* = Parameters.data.AAIgnore;
        for each(var _loc1_ in Parameters.data.AAIgnore) {
            if(_loc1_ in ObjectLibrary.propsLibrary_) {
                _loc2_ = ObjectLibrary.propsLibrary_[_loc1_];
                _loc2_.ignored = true;
            }
            if(_loc1_ in ObjectLibrary.xmlLibrary_) {
                ObjectLibrary.xmlLibrary_[_loc1_].props_.ignored = true;
            }
        }
        var _loc7_:int = 0;
        var _loc6_:* = Parameters.data.AAException;
        for each(var _loc3_ in Parameters.data.AAException) {
            if(_loc3_ in ObjectLibrary.propsLibrary_) {
                _loc2_ = ObjectLibrary.propsLibrary_[_loc3_];
                _loc2_.excepted = true;
            }
            if(_loc3_ in ObjectLibrary.xmlLibrary_) {
                ObjectLibrary.xmlLibrary_[_loc3_].props_.excepted = true;
            }
        }
    }

    public static function save() : void {
        try {
            if(savedOptions_) {
                savedOptions_.flush();
            }
            return;
        }
        catch(error:Error) {
            return;
        }
    }

    public static function setKey(param1:String, param2:uint) : void {
        var _loc5_:int = 0;
        var _loc4_:* = keyNames_;
        for(var _loc3_ in keyNames_) {
            if(data[_loc3_] == param2) {
                data[_loc3_] = 0;
            }
        }
        data[param1] = param2;
    }

    public static function setDefaults() : void {
        setDefaultKey("moveLeft",65);
        setDefaultKey("moveRight",68);
        setDefaultKey("moveUp",87);
        setDefaultKey("moveDown",83);
        setDefaultKey("rotateLeft",81);
        setDefaultKey("rotateRight",69);
        setDefaultKey("useSpecial",32);
        setDefaultKey("interact",86);
        setDefaultKey("useInvSlot1",49);
        setDefaultKey("useInvSlot2",50);
        setDefaultKey("useInvSlot3",51);
        setDefaultKey("useInvSlot4",52);
        setDefaultKey("useInvSlot5",53);
        setDefaultKey("useInvSlot6",54);
        setDefaultKey("useInvSlot7",55);
        setDefaultKey("useInvSlot8",56);
        setDefaultKey("escapeToNexus2",116);
        setDefaultKey("escapeToNexus",82);
        setDefaultKey("autofireToggle",67);
        setDefaultKey("scrollChatUp",33);
        setDefaultKey("scrollChatDown",34);
        setDefaultKey("miniMapZoomOut",189);
        setDefaultKey("miniMapZoomIn",187);
        setDefaultKey("resetToDefaultCameraAngle",70);
        setDefaultKey("togglePerformanceStats",88);
        setDefaultKey("options",79);
        setDefaultKey("toggleCentering",84);
        setDefaultKey("chat",13);
        setDefaultKey("chatCommand",191);
        setDefaultKey("tell",9);
        setDefaultKey("guildChat",71);
        setDefaultKey("toggleFullscreen",0);
        setDefaultKey("quickSlotKey1", KeyCodes.F);
        setDefaultKey("quickSlotKey2", KeyCodes.V);
        setDefaultKey("quickSlotKey3", KeyCodes.T);
        setDefaultKey("friendList",0);
        setDefaultKey("switchTabs",72);
        setDefaultKey("particleEffect",0);
        setDefaultKey("toggleHPBar",0);
        setDefaultKey("toggleProjectiles",0);
        setDefaultKey("toggleMasterParticles",0);
        setDefaultKey("toggleRealmQuestDisplay",0);
        setDefault("playMusic",false);
        setDefault("playSFX",true);
        setDefault("playPewPew",true);
        setDefault("centerOnPlayer",true);
        setDefault("preferredServer",null);
        setDefault("bestServer",null);
        setDefault("needsTutorial",false);
        setDefault("needsRandomRealm",false);
        setDefault("cameraAngle",0);
        setDefault("defaultCameraAngle",0);
        setDefault("showQuestPortraits",true);
        setDefault("fullscreenMode",false);
        setDefault("showProtips",false);
        setDefault("joinDate",MoreDateUtil.getDayStringInPT());
        setDefault("lastDailyAnalytics",null);
        setDefault("allowRotation",true);
        setDefault("allowMiniMapRotation",false);
        setDefault("charIdUseMap",{});
        setDefault("textBubbles",false);
        setDefault("showTradePopup",true);
        setDefault("paymentMethod",null);
        setDefault("filterLanguage",false);
        setDefault("showGuildInvitePopup",true);
        setDefault("showBeginnersOffer",false);
        setDefault("beginnersOfferTimeLeft",0);
        setDefault("beginnersOfferShowNow",false);
        setDefault("beginnersOfferShowNowTime",0);
        setDefault("inventorySwap",true);
        setDefault("particleEffect",false);
        setDefault("disableEnemyParticles",false);
        setDefault("disableAllyShoot",0);
        setDefault("disablePlayersHitParticles",false);
        setDefault("cursorSelect","4");
        setDefault("forceChatQuality",false);
        setDefault("hidePlayerChat",false);
        setDefault("chatStarRequirement",0);
        setDefault("chatAll",true);
        setDefault("chatWhisper",true);
        setDefault("chatGuild",true);
        setDefault("chatTrade",true);
        setDefault("toggleBarText",0);
        setDefault("toggleToMaxText",false);
        setDefault("particleEffect",true);
        setDefault("musicVolume",int("playMusic" in data && data.playMusic));
        setDefault("SFXVolume","playSFX" in data && data.playMusic?0.2:0);
        setDefaultKey("friendList",0);
        setDefault("tradeWithFriends",false);
        setDefault("chatFriend",false);
        setDefault("friendStarRequirement",0);
        setDefault("HPBar",1);
        setDefault("newMiniMapColors",false);
        setDefault("noParticlesMaster",false);
        setDefault("noAllyNotifications",false);
        setDefault("noAllyDamage",false);
        setDefault("noEnemyDamage",false);
        setDefault("forceEXP",1);
        setDefault("showFameGain",false);
        setDefault("curseIndication",false);
        setDefault("showTierTag",true);
        setDefault("characterGlow",0);
        setDefault("gravestones",0);
        setDefault("chatNameColor",0);
        setDefault("expandRealmQuestsDisplay",true);
        setDefault("lastTab","Options.Controls");
        setDefault("ssdebuffBitmask",0);
        setDefault("ssdebuffBitmask2",0);
        setDefault("ccdebuffBitmask",0);
        setDefault("spamFilter",spamFilter);
        setDefault("AutoLootOn",false);
        setDefault("AutoHealPercentage",99);
        setDefault("AAOn",true);
        setDefault("AAMinManaPercent",50);
        setDefault("AATargetLead",true);
        setDefault("AABoundingDist",4);
        setDefault("aimMode",2);
        setDefault("AutoAbilityOn",false);
        setDefault("showQuestBar",false);
        setDefault("AutoNexus",25);
        setDefault("AutoHeal",65);
        setDefault("autoHPPercent",40);
        setDefault("autoMPPercent",-1);
        setDefault("autompPotDelay",200);
        setDefault("TombCycleBoss",3368);
        setDefaultKey("TombCycleKey",0);
        setDefaultKey("anchorTeleport",0);
        setDefaultKey("DrinkAllHotkey",0);
        setDefaultKey("SelfTPHotkey",0);
        setDefaultKey("syncLeadHotkey",118);
        setDefaultKey("syncFollowHotkey",119);
        setDefault("AutoResponder",false);
        setDefault("FocusFPS",false);
        setDefault("bgFPS",10);
        setDefault("fgFPS",60);
        setDefault("hideLockList",false);
        setDefault("hidePets2",1);
        setDefault("hideOtherDamage",false);
        setDefault("mscale",1);
        setDefault("stageScale","noScale");
        setDefault("uiscale",true);
        setDefault("offsetVoidBow",false);
        setDefault("offsetColossus",false);
        setDefault("coloOffset",0.225);
        setDefault("ethDisable",false);
        setDefault("cultiststaffDisable",false);
        setDefault("offsetCelestialBlade",false);
        setDefault("alphaOnOthers",false);
        setDefault("alphaMan",0.4);
        setDefault("lootPreview",true);
        setDefault("showQuestBar",false);
        setDefaultKey("tradeNearestPlayerKey",0);
        setDefaultKey("LowCPUModeHotKey",0);
        setDefaultKey("QuestTeleport",0);
        setDefaultKey("ReconRealm",97);
        setDefaultKey("PassesCoverHotkey",0);
        setDefaultKey("AAHotkey",0);
        setDefaultKey("AAModeHotkey",0);
        setDefaultKey("AutoAbilityHotkey",0);
        setDefaultKey("AutoLootHotkey",0);
        setDefault("damageIgnored",false);
        setDefault("ignoreIce",false);
        setDefaultKey("TextPause",113);
        setDefaultKey("TextThessal",114);
        setDefaultKey("TextDraconis",115);
        setDefaultKey("TextCem",112);
        setDefault("AAException",DefaultAAException);
        setDefault("AAIgnore",DefaultAAIgnore);
        setDefault("CustomPriorityList",DefaultPriorityList);
        setDefault("passThroughInvuln",false);
        setDefault("autoaimAtInvulnerable",false);
        setDefault("showDamageOnEnemy",false);
        setDefault("spellbombHPThreshold",3000);
        setDefault("skullHPThreshold",800);
        setDefault("skullTargets",5);
        setDefault("liteMonitor",true);
        setDefaultKey("TogglePlayerFollow",120);
        setDefaultKey("resetClientHP",0);
        setDefault("skipPopups",false);
        setDefault("TradeDelay",true);
        setDefault("showHPBarOnAlly",true);
        setDefault("showEXPFameOnAlly",true);
        setDefault("showClientStat",false);
        setDefault("liteParticle",false);
        setDefault("onlyAimAtExcepted",false);
        setDefault("ignoreStatusText",false);
        setDefault("ignoreQuiet",false);
        setDefault("ignoreWeak",false);
        setDefault("ignoreSlowed",false);
        setDefault("ignoreSick",false);
        setDefault("ignoreDazed",false);
        setDefault("ignoreStunned",false);
        setDefault("ignoreParalyzed",false);
        setDefault("ignoreBleeding",false);
        setDefault("ignoreArmorBroken",false);
        setDefault("ignorePetStasis",false);
        setDefault("ignorePetrified",false);
        setDefault("ignoreSilenced",false);
        setDefault("ignoreBlind",true);
        setDefault("ignoreHallucinating",true);
        setDefault("ignoreDrunk",true);
        setDefault("ignoreConfused",true);
        setDefault("ignoreUnstable",false);
        setDefault("ignoreDarkness",true);
        setDefault("autoDecrementHP",false);
        setDefault("bigLootBags",false);
        setDefault("replaceCon",false);
        setDefault("AutoSyncClientHP",false);
        setDefault("extraPlayerMenu",true);
        setDefault("safeWalk",false);
        setDefault("evenLowerGraphics",false);
        setDefault("rightClickOption",0);
        setDefault("dynamicHPcolor",true);
        setDefault("uiTextSize",15);
        setDefault("mobNotifier",true);
        setDefault("showMobInfo",false);
        setDefault("aaDistance",1);
        setDefault("hideLowCPUModeChat",false);
        setDefault("tiltCam",false);
        setDefault("showBG",false);
        setDefault("BossPriority",true);
        setDefaultKey("sayCustom1",0);
        setDefaultKey("sayCustom2",0);
        setDefaultKey("sayCustom3",0);
        setDefaultKey("sayCustom4",0);
        setDefault("customMessage1","");
        setDefault("customMessage2","");
        setDefault("customMessage3","");
        setDefault("customMessage4","");
        setDefault("autoLootExcludes",Parameters.defaultExclusions);
        setDefault("autoLootIncludes",Parameters.defaultInclusions);
        setDefault("autoLootUpgrades",false);
        setDefault("autoLootWeaponTier",11);
        setDefault("autoLootAbilityTier",5);
        setDefault("autoLootArmorTier",12);
        setDefault("autoLootRingTier",5);
        setDefault("autoLootSkins",true);
        setDefault("autoLootPetSkins",true);
        setDefault("autoLootKeys",true);
        setDefault("autoLootHPPots",true);
        setDefault("autoLootMPPots",true);
        setDefault("autoLootLifeManaPots",true);
        setDefault("autoLootRainbowPots",true);
        setDefault("autoLootUTs",true);
        setDefault("autoLootXPBonus",5);
        setDefault("autoLootFeedPower",-1);
        setDefault("autoLootMarks",false);
        setDefault("autoLootConsumables",false);
        setDefault("autoLootSoulbound",false);
        setDefault("autoLootEggs",1);
        setDefault("autoLootStackables",true);
        setDefault("showFameGoldRealms",false);
        setDefault("showEnemyCounter",true);
        setDefault("showTimers",true);
        setDefault("showAOGuildies",false);
        setDefault("autoDrinkFromBags",false);
        setDefault("PassesCover",false);
        setDefault("chatLength",10);
        setDefault("autohpPotDelay",400);
        setDefault("mapHack",false);
        setDefault("noRotate",false);
        setDefault("aimAtQuest",0);
        setDefault("followIntoPortals",false);
        setDefault("spamPrismNumber",0);
        setDefault("rightClickSelectAll",false);
        setDefault("shownGotoWarning",false);
        setDefault("selectedItemColor",0);
        setDefault("AutoDungeonEnterList",new Vector.<String>(0));
        setDefault("autoLootInVault",false);
        setDefault("showWhiteBagEffect",true);
        setDefault("customFPS",60);
        setDefault("perfStats",false);
        setDefault("showOrangeBagEffect",false);
        setDefault("showInventoryTooltip",true);
        setDefault("autoEnterPortals",false);
        setDefault("reconnectDelay",0);
        setDefault("mysticAAShootGroup",false);
        setDefaultKey("walkKey",16);
        setDefault("projFace",true);
        setDefault("disableSorting",false);
        setDefault("noClip",false);
        setDefaultKey("noClipKey",0);
        setDefault("fakeLag",0);
        setDefault("renderDistance",16);
        setDefault("showRange",false);
        setDefault("autoDodge",false);
        setDefault("vSync",true);
        setDefault("lastRealmIP","127.0.0.1");
        setDefault("fullscreen",false);
        setDefault("ipClipboard",true);
        setDefault("timeScale",1);
        setDefault("timeScaleArr",new Vector.<Number>(0));
        setDefault("timeScaleArrIndex",0);
        setDefaultKey("timeScaleKey",0);
        setDefault("reducedLava",true);
        setDefault("multiToggle",0);
        setDefault("multiOn",false);
        setDefault("depositKey",101);
        setDefault("tpCursor", KeyCodes.UNSET);
        setDefault("noClipPause", KeyCodes.UNSET);
        setDefault("pauseDelay",0);
        setDefault("customName","");
        setDefault("logErrors", false);
        setDefault("test113Count", 0);
        setDefault("tutorialMode", false);
        setDefaultKey("pauseAnywhere", KeyCodes.UNSET);
        setDefault("tpMulti", 1);
        Options.calculateIgnoreBitmask();
    }

    private static function setDefaultKey(param1:String, param2:uint) : void {
        if(!(param1 in data)) {
            data[param1] = param2;
        }
        keyNames_[param1] = true;
    }

    private static function setDefault(param1:String, param2:*) : void {
        if(!(param1 in data)) {
            data[param1] = param2;
        }
    }
}
}
