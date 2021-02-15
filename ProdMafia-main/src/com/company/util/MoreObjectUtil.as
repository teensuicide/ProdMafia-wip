package com.company.util {
   public class MoreObjectUtil {
       
      
      public function MoreObjectUtil() {
         super();
      }
      
      public static function addToObject(param1:Object, param2:Object) : void {
         var _loc3_:* = undefined;
         var _loc4_:* = param2;
         var _loc7_:int = 0;
         var _loc6_:* = param2;
         for(_loc3_ in param2) {
            param1[_loc3_] = param2[_loc3_];
         }
      }
   }
}
