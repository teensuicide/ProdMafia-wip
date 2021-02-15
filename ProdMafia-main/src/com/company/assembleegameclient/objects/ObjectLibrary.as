package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.objects.animation.AnimationsData;
   import com.company.assembleegameclient.util.ConditionEffect;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.ConversionUtil;
   import com.company.util.PointUtil;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import kabam.rotmg.assets.EmbeddedData;
   
   public class ObjectLibrary {
      
      public static const IMAGE_SET_NAME:String = "lofiObj3";
      
      public static const IMAGE_ID:int = 255;

      public static const defaultForgeables:Vector.<int> = new <int>[];

      public static const forgePropsLibrary:Dictionary = new Dictionary();

      public static const propsLibrary_:Dictionary = new Dictionary();
      
      public static const xmlLibrary_:Dictionary = new Dictionary();
      
      public static const setLibrary_:Dictionary = new Dictionary();
      
      public static const idToType_:Dictionary = new Dictionary();

      public static const idToTypeLower:Dictionary = new Dictionary();

      public static const typeToDisplayId_:Dictionary = new Dictionary();
      
      public static const typeToTextureData_:Dictionary = new Dictionary();
      
      public static const typeToTopTextureData_:Dictionary = new Dictionary();
      
      public static const typeToAnimationsData_:Dictionary = new Dictionary();
      
      public static const petXMLDataLibrary_:Dictionary = new Dictionary();
      
      public static const skinSetXMLDataLibrary_:Dictionary = new Dictionary();
      
      public static const dungeonToPortalTextureData_:Dictionary = new Dictionary();
      
      public static const petSkinIdToPetType_:Dictionary = new Dictionary();
      
      public static const dungeonsXMLLibrary_:Dictionary = new Dictionary(true);
      
      public static const ENEMY_FILTER_LIST:Vector.<String> = new <String>["None","Hp","Defense"];
      
      public static const TILE_FILTER_LIST:Vector.<String> = new <String>["ALL","Walkable","Unwalkable","Slow","Speed=1"];
      
      public static const defaultProps_:ObjectProperties = new ObjectProperties(null);
      
      public static const TYPE_MAP:Object = {
         "ArenaGuard":ArenaGuard,
         "ArenaPortal":ArenaPortal,
         "Blacksmith":GameObject,
         "CaveWall":GameObject,
         "Character":Character,
         "CharacterChanger":CharacterChanger,
         "VaultContainer":VaultContainer,
         "VaultGiftContainer":VaultGiftContainer,
         "PremiumVaultContainer":PremiumVaultContainer,
         "ConnectedWall":GameObject,
         "Container":Container,
         "DoubleWall":DoubleWall,
         "GameObject":GameObject,
         "FortuneTeller":GameObject,
         "GuildBoard":GuildBoard,
         "GuildChronicle":GuildChronicle,
         "GuildHallPortal":GuildHallPortal,
         "GuildMerchant":GuildMerchant,
         "GuildRegister":GuildRegister,
         "Merchant":Merchant,
         "MoneyChanger":MoneyChanger,
         "MysteryBoxGround":MysteryBoxGround,
         "NameChanger":NameChanger,
         "ReskinVendor":ReskinVendor,
         "OneWayContainer":OneWayContainer,
         "Player":Player,
         "Portal":Portal,
         "Projectile":Projectile,
         "QuestRewards":QuestRewards,
         "DailyLoginRewards":DailyLoginRewards,
         "Sign":Sign,
         "SpiderWeb":GameObject,
         "Stalagmite":GameObject,
         "Wall":Wall,
         "Pet":Pet,
         "PetUpgrader":PetUpgrader,
         "YardUpgrader":YardUpgrader,
         "WallOfFame":WallOfFame
      };
      
      public static var textureDataFactory:TextureDataFactory = new TextureDataFactory();
      
      public static var playerChars_:Vector.<XML> = new Vector.<XML>();
      
      public static var hexTransforms_:Vector.<XML> = new Vector.<XML>();
      
      public static var playerClassAbbr_:Dictionary = new Dictionary();
      
      public static var itemIds_:Vector.<String> = new Vector.<String>();
      
      private static var currentDungeon:String = "";
       
      
      public function ObjectLibrary() {
         super();
      }
      
      public static function parseDungeonXML(param1:String, param2:XML) : void {
         var _loc4_:int = param1.indexOf("_") + 1;
         var _loc3_:int = param1.indexOf("CXML");
         if(param1.indexOf("_ObjectsCXML") == -1 && param1.indexOf("_StaticObjectsCXML") == -1) {
            if(param1.indexOf("Objects") != -1) {
               _loc3_ = param1.indexOf("ObjectsCXML");
            } else if(param1.indexOf("Object") != -1) {
               _loc3_ = param1.indexOf("ObjectCXML");
            }
         }
         currentDungeon = param1.substr(_loc4_,_loc3_ - _loc4_);
         dungeonsXMLLibrary_[currentDungeon] = new Dictionary(true);
         parseFromXML(param2,parseDungeonCallbak);
      }

      public static function parseForgeXML(xml:XML) : void {
         var objType:int, objId:String;
         for each (var child:XML in xml.ForgeProperties) {
            objType = child.@type; objId = child.@id;
            var props:ForgeProperties = new ForgeProperties(child);
            forgePropsLibrary[objType] = props;
            if (props.canCraft && !props.blueprintRequired)
               defaultForgeables.push(objType);
         }
      }
      
      public static function parseFromXML(param1:XML, param2:Function = null) : void {
         var _loc6_:int = 0;
         var _loc8_:Boolean = false;
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc11_:String = null;
         var _loc7_:* = null;
         var _loc4_:* = [29053,29053,29054,29258,29259,29260,29261,29262,29308,29309,29550,29551,2050,2051,2052,2053,6282];
         var _loc3_:* = param1.Object;
         var _loc13_:int = 0;
         var _loc12_:* = param1.Object;
         for each(_loc9_ in param1.Object) {
            _loc11_ = String(_loc9_.@id);
            _loc7_ = _loc11_;
            if("DisplayId" in _loc9_) {
               _loc7_ = _loc9_.DisplayId;
            }
            if("Group" in _loc9_) {
               if(_loc9_.Group == "Hexable") {
                  hexTransforms_.push(_loc9_);
               }
            }
            _loc6_ = _loc9_.@type;
            if(_loc4_.indexOf(_loc6_) >= 0) {
               _loc9_.Class = "Character";
            }
            if("PetBehavior" in _loc9_ || "PetAbility" in _loc9_) {
               petXMLDataLibrary_[_loc6_] = _loc9_;
            } else {
               propsLibrary_[_loc6_] = new ObjectProperties(_loc9_);
               xmlLibrary_[_loc6_] = _loc9_;
               idToType_[_loc11_] = _loc6_;
               idToTypeLower[_loc11_.toLowerCase()] = _loc6_;
               typeToDisplayId_[_loc6_] = _loc7_;
               if(param2) {
                  param2(_loc6_,_loc9_);
               }
               if(_loc9_.Class == "Player") {
                  playerClassAbbr_[_loc6_] = String(_loc9_.@id).substr(0,2);
                  _loc8_ = false;
                  _loc10_ = 0;
                  while(_loc10_ < playerChars_.length) {
                     if(int(playerChars_[_loc10_].@type) == _loc6_) {
                        playerChars_[_loc10_] = _loc9_;
                        _loc8_ = true;
                     }
                     _loc10_++;
                  }
                  if(!_loc8_) {
                     playerChars_.push(_loc9_);
                  }
               }
               typeToTextureData_[_loc6_] = textureDataFactory.create(_loc9_);
               if("Top" in _loc9_) {
                  typeToTopTextureData_[_loc6_] = textureDataFactory.create(XML(_loc9_.Top));
               }
               if("Animation" in _loc9_) {
                  typeToAnimationsData_[_loc6_] = new AnimationsData(_loc9_);
               }
               if("IntergamePortal" in _loc9_ && "DungeonName" in _loc9_) {
                  dungeonToPortalTextureData_[_loc9_.DungeonName] = typeToTextureData_[_loc6_];
               }
               if(_loc9_.Class == "Pet" && "DefaultSkin" in _loc9_) {
                  petSkinIdToPetType_[_loc9_.DefaultSkin] = _loc6_;
               }
            }
         }
      }
      
      public static function getIdFromType(param1:int) : String {
         var _loc2_:XML = xmlLibrary_[param1];
         if(_loc2_ == null) {
            return null;
         }
         return String(_loc2_.@id);
      }
      
      public static function getSetXMLFromType(param1:int) : XML {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(setLibrary_[param1] != undefined) {
            return setLibrary_[param1];
         }
         var _loc4_:* = EmbeddedData.skinsEquipmentSetsXML.EquipmentSet;
         var _loc7_:int = 0;
         var _loc6_:* = EmbeddedData.skinsEquipmentSetsXML.EquipmentSet;
         for each(_loc2_ in EmbeddedData.skinsEquipmentSetsXML.EquipmentSet) {
            _loc3_ = _loc2_.@type;
            setLibrary_[_loc3_] = _loc2_;
         }
         return setLibrary_[param1];
      }
      
      public static function getPropsFromId(param1:String) : ObjectProperties {
         var _loc2_:int = idToType_[param1];
         return propsLibrary_[_loc2_];
      }
      
      public static function getPropsFromType(param1:int) : ObjectProperties {
         return propsLibrary_[param1];
      }
      
      public static function getXMLfromId(param1:String) : XML {
         var _loc2_:int = idToType_[param1];
         return xmlLibrary_[_loc2_];
      }
      
      public static function getObjectFromType(param1:int) : GameObject {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = param1;
         _loc4_ = xmlLibrary_[_loc3_];
         if(_loc4_) {
            _loc5_ = _loc4_.Class;
            _loc2_ = TYPE_MAP[_loc5_] || makeClass(_loc5_);
            return new _loc2_(_loc4_);
         }
         return null;
      }


      public static function getItemIcon(_arg_1:int):BitmapData {
         var _local4:int = 0;
         var _local8:int = 0;
         var _local10:* = null;
         var _local7:* = null;
         var _local3:* = null;
         var _local9:* = null;
         var _local2:* = null;
         var _local6:* = null;
         var _local5:Matrix = new Matrix();
         if (_arg_1 == -1) {
            _local10 = scaleBitmapData(AssetLibrary.getImageFromSet("lofiInterface", 7), 2);
            _local5.translate(4, 4);
            _local7 = new BitmapData(22, 22, true, 0);
            _local7.draw(_local10, _local5);
            return _local7;
         }
         _local3 = xmlLibrary_[_arg_1];
         _local9 = typeToTextureData_[_arg_1];
         _local2 = !!_local9 ? _local9.mask_ : null;
         _local4 = "Tex1" in _local3 ? _local3.Tex1 : 0;
         _local8 = "Tex2" in _local3 ? _local3.Tex2 : 0;
         _local6 = getTextureFromType(_arg_1);
         if (_local4 > 0 || _local8 > 0) {
            _local6 = TextureRedrawer.retextureNoSizeChange(_local6, _local2, _local4, _local8);
            _local5.scale(0.2, 0.2);
         }
         _local10 = scaleBitmapData(_local6, _local6.rect.width == 16 ? 1 : 2);
         _local5.translate(4, 4);
         _local7 = new BitmapData(22, 22, true, 0);
         _local7.draw(_local10, _local5);
         _local7 = GlowRedrawer.outlineGlow(_local7, 0);
         _local7.applyFilter(_local7, _local7.rect, PointUtil.ORIGIN, ConditionEffect.GLOW_FILTER);
         return _local7;
      }

      public static function scaleBitmapData(_arg_1:BitmapData, _arg_2:Number):BitmapData {
         _arg_2 = Math.abs(_arg_2);
         var _local6:BitmapData = new BitmapData(_arg_1.width * _arg_2, _arg_1.height * _arg_2, true, 0);
         var _local4:Matrix = new Matrix();
         _local4.scale(_arg_2, _arg_2);
         _local6.draw(_arg_1, _local4);
         return _local6;
      }
      
      public static function getTextureFromType(param1:int) : BitmapData {
         var _loc2_:TextureData = typeToTextureData_[param1];
         if(_loc2_ == null) {
            return null;
         }
         return _loc2_.getTexture();
      }
      
      public static function getBitmapData(param1:int) : BitmapData {
         var _loc2_:TextureData = typeToTextureData_[param1];
         var _loc3_:BitmapData = !!_loc2_?_loc2_.getTexture():null;
         if(_loc3_) {
            return _loc3_;
         }
         return AssetLibrary.getImageFromSet("lofiObj3",255);
      }
      
      public static function getRedrawnTextureFromType(param1:int, param2:int, param3:Boolean, param4:Boolean = true, param5:Number = 5) : BitmapData {
         var _loc8_:BitmapData = getBitmapData(param1);
         var _loc10_:BitmapData = param1 in typeToTextureData_ && typeToTextureData_[param1]?typeToTextureData_[param1].mask_:null;
         var _loc9_:XML = xmlLibrary_[param1];
         var _loc7_:int = "Tex1" in _loc9_?_loc9_.Tex1:0;
         var _loc6_:int = "Tex2" in _loc9_?_loc9_.Tex2:0;
         param2 = param2 * (8 / Math.max(_loc8_.width,_loc8_.height));
         return TextureRedrawer.redraw(_loc8_,param2,param3,0,param4,param5,0,1.4,false,_loc10_,_loc7_,_loc6_);
      }
      
      public static function getSizeFromType(param1:int) : int {
         var _loc2_:XML = xmlLibrary_[param1];
         if(!("Size" in _loc2_)) {
            return 100;
         }
         return _loc2_.Size;
      }
      
      public static function getSlotTypeFromType(param1:int) : int {
         var _loc2_:XML = xmlLibrary_[param1];
         if(!("SlotType" in _loc2_)) {
            return -1;
         }
         return _loc2_.SlotType;
      }
      
      public static function isEquippableByPlayer(param1:int, param2:Player) : Boolean {
         var _loc3_:int = 0;
         if(param1 == -1) {
            return false;
         }
         var _loc5_:XML = xmlLibrary_[param1];
         var _loc4_:int = _loc5_.SlotType.toString();
         while(_loc3_ < 4) {
            if(param2.slotTypes_[_loc3_] == _loc4_) {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function getMatchingSlotIndex(param1:int, param2:Player) : int {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1 != -1) {
            _loc5_ = xmlLibrary_[param1];
            if(!_loc5_) {
               _loc5_ = xmlLibrary_[3141];
            }
            _loc4_ = _loc5_.SlotType;
            _loc3_ = 0;
            while(_loc3_ < 4) {
               if(param2.slotTypes_[_loc3_] == _loc4_) {
                  return _loc3_;
               }
               _loc3_++;
            }
         }
         return -1;
      }
      
      public static function isUsableByPlayer(param1:int, param2:Player) : Boolean {
         var _loc3_:int = 0;
         if(param2 == null || param2.slotTypes_ == null) {
            return true;
         }
         var _loc5_:XML = xmlLibrary_[param1];
         if(_loc5_ == null || !("SlotType" in _loc5_)) {
            return false;
         }
         var _loc4_:int = _loc5_.SlotType;
         if(_loc4_ == 10 || _loc4_ == 26) {
            return true;
         }
         _loc3_ = 0;
         while(_loc3_ < param2.slotTypes_.length) {
            if(param2.slotTypes_[_loc3_] == _loc4_) {
               return true;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function isSoulbound(param1:int) : Boolean {
         var _loc2_:XML = xmlLibrary_[param1];
         return _loc2_ && "Soulbound" in _loc2_;
      }
      
      public static function isDropTradable(param1:int) : Boolean {
         var _loc2_:XML = xmlLibrary_[param1];
         return _loc2_ && _loc2_.hasOwnProperty("DropTradable");
      }
      
      public static function usableBy(param1:int) : Vector.<String> {
         var _loc10_:* = undefined;
         var _loc8_:int = 0;
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc2_:XML = xmlLibrary_[param1];
         if(_loc2_ == null || !("SlotType" in _loc2_)) {
            return null;
         }
         var _loc7_:int = _loc2_.SlotType;
         if(_loc7_ == 10 || _loc7_ == 9 || _loc7_ == 26) {
            return null;
         }
         var _loc9_:Vector.<String> = new Vector.<String>();
         var _loc6_:* = playerChars_;
         var _loc12_:int = 0;
         var _loc11_:* = playerChars_;
         for each(_loc4_ in playerChars_) {
            _loc10_ = ConversionUtil.toIntVector(_loc4_.SlotTypes);
            _loc5_ = uint(_loc10_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc5_) {
               if(_loc10_[_loc8_] == _loc7_) {
                  _loc9_.push(typeToDisplayId_[int(_loc4_.@type)]);
                  break;
               }
               _loc8_++;
            }
         }
         return _loc9_;
      }
      
      public static function playerMeetsRequirements(param1:int, param2:Player) : Boolean {
         var _loc3_:* = null;
         if(param2 == null) {
            return true;
         }
         var _loc5_:XML = xmlLibrary_[param1];
         var _loc6_:* = _loc5_.EquipRequirement;
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_.EquipRequirement;
         for each(_loc3_ in _loc5_.EquipRequirement) {
            if(!playerMeetsRequirement(_loc3_,param2)) {
               return false;
            }
         }
         return true;
      }
      
      public static function playerMeetsRequirement(param1:XML, param2:Player) : Boolean {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1.toString() == "Stat") {
            _loc3_ = param1.@value;
            _loc4_ = param1.@stat;
            var _loc5_:* = _loc4_;
            switch(_loc5_) {
               case 0:
                  return param2.maxHP_ >= _loc3_;
               case 3:
                  return param2.maxMP_ >= _loc3_;
               case 7:
                  return param2.level_ >= _loc3_;
               case 20:
                  return param2.attack_ >= _loc3_;
               case 21:
                  return param2.defense_ >= _loc3_;
               case 22:
                  return param2.speed_ >= _loc3_;
               case 26:
                  return param2.vitality_ >= _loc3_;
               case 27:
                  return param2.wisdom >= _loc3_;
               case 28:
                  return param2.dexterity_ >= _loc3_;
            }
         }
         return false;
      }
      
      public static function getPetDataXMLByType(param1:int) : XML {
         return petXMLDataLibrary_[param1];
      }
      
      public static function searchItems(param1:String) : Vector.<int> {
         return new Vector.<int>();
      }
      
      private static function parseDungeonCallbak(param1:int, param2:XML) : void {
         if(currentDungeon != "" && dungeonsXMLLibrary_[currentDungeon] != null) {
            dungeonsXMLLibrary_[currentDungeon][param1] = param2;
         }
      }
      
      private static function makeClass(param1:String) : Class {
         var _loc2_:String = "com.company.assembleegameclient.objects." + param1;
         return getDefinitionByName(_loc2_) as Class;
      }
   }
}
