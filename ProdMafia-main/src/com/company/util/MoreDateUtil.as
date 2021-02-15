package com.company.util {
   public class MoreDateUtil {
       
      
      public function MoreDateUtil() {
         super();
      }
      
      public static function getDayStringInPT() : String {
         var _loc2_:Date = new Date();
         var _loc1_:Number = _loc2_.getTime();
         _loc1_ = _loc1_ + (_loc2_.timezoneOffset - 420) * 60 * 1000;
         _loc2_.setTime(_loc1_);
         var _loc3_:DateFormatterReplacement = new DateFormatterReplacement();
         _loc3_.formatString = "MMMM D, YYYY";
         return _loc3_.format(_loc2_);
      }
   }
}
