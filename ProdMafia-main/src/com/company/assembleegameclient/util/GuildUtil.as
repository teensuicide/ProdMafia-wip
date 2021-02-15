package com.company.assembleegameclient.util {
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   
   public class GuildUtil {
      
      public static const INITIATE:int = 0;
      
      public static const MEMBER:int = 10;
      
      public static const OFFICER:int = 20;
      
      public static const LEADER:int = 30;
      
      public static const FOUNDER:int = 40;
      
      public static const MAX_MEMBERS:int = 50;
       
      
      public function GuildUtil() {
         super();
      }
      
      public static function rankToString(param1:int) : String {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case 0:
               return wrapInBraces("GuildUtil.initiate");
            case 10:
               return wrapInBraces("GuildUtil.member");
            case 20:
               return wrapInBraces("GuildUtil.officer");
            case 30:
               return wrapInBraces("GuildUtil.leader");
            case 40:
               return wrapInBraces("GuildUtil.founder");
            default:
               return "Unknown " + param1;
         }
      }
      
      public static function rankToIcon(param1:int, param2:int) : BitmapData {
         var _loc3_:* = null;
         var _loc4_:* = param1;
         var _loc5_:* = _loc4_;
         switch(_loc5_) {
            case 0:
               _loc3_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",20);
               break;
            case 10:
               _loc3_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",19);
               break;
            case 20:
               _loc3_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",18);
               break;
            case 30:
               _loc3_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",17);
               break;
            case 40:
               _loc3_ = AssetLibrary.getImageFromSet("lofiInterfaceBig",16);
         }
         return TextureRedrawer.redraw(_loc3_,param2,true,0,true);
      }
      
      public static function guildFameIcon(param1:int) : BitmapData {
         var _loc2_:BitmapData = AssetLibrary.getImageFromSet("lofiObj3",226);
         return TextureRedrawer.redraw(_loc2_,param1,true,0,true);
      }
      
      public static function allowedChange(param1:int, param2:int, param3:int) : Boolean {
         if(param2 == param3) {
            return false;
         }
         if(param1 == 40 && param2 < 40 && param3 < 40) {
            return true;
         }
         if(param1 == 30 && param2 < 30 && param3 <= 30) {
            return true;
         }
         if(param1 == 20 && param2 < 20 && param3 < 20) {
            return true;
         }
         return false;
      }
      
      public static function promotedRank(param1:int) : int {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case 0:
               return 10;
            case 10:
               return 20;
            case 20:
               return 30;
            default:
               return 40;
         }
      }
      
      public static function canPromote(param1:int, param2:int) : Boolean {
         var _loc3_:int = promotedRank(param2);
         return allowedChange(param1,param2,_loc3_);
      }
      
      public static function demotedRank(param1:int) : int {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case 20:
               return 10;
            case 30:
               return 20;
            case 40:
               return 30;
            default:
               return 0;
         }
      }
      
      public static function canDemote(param1:int, param2:int) : Boolean {
         var _loc3_:int = demotedRank(param2);
         return allowedChange(param1,param2,_loc3_);
      }
      
      public static function canRemove(param1:int, param2:int) : Boolean {
         return param1 >= 20 && param2 < param1;
      }
      
      public static function getRankIconIdByRank(param1:int) : Number {
         var _loc2_:* = NaN;
         var _loc3_:* = param1;
         var _loc4_:* = _loc3_;
         switch(_loc4_) {
            case 0:
               _loc2_ = 20;
               break;
            case 10:
               _loc2_ = 19;
               break;
            case 20:
               _loc2_ = 18;
               break;
            case 30:
               _loc2_ = 17;
               break;
            case 40:
               _loc2_ = 16;
         }
         return _loc2_;
      }
      
      private static function wrapInBraces(param1:String) : String {
         return "{" + param1 + "}";
      }
   }
}
