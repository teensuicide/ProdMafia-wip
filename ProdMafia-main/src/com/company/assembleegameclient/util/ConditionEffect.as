package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.PointUtil;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   
   public class ConditionEffect {
      
      public static const NOTHING:uint = 0;
      
      public static const DEAD:uint = 1;
      
      public static const QUIET:uint = 2;
      
      public static const WEAK:uint = 3;
      
      public static const SLOWED:uint = 4;
      
      public static const SICK:uint = 5;
      
      public static const DAZED:uint = 6;
      
      public static const STUNNED:uint = 7;
      
      public static const BLIND:uint = 8;
      
      public static const HALLUCINATING:uint = 9;
      
      public static const DRUNK:uint = 10;
      
      public static const CONFUSED:uint = 11;
      
      public static const STUN_IMMUNE:uint = 12;
      
      public static const INVISIBLE:uint = 13;
      
      public static const PARALYZED:uint = 14;
      
      public static const SPEEDY:uint = 15;
      
      public static const BLEEDING:uint = 16;
      
      public static const ARMOR_BROKEN_IMMUNE:uint = 17;
      
      public static const HEALING:uint = 18;
      
      public static const DAMAGING:uint = 19;
      
      public static const BERSERK:uint = 20;
      
      public static const PAUSED:uint = 21;
      
      public static const STASIS:uint = 22;
      
      public static const STASIS_IMMUNE:uint = 23;
      
      public static const INVINCIBLE:uint = 24;
      
      public static const INVULNERABLE:uint = 25;
      
      public static const ARMORED:uint = 26;
      
      public static const ARMOR_BROKEN:uint = 27;
      
      public static const HEXED:uint = 28;
      
      public static const NINJA_SPEEDY:uint = 29;
      
      public static const UNSTABLE:uint = 30;
      
      public static const DARKNESS:uint = 31;
      
      public static const SLOWED_IMMUNE:uint = 32;
      
      public static const DAZED_IMMUNE:uint = 33;
      
      public static const PARALYZED_IMMUNE:uint = 34;
      
      public static const PETRIFIED:uint = 35;
      
      public static const PETRIFIED_IMMUNE:uint = 36;
      
      public static const PET_EFFECT_ICON:uint = 37;
      
      public static const CURSE:uint = 38;
      
      public static const CURSE_IMMUNE:uint = 39;
      
      public static const HP_BOOST:uint = 40;
      
      public static const MP_BOOST:uint = 41;
      
      public static const ATT_BOOST:uint = 42;
      
      public static const DEF_BOOST:uint = 43;
      
      public static const SPD_BOOST:uint = 44;
      
      public static const VIT_BOOST:uint = 45;
      
      public static const WIS_BOOST:uint = 46;
      
      public static const DEX_BOOST:uint = 47;
      
      public static const SILENCED:uint = 48;
      
      public static const EXPOSED:uint = 49;
      
      public static const ENERGIZED:uint = 50;
      
      public static const HP_DEBUFF:uint = 51;
      
      public static const MP_DEBUFF:uint = 52;
      
      public static const ATT_DEBUFF:uint = 53;
      
      public static const DEF_DEBUFF:uint = 54;
      
      public static const SPD_DEBUFF:uint = 55;
      
      public static const VIT_DEBUFF:uint = 56;
      
      public static const WIS_DEBUFF:uint = 57;
      
      public static const DEX_DEBUFF:uint = 58;
      
      public static const INSPIRED:uint = 59;
      
      public static const GROUND_DAMAGE:uint = 99;
      
      public static const DEAD_BIT:uint = 1;
      
      public static const QUIET_BIT:uint = 2;
      
      public static const WEAK_BIT:uint = 4;
      
      public static const SLOWED_BIT:uint = 8;
      
      public static const SICK_BIT:uint = 16;
      
      public static const DAZED_BIT:uint = 32;
      
      public static const STUNNED_BIT:uint = 64;
      
      public static const BLIND_BIT:uint = 128;
      
      public static const HALLUCINATING_BIT:uint = 256;
      
      public static const DRUNK_BIT:uint = 512;
      
      public static const CONFUSED_BIT:uint = 1024;
      
      public static const STUN_IMMUNE_BIT:uint = 2048;
      
      public static const INVISIBLE_BIT:uint = 4096;
      
      public static const PARALYZED_BIT:uint = 8192;
      
      public static const SPEEDY_BIT:uint = 16384;
      
      public static const BLEEDING_BIT:uint = 32768;
      
      public static const ARMOR_BROKEN_IMMUNE_BIT:uint = 65536;
      
      public static const HEALING_BIT:uint = 131072;
      
      public static const DAMAGING_BIT:uint = 262144;
      
      public static const BERSERK_BIT:uint = 524288;
      
      public static const PAUSED_BIT:uint = 1048576;
      
      public static const STASIS_BIT:uint = 2097152;
      
      public static const STASIS_IMMUNE_BIT:uint = 4194304;
      
      public static const INVINCIBLE_BIT:uint = 8388608;
      
      public static const INVULNERABLE_BIT:uint = 16777216;
      
      public static const ARMORED_BIT:uint = 33554432;
      
      public static const ARMOR_BROKEN_BIT:uint = 67108864;
      
      public static const HEXED_BIT:uint = 134217728;
      
      public static const NINJA_SPEEDY_BIT:uint = 268435456;
      
      public static const UNSTABLE_BIT:uint = 536870912;
      
      public static const DARKNESS_BIT:uint = 1073741824;
      
      public static const SLOWED_IMMUNE_BIT:uint = 1;
      
      public static const DAZED_IMMUNE_BIT:uint = 2;
      
      public static const PARALYZED_IMMUNE_BIT:uint = 4;
      
      public static const PETRIFIED_BIT:uint = 8;
      
      public static const PETRIFIED_IMMUNE_BIT:uint = 16;
      
      public static const PET_EFFECT_ICON_BIT:uint = 32;
      
      public static const CURSE_BIT:uint = 64;
      
      public static const CURSE_IMMUNE_BIT:uint = 128;
      
      public static const HP_BOOST_BIT:uint = 256;
      
      public static const MP_BOOST_BIT:uint = 512;
      
      public static const ATT_BOOST_BIT:uint = 1024;
      
      public static const DEF_BOOST_BIT:uint = 2048;
      
      public static const SPD_BOOST_BIT:uint = 4096;
      
      public static const VIT_BOOST_BIT:uint = 8192;
      
      public static const WIS_BOOST_BIT:uint = 16384;
      
      public static const DEX_BOOST_BIT:uint = 32768;
      
      public static const SILENCED_BIT:uint = 65536;
      
      public static const EXPOSED_BIT:uint = 131072;
      
      public static const ENERGIZED_BIT:uint = 262144;
      
      public static const HP_DEBUFF_BIT:uint = 524288;
      
      public static const MP_DEBUFF_BIT:uint = 1048576;
      
      public static const ATT_DEBUFF_BIT:uint = 2097152;
      
      public static const DEF_DEBUFF_BIT:uint = 4194304;
      
      public static const SPD_DEBUFF_BIT:uint = 8388608;
      
      public static const VIT_DEBUFF_BIT:uint = 16777216;
      
      public static const WIS_DEBUFF_BIT:uint = 33554432;
      
      public static const DEX_DEBUFF_BIT:uint = 67108864;
      
      public static const INSPIRED_BIT:uint = 134217728;
      
      public static const MAP_FILTER_BITMASK:uint = 1049216;
      
      public static const PROJ_NOHIT_BITMASK:uint = 11534336;
      
      public static const CE_FIRST_BATCH:uint = 0;
      
      public static const CE_SECOND_BATCH:uint = 1;
      
      public static const NUMBER_CE_BATCHES:uint = 2;
      
      public static const NEW_CON_THRESHOLD:uint = 32;
      
      public static const GLOW_FILTER:GlowFilter = new GlowFilter(0,0.3,6,6,2,1,false,false);
      
      public static var effects_:Vector.<ConditionEffect> = new <ConditionEffect>[new ConditionEffect("Nothing",0,null,"Nothing"),new ConditionEffect("Dead",1,null,"Dead"),new ConditionEffect("Quiet",2,[32],"Quiet"),new ConditionEffect("Weak",4,[34,35,36,37],"Weak"),new ConditionEffect("Slowed",8,[1],"Slowed"),new ConditionEffect("Sick",16,[39],"Sick"),new ConditionEffect("Dazed",32,[44],"Dazed"),new ConditionEffect("Stunned",64,[45],"Stunned"),new ConditionEffect("Blind",128,[41],"Blind"),new ConditionEffect("Hallucinating",256,[42],"Hallucinating"),new ConditionEffect("Drunk",512,[43],"Drunk"),new ConditionEffect("Confused",1024,[2],"Confused"),new ConditionEffect("Stun Immune",2048,null,"Stun Immune"),new ConditionEffect("Invisible",4096,null,"Invisible"),new ConditionEffect("Paralyzed",8192,[53,54],"Paralyzed"),new ConditionEffect("Speedy",16384,[0],"Speedy"),new ConditionEffect("Bleeding",32768,[46],"Bleeding"),new ConditionEffect("Armor Broken Immune",65536,null,"Armor Broken Immune"),new ConditionEffect("Healing",131072,[47],"Healing"),new ConditionEffect("Damaging",262144,[49],"Damaging"),new ConditionEffect("Berserk",524288,[50],"Berserk"),new ConditionEffect("Paused",1048576,null,"Paused"),new ConditionEffect("Stasis",2097152,null,"Stasis"),new ConditionEffect("Stasis Immune",4194304,null,"Stasis Immune"),new ConditionEffect("Invincible",8388608,null,"Invincible"),new ConditionEffect("Invulnerable",16777216,[17],"Invulnerable"),new ConditionEffect("Armored",33554432,[16],"Armored"),new ConditionEffect("Armor Broken",67108864,[55],"Armor Broken"),new ConditionEffect("Hexed",134217728,[42],"Hexed"),new ConditionEffect("Ninja Speedy",268435456,[0],"Ninja Speedy"),new ConditionEffect("Unstable",536870912,[56],"Unstable"),new ConditionEffect("Darkness",1073741824,[57],"Darkness"),new ConditionEffect("Slowed Immune",1,null,"Slowed Immune"),new ConditionEffect("Dazed Immune",2,null,"Dazed Immune"),new ConditionEffect("Paralyzed Immune",4,null,"Paralyzed Immune"),new ConditionEffect("Petrify",8,null,"Petrify"),new ConditionEffect("Petrify Immune",16,null,"Petrify Immune"),new ConditionEffect("Pet Disable",32,[27],"Pet Stasis",true),new ConditionEffect("Curse",64,[58],"Curse"),new ConditionEffect("Curse Immune",128,null,"Curse Immune"),new ConditionEffect("HP Boost",256,[32],"HP Boost",true),new ConditionEffect("MP Boost",512,[33],"MP Boost",true),new ConditionEffect("Att Boost",1024,[34],"Att Boost",true),new ConditionEffect("Def Boost",2048,[35],"Def Boost",true),new ConditionEffect("Spd Boost",4096,[36],"Spd Boost",true),new ConditionEffect("Vit Boost",8192,[38],"Vit Boost",true),new ConditionEffect("Wis Boost",16384,[39],"Wis Boost",true),new ConditionEffect("Dex Boost",32768,[37],"Dex Boost",true),new ConditionEffect("Silenced",65536,[33],"Silenced"),new ConditionEffect("Exposed",131072,[59],"Exposed"),new ConditionEffect("Energized",262144,[60],"Energized"),new ConditionEffect("HP Debuff",524288,[48],"HP Debuff",true),new ConditionEffect("MP Debuff",1048576,[49],"MP Debuff",true),new ConditionEffect("Att Debuff",2097152,[50],"Att Debuff",true),new ConditionEffect("Def Debuff",4194304,[51],"Def Debuff",true),new ConditionEffect("Spd Debuff",8388608,[52],"Spd Debuff",true),new ConditionEffect("Vit Debuff",16777216,[54],"Vit Debuff",true),new ConditionEffect("Wis Debuff",33554432,[55],"Wis Debuff",true),new ConditionEffect("Dex Debuff",67108864,[53],"Dex Debuff",true),new ConditionEffect("Inspired",134217728,[62],"Inspired")];
      
      private static var conditionEffectFromName_:Object = null;
      
      private static var bitToIcon_:Object = null;
      
      private static var bitToIcon2_:Object = null;
       
      
      public var name_:String;
      
      public var bit_:uint;
      
      public var iconOffsets_:Array;
      
      public var localizationKey_:String;
      
      public var icon16Bit_:Boolean;
      
      public function ConditionEffect(param1:String, param2:uint, param3:Array, param4:String = "", param5:Boolean = false) {
         super();
         this.name_ = param1;
         this.bit_ = param2;
         this.iconOffsets_ = param3;
         this.localizationKey_ = param4;
         this.icon16Bit_ = param5;
      }
      
      public static function getConditionEffectFromName(param1:XML) : uint {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         if(conditionEffectFromName_ == null) {
            conditionEffectFromName_ = {};
            _loc2_ = uint(effects_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_) {
               conditionEffectFromName_[effects_[_loc3_].name_] = _loc3_;
               _loc3_++;
            }
         }
         return conditionEffectFromName_[param1];
      }
      
      public static function getConditionEffectIcons(param1:uint, param2:Vector.<BitmapData>, param3:int) : void {
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:* = undefined;
         while(param1 != 0) {
            _loc6_ = uint(param1 & param1 - 1);
            _loc5_ = uint(param1 ^ _loc6_);
            _loc4_ = getIconsFromBit(_loc5_);
            if(_loc4_) {
               param2.push(_loc4_[param3 % _loc4_.length]);
            }
            param1 = _loc6_;
         }
      }
      
      public static function getConditionEffectIcons2(param1:uint, param2:Vector.<BitmapData>, param3:int) : void {
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:* = undefined;
         while(param1 != 0) {
            _loc6_ = uint(param1 & param1 - 1);
            _loc5_ = uint(param1 ^ _loc6_);
            _loc4_ = getIconsFromBit2(_loc5_);
            if(_loc4_ != null) {
               param2.push(_loc4_[param3 % _loc4_.length]);
            }
            param1 = _loc6_;
         }
      }
      
      private static function getIconsFromBit(param1:uint) : Vector.<BitmapData> {
         var _loc6_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = null;
         var _loc2_:* = undefined;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         if(bitToIcon_ == null) {
            bitToIcon_ = {};
            _loc5_ = new Matrix();
            _loc5_.translate(4,4);
            _loc6_ = 0;
            while(_loc6_ < 32) {
               _loc2_ = null;
               if(effects_[_loc6_].iconOffsets_) {
                  _loc2_ = new Vector.<BitmapData>();
                  _loc4_ = uint(effects_[_loc6_].iconOffsets_.length);
                  _loc7_ = 0;
                  while(_loc7_ < _loc4_) {
                     _loc3_ = new BitmapData(16,16,true,0);
                     _loc3_.draw(AssetLibrary.getImageFromSet("lofiInterface2",effects_[_loc6_].iconOffsets_[_loc7_]),_loc5_);
                     _loc3_ = GlowRedrawer.outlineGlow(_loc3_,4294967295);
                     _loc3_.applyFilter(_loc3_,_loc3_.rect,PointUtil.ORIGIN,GLOW_FILTER);
                     _loc2_.push(_loc3_);
                     _loc7_++;
                  }
               }
               bitToIcon_[effects_[_loc6_].bit_] = _loc2_;
               _loc6_++;
            }
         }
         return bitToIcon_[param1];
      }
      
      private static function getIconsFromBit2(param1:uint) : Vector.<BitmapData> {
         var _loc4_:* = 0;
         var _loc7_:* = undefined;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:uint = effects_.length;
         if(bitToIcon2_ == null) {
            bitToIcon2_ = [];
            _loc7_ = new Vector.<BitmapData>();
            _loc6_ = new Matrix();
            _loc6_.translate(4,4);
            _loc5_ = new Matrix();
            _loc5_.translate(1.5,1.5);
            _loc2_ = 32;
            while(_loc2_ < _loc8_) {
               _loc7_ = null;
               if(effects_[_loc2_].iconOffsets_) {
                  _loc7_ = new Vector.<BitmapData>();
                  _loc4_ = uint(effects_[_loc2_].iconOffsets_.length);
                  _loc3_ = 0;
                  while(_loc3_ < _loc4_) {
                     if(effects_[_loc2_].icon16Bit_) {
                        _loc9_ = new BitmapData(18,18,true,0);
                        _loc9_.draw(AssetLibrary.getImageFromSet("lofiInterfaceBig",effects_[_loc2_].iconOffsets_[_loc3_]),_loc5_);
                     } else {
                        _loc9_ = new BitmapData(16,16,true,0);
                        _loc9_.draw(AssetLibrary.getImageFromSet("lofiInterface2",effects_[_loc2_].iconOffsets_[_loc3_]),_loc6_);
                     }
                     _loc9_ = GlowRedrawer.outlineGlow(_loc9_,4294967295);
                     _loc9_.applyFilter(_loc9_,_loc9_.rect,PointUtil.ORIGIN,GLOW_FILTER);
                     _loc7_.push(_loc9_);
                     _loc3_++;
                  }
               }
               bitToIcon2_[effects_[_loc2_].bit_] = _loc7_;
               _loc2_++;
            }
         }
         if(bitToIcon2_ && bitToIcon2_[param1]) {
            return bitToIcon2_[param1];
         }
         return null;
      }
   }
}
