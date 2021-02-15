package com.company.util {
   import flash.utils.ByteArray;
   
   public class MoreStringUtil {
       
      
      public function MoreStringUtil() {
         super();
      }
      
      public static function hexStringToByteArray(param1:String) : ByteArray {
         var _loc4_:* = 0;
         var _loc3_:ByteArray = new ByteArray();
         var _loc2_:uint = param1.length;
         while(_loc4_ < _loc2_) {
            _loc3_.writeByte(parseInt(param1.substr(_loc4_,2),16));
            _loc4_ = uint(_loc4_ + 2);
         }
         return _loc3_;
      }
      
      public static function enterFrame(param1:String) : Boolean {
         return param1.indexOf(".cf") != -1;
      }
      
      public static function up(param1:String, param2:String) : Boolean {
         return param2 == param1.substring(param1.length - param2.length);
      }
      
      public static function left(param1:String) : Number {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         _loc2_.position = 0;
         return _loc2_.readDouble();
      }
      
      public static function right(param1:Number) : String {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeDouble(param1);
         _loc2_.position = 0;
         return _loc2_.readUTFBytes(8);
      }
      
      public static function countCharInString(param1:String, param2:String) : int {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length) {
            if(param1.charAt(_loc3_) == param2) {
               _loc4_++;
            }
            _loc3_++;
         }
         return _loc4_;
      }
   }
}
