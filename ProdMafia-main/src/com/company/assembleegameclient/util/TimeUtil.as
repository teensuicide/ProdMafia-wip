package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.utils.getTimer;
   
   public class TimeUtil {
      
      public static const DAY_IN_MS:int = 86400000;
      
      public static const DAY_IN_S:int = 86400;
      
      public static const HOUR_IN_S:int = 3600;
      
      public static const MIN_IN_S:int = 60;
      
      public static var moddedTime:int = -1;
      
      public static var prevTrueTime:int = -1;
      
      public function TimeUtil() {
         super();
      }
      
      public static function getTrueTime() : int {
         return getTimer();
      }
      
      public static function getModdedTime() : int {
         var time:int = getTimer();
         var _loc1_:Number = Parameters.data.timeScale;
         if(moddedTime == -1) {
            moddedTime = int(time * _loc1_);
         }
         moddedTime += (prevTrueTime == -1?0:int((time - prevTrueTime) * _loc1_));
         prevTrueTime = time;
         return moddedTime;
      }

      public static function secondsToDays(param1:Number) : Number {
         return param1 / 86400;
      }
      
      public static function secondsToHours(param1:Number) : Number {
         return param1 / 3600;
      }
      
      public static function secondsToMins(param1:Number) : Number {
         return param1 / 60;
      }
      
      public static function parseUTCDate(param1:String) : Date {
         var _loc2_:Array = param1.match(/(\d\d\d\d)-(\d\d)-(\d\d) (\d\d):(\d\d):(\d\d)/);
         var _loc3_:Date = new Date();
         _loc3_.setUTCFullYear(_loc2_[1],_loc2_[2] - 1,_loc2_[3]);
         _loc3_.setUTCHours(_loc2_[4],_loc2_[5],_loc2_[6],0);
         return _loc3_;
      }
      
      public static function humanReadableTime(param1:int) : String {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         _loc5_ = param1 >= 0?param1:0;
         _loc3_ = _loc5_ / 86400;
         _loc5_ = _loc5_ % 86400;
         _loc4_ = _loc5_ / 3600;
         _loc5_ = _loc5_ % 3600;
         _loc2_ = _loc5_ / 60;
         return _getReadableTime(param1,_loc3_,_loc4_,_loc2_);
      }
      
      private static function _getReadableTime(param1:int, param2:int, param3:int, param4:int) : String {
         var _loc5_:* = null;
         if(param1 >= 86400) {
            if(param3 == 0 && param4 == 0) {
               _loc5_ = param2.toString() + (param2 > 1?"days":"day");
               return _loc5_;
            }
            if(param4 == 0) {
               _loc5_ = param2.toString() + (param2 > 1?" days":" day");
               _loc5_ = _loc5_ + (", " + param3.toString() + (param3 > 1?" hours":" hour"));
               return _loc5_;
            }
            _loc5_ = param2.toString() + (param2 > 1?" days":" day");
            _loc5_ = _loc5_ + (", " + param3.toString() + (param3 > 1?" hours":" hour"));
            _loc5_ = _loc5_ + (" and " + param4.toString() + (param4 > 1?" minutes":" minute"));
            return _loc5_;
         }
         if(param1 >= 3600) {
            if(param4 == 0) {
               _loc5_ = param3.toString() + (param3 > 1?" hours":" hour");
               return _loc5_;
            }
            _loc5_ = param3.toString() + (param3 > 1?" hours":" hour");
            _loc5_ = _loc5_ + (" and " + param4.toString() + (param4 > 1?" minutes":" minute"));
            return _loc5_;
         }
         _loc5_ = param4.toString() + (param4 > 1?" minutes":" minute");
         return _loc5_;
      }
   }
}
