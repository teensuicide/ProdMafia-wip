package com.company.assembleegameclient.util {
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   
   public class TierUtil {
       
      
      public function TierUtil() {
         super();
      }
      
      public static function getTierTag(param1:XML, param2:int = 12) : UILabel {
         var _loc4_:* = null;
         var _loc7_:* = NaN;
         var _loc8_:* = null;
         var _loc6_:* = isPet(param1) == false;
         var _loc5_:* = param1.hasOwnProperty("Consumable") == false;
         var _loc3_:* = param1.hasOwnProperty("InvUse") == false;
         var _loc9_:* = param1.hasOwnProperty("Treasure") == false;
         var _loc11_:* = param1.hasOwnProperty("PetFood") == false;
         var _loc10_:Boolean = param1.hasOwnProperty("Tier");
         if(_loc6_ && _loc5_ && _loc3_ && _loc9_ && _loc11_) {
            _loc4_ = new UILabel();
            if(_loc10_) {
               _loc7_ = 16777215;
               _loc8_ = "T" + param1.Tier;
            } else if(param1.hasOwnProperty("@setType")) {
               _loc7_ = 16750848;
               _loc8_ = "ST";
            } else {
               _loc7_ = 9055202;
               _loc8_ = "UT";
            }
            _loc4_.text = _loc8_;
            DefaultLabelFormat.tierLevelLabel(_loc4_,param2,_loc7_);
            return _loc4_;
         }
         return null;
      }
      
      public static function isPet(param1:XML) : Boolean {
         var _loc2_:* = null;
         var _loc3_:* = param1;
         var _loc5_:* = _loc3_.Activate;
         var _loc4_:* = new XMLList("");
         var _loc7_:* = _loc3_.Activate;
         var _loc8_:int = 0;
         var _loc10_:* = new XMLList("");
         _loc2_ = _loc3_.Activate.(text() == "PermaPet");
         return _loc2_.length() >= 1;
      }
   }
}
