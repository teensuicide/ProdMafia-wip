package com.company.assembleegameclient.util {
   import flash.display.DisplayObject;
   
   public class DisplayHierarchy {
       
      
      public function DisplayHierarchy() {
         super();
      }
      
      public static function getParentWithType(param1:DisplayObject, param2:Class) : DisplayObject {
         while(param1 && !(param1 is param2)) {
            param1 = param1.parent;
         }
         return param1;
      }
      
      public static function getParentWithTypeArray(param1:DisplayObject, ... rest) : DisplayObject {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:* = null;
         while(param1) {
            _loc5_ = 0;
            _loc4_ = rest;
            var _loc7_:int = 0;
            var _loc6_:* = rest;
            for each(_loc3_ in rest) {
               if(param1 is _loc3_) {
                  return param1;
               }
            }
            param1 = param1.parent;
         }
         return param1;
      }
   }
}
