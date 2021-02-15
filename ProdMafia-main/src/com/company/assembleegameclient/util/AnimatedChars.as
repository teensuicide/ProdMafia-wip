package com.company.assembleegameclient.util {
   import flash.utils.Dictionary;
   
   public class AnimatedChars {
      
      private static var nameMap_:Dictionary = new Dictionary();
       
      
      public function AnimatedChars() {
         super();
      }
      
      public static function getAnimatedChar(param1:String, param2:int) : AnimatedChar {
         var _loc3_:Vector.<AnimatedChar> = nameMap_[param1];
         if(_loc3_ == null || param2 >= _loc3_.length) {
            return null;
         }
         return _loc3_[param2];
      }
      
      public static function add(param1:String, param2:AnimatedChar) : void {
         if(!nameMap_) {
            nameMap_ = new Dictionary();
         }
         if(!nameMap_[param1]) {
            nameMap_[param1] = new Vector.<AnimatedChar>();
         }
         nameMap_[param1].push(param2);
      }
   }
}
