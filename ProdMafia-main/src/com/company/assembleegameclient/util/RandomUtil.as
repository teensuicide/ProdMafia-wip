package com.company.assembleegameclient.util {
   public class RandomUtil {
      
      static const chars:String = "abcdefghijkmnopqrstuvwxyz";
       
      
      public function RandomUtil() {
         super();
      }
      
      public static function randomString(param1:int) : String {
         var _loc2_:int = 0;
         var _loc3_:String = "abcdefghijkmnopqrstuvwxyz".charAt(Math.floor(Math.random() * 25));
         _loc2_ = 1;
         while(_loc2_ < param1) {
            _loc3_ = _loc3_ + "abcdefghijkmnopqrstuvwxyz".charAt(Math.floor(Math.random() * 25));
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function plusMinus(param1:Number) : Number {
         return Math.random() * param1 * 2 - param1;
      }
      
      public static function randomRange(param1:Number, param2:Number) : Number {
         return Math.ceil(Math.random() * (param2 - param1)) + param1;
      }
   }
}
