package com.company.assembleegameclient.util {
   public class ColorUtil {
       
      
      public function ColorUtil() {
         super();
      }
      
      public static function rangeRandomSmart(param1:uint, param2:uint) : Number {
         var _loc6_:uint = param1 >> 16 & 255;
         var _loc5_:uint = param1 >> 8 & 255;
         var _loc3_:uint = param1 & 255;
         var _loc9_:uint = param2 >> 16 & 255;
         var _loc8_:uint = param2 >> 8 & 255;
         var _loc7_:uint = param2 & 255;
         var _loc4_:uint = _loc9_ + Math.random() * (_loc6_ - _loc9_);
         var _loc10_:uint = _loc8_ + Math.random() * (_loc5_ - _loc8_);
         var _loc11_:uint = _loc7_ + Math.random() * (_loc3_ - _loc7_);
         return _loc4_ << 16 | _loc10_ << 8 | _loc11_;
      }
      
      public static function randomSmart(param1:uint) : Number {
         var _loc2_:uint = param1 >> 16 & 255;
         var _loc4_:uint = param1 >> 8 & 255;
         var _loc3_:uint = param1 & 255;
         var _loc5_:uint = Math.max(0,Math.min(255,_loc2_ + RandomUtil.plusMinus(_loc2_ * 0.05)));
         var _loc7_:uint = Math.max(0,Math.min(255,_loc4_ + RandomUtil.plusMinus(_loc4_ * 0.05)));
         var _loc6_:uint = Math.max(0,Math.min(255,_loc3_ + RandomUtil.plusMinus(_loc3_ * 0.05)));
         return _loc5_ << 16 | _loc7_ << 8 | _loc6_;
      }
      
      public static function rangeRandomMix(param1:uint, param2:uint) : Number {
         var _loc8_:uint = param1 >> 16 & 255;
         var _loc6_:uint = param1 >> 8 & 255;
         var _loc3_:uint = param1 & 255;
         var _loc7_:uint = param2 >> 16 & 255;
         var _loc9_:uint = param2 >> 8 & 255;
         var _loc11_:uint = param2 & 255;
         var _loc12_:Number = Math.random();
         var _loc4_:uint = _loc7_ + _loc12_ * (_loc8_ - _loc7_);
         var _loc5_:uint = _loc9_ + _loc12_ * (_loc6_ - _loc9_);
         var _loc10_:uint = _loc11_ + _loc12_ * (_loc3_ - _loc11_);
         return _loc4_ << 16 | _loc5_ << 8 | _loc10_;
      }
      
      public static function rangeRandom(param1:uint, param2:uint) : Number {
         return param2 + Math.random() * (param1 - param2);
      }
   }
}
