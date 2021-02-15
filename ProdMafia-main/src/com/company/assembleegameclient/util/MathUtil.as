package com.company.assembleegameclient.util {
   public class MathUtil {
      
      public static const TO_DEG:Number = 57.2957795130823;
      
      public static const TO_RAD:Number = 0.0174532925199433;
       
      
      public function MathUtil() {
         super();
      }
      
      public static function round(param1:Number, param2:int = 0) : Number {
         param2 = Math.pow(10,param2);
         return Math.round(param1 * param2) / param2;
      }
   }
}
