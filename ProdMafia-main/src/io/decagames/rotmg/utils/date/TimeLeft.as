package io.decagames.rotmg.utils.date {
   public class TimeLeft {
       
      
      public function TimeLeft() {
         super();
      }
      
      public static function parse(param1:int, param2:String) : String {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param2.indexOf("%d") >= 0) {
            _loc5_ = Math.floor(param1 / 86400);
            param1 = param1 - _loc5_ * 86400;
            param2 = param2.replace("%d",_loc5_);
         }
         if(param2.indexOf("%h") >= 0) {
            _loc4_ = Math.floor(param1 / 3600);
            param1 = param1 - _loc4_ * 3600;
            param2 = param2.replace("%h",_loc4_);
         }
         if(param2.indexOf("%m") >= 0) {
            _loc3_ = Math.floor(param1 / 60);
            param1 = param1 - _loc3_ * 60;
            param2 = param2.replace("%m",_loc3_);
         }
         return param2.replace("%s",param1);
      }
      
      public static function getStartTimeString(param1:Date) : String {
         var _loc2_:String = "";
         var _loc4_:Date = new Date();
         var _loc3_:Number = (param1.time - _loc4_.time) / 1000;
         if(_loc3_ <= 0) {
            return "";
         }
         if(_loc3_ > 86400) {
            _loc2_ = _loc2_ + TimeLeft.parse(_loc3_,"%dd %hh");
         } else if(_loc3_ > 3600) {
            _loc2_ = _loc2_ + TimeLeft.parse(_loc3_,"%hh %mm");
         } else if(_loc3_ > 60) {
            _loc2_ = _loc2_ + TimeLeft.parse(_loc3_,"%mm %ss");
         } else {
            _loc2_ = _loc2_ + TimeLeft.parse(_loc3_,"%ss");
         }
         return _loc2_;
      }
   }
}
