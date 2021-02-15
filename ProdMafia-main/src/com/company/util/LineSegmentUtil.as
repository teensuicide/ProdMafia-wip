package com.company.util {
   import flash.geom.Point;
   
   public class LineSegmentUtil {
       
      
      public function LineSegmentUtil() {
         super();
      }
      
      public static function intersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Point {
         var _loc11_:Number = (param8 - param6) * (param3 - param1) - (param7 - param5) * (param4 - param2);
         if(_loc11_ == 0) {
            return null;
         }
         var _loc12_:Number = ((param7 - param5) * (param2 - param6) - (param8 - param6) * (param1 - param5)) / _loc11_;
         var _loc9_:Number = ((param3 - param1) * (param2 - param6) - (param4 - param2) * (param1 - param5)) / _loc11_;
         if(_loc12_ > 1 || _loc12_ < 0 || _loc9_ > 1 || _loc9_ < 0) {
            return null;
         }
         var _loc10_:Point = new Point(param1 + _loc12_ * (param3 - param1),param2 + _loc12_ * (param4 - param2));
         return _loc10_;
      }
      
      public static function pointDistance(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number {
         var _loc10_:* = NaN;
         var _loc9_:* = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Number = param5 - param3;
         var _loc12_:Number = param6 - param4;
         var _loc11_:Number = _loc7_ * _loc7_ + _loc12_ * _loc12_;
         if(_loc11_ < 0.001) {
            _loc10_ = param3;
            _loc9_ = param4;
         } else {
            _loc8_ = ((param1 - param3) * _loc7_ + (param2 - param4) * _loc12_) / _loc11_;
            if(_loc8_ < 0) {
               _loc10_ = param3;
               _loc9_ = param4;
            } else if(_loc8_ > 1) {
               _loc10_ = param5;
               _loc9_ = param6;
            } else {
               _loc10_ = Number(param3 + _loc8_ * _loc7_);
               _loc9_ = Number(param4 + _loc8_ * _loc12_);
            }
         }
         _loc7_ = param1 - _loc10_;
         _loc12_ = param2 - _loc9_;
         return Math.sqrt(_loc7_ * _loc7_ + _loc12_ * _loc12_);
      }
   }
}
