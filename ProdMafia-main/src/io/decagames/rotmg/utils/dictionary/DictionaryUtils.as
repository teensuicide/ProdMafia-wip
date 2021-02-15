package io.decagames.rotmg.utils.dictionary {
   import flash.utils.Dictionary;
   
   public class DictionaryUtils {
       
      
      public function DictionaryUtils() {
         super();
      }
      
      public static function countKeys(param1:Dictionary) : int {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         var _loc4_:* = param1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for(_loc3_ in param1) {
            _loc2_++;
         }
         return _loc2_;
      }
   }
}
