package com.company.util {
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RectangleUtil {
       
      
      public function RectangleUtil() {
         super();
      }
      
      public static function pointDist(param1:Rectangle, param2:Number, param3:Number) : Number {
         var _loc5_:* = param2;
         var _loc4_:* = param3;
         if(_loc5_ < param1.x) {
            _loc5_ = param1.x;
         } else if(_loc5_ > param1.right) {
            _loc5_ = param1.right;
         }
         if(_loc4_ < param1.y) {
            _loc4_ = param1.y;
         } else if(_loc4_ > param1.bottom) {
            _loc4_ = param1.bottom;
         }
         if(_loc5_ == param2 && _loc4_ == param3) {
            return 0;
         }
         return PointUtil.distanceXY(_loc5_,_loc4_,param2,param3);
      }
      
      public static function pointDistSquared(param1:Rectangle, param2:Number, param3:Number) : Number {
         var _loc5_:* = param2;
         var _loc4_:* = param3;
         if(_loc5_ < param1.x) {
            _loc5_ = param1.x;
         } else if(_loc5_ > param1.right) {
            _loc5_ = param1.right;
         }
         if(_loc4_ < param1.y) {
            _loc4_ = param1.y;
         } else if(_loc4_ > param1.bottom) {
            _loc4_ = param1.bottom;
         }
         if(_loc5_ == param2 && _loc4_ == param3) {
            return 0;
         }
         return PointUtil.distanceSquaredXY(_loc5_,_loc4_,param2,param3);
      }
      
      public static function closestPoint(param1:Rectangle, param2:Number, param3:Number) : Point {
         var _loc5_:* = param2;
         var _loc4_:* = param3;
         if(_loc5_ < param1.x) {
            _loc5_ = param1.x;
         } else if(_loc5_ > param1.right) {
            _loc5_ = param1.right;
         }
         if(_loc4_ < param1.y) {
            _loc4_ = param1.y;
         } else if(_loc4_ > param1.bottom) {
            _loc4_ = param1.bottom;
         }
         return new Point(_loc5_,_loc4_);
      }
      
      public static function lineSegmentIntersectsXY(param1:Rectangle, param2:Number, param3:Number, param4:Number, param5:Number) : Boolean {
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:* = NaN;
         var _loc12_:* = NaN;
         if(param1.left > param2 && param1.left > param4 || param1.right < param2 && param1.right < param4 || param1.top > param3 && param1.top > param5 || param1.bottom < param3 && param1.bottom < param5) {
            return false;
         }
         if(param1.left < param2 && param2 < param1.right && param1.top < param3 && param3 < param1.bottom || param1.left < param4 && param4 < param1.right && param1.top < param5 && param5 < param1.bottom) {
            return true;
         }
         var _loc10_:Number = (param5 - param3) / (param4 - param2);
         var _loc13_:Number = param3 - _loc10_ * param2;
         if(_loc10_ > 0) {
            _loc8_ = _loc10_ * param1.left + _loc13_;
            _loc7_ = _loc10_ * param1.right + _loc13_;
         } else {
            _loc8_ = _loc10_ * param1.right + _loc13_;
            _loc7_ = _loc10_ * param1.left + _loc13_;
         }
         if(param3 < param5) {
            _loc12_ = param3;
            _loc6_ = param5;
         } else {
            _loc12_ = param5;
            _loc6_ = param3;
         }
         var _loc11_:Number = _loc8_ > _loc12_?_loc8_:Number(_loc12_);
         var _loc9_:Number = _loc7_ < _loc6_?_loc7_:Number(_loc6_);
         return _loc11_ < _loc9_ && !(_loc9_ < param1.top || _loc11_ > param1.bottom);
      }
      
      public static function lineSegmentIntersectXY(param1:Rectangle, param2:Number, param3:Number, param4:Number, param5:Number, param6:Point) : Boolean {
         var _loc7_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param4 <= param1.x) {
            _loc7_ = (param5 - param3) / (param4 - param2);
            _loc9_ = param3 - param2 * _loc7_;
            _loc10_ = _loc7_ * param1.x + _loc9_;
            if(_loc10_ >= param1.y && _loc10_ <= param1.y + param1.height) {
               param6.x = param1.x;
               param6.y = _loc10_;
               return true;
            }
         } else if(param4 >= param1.x + param1.width) {
            _loc7_ = (param5 - param3) / (param4 - param2);
            _loc9_ = param3 - param2 * _loc7_;
            _loc10_ = _loc7_ * (param1.x + param1.width) + _loc9_;
            if(_loc10_ >= param1.y && _loc10_ <= param1.y + param1.height) {
               param6.x = param1.x + param1.width;
               param6.y = _loc10_;
               return true;
            }
         }
         if(param5 <= param1.y) {
            _loc7_ = (param4 - param2) / (param5 - param3);
            _loc9_ = param2 - param3 * _loc7_;
            _loc8_ = _loc7_ * param1.y + _loc9_;
            if(_loc8_ >= param1.x && _loc8_ <= param1.x + param1.width) {
               param6.x = _loc8_;
               param6.y = param1.y;
               return true;
            }
         } else if(param5 >= param1.y + param1.height) {
            _loc7_ = (param4 - param2) / (param5 - param3);
            _loc9_ = param2 - param3 * _loc7_;
            _loc8_ = _loc7_ * (param1.y + param1.height) + _loc9_;
            if(_loc8_ >= param1.x && _loc8_ <= param1.x + param1.width) {
               param6.x = _loc8_;
               param6.y = param1.y + param1.height;
               return true;
            }
         }
         return false;
      }
      
      public static function lineSegmentIntersect(param1:Rectangle, param2:IntPoint, param3:IntPoint) : Point {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param3.x() <= param1.x) {
            _loc6_ = (param3.y() - param2.y()) / (param3.x() - param2.x());
            _loc5_ = param2.y() - param2.x() * _loc6_;
            _loc4_ = _loc6_ * param1.x + _loc5_;
            if(_loc4_ >= param1.y && _loc4_ <= param1.y + param1.height) {
               return new Point(param1.x,_loc4_);
            }
         } else if(param3.x() >= param1.x + param1.width) {
            _loc6_ = (param3.y() - param2.y()) / (param3.x() - param2.x());
            _loc5_ = param2.y() - param2.x() * _loc6_;
            _loc4_ = _loc6_ * (param1.x + param1.width) + _loc5_;
            if(_loc4_ >= param1.y && _loc4_ <= param1.y + param1.height) {
               return new Point(param1.x + param1.width,_loc4_);
            }
         }
         if(param3.y() <= param1.y) {
            _loc6_ = (param3.x() - param2.x()) / (param3.y() - param2.y());
            _loc5_ = param2.x() - param2.y() * _loc6_;
            _loc7_ = _loc6_ * param1.y + _loc5_;
            if(_loc7_ >= param1.x && _loc7_ <= param1.x + param1.width) {
               return new Point(_loc7_,param1.y);
            }
         } else if(param3.y() >= param1.y + param1.height) {
            _loc6_ = (param3.x() - param2.x()) / (param3.y() - param2.y());
            _loc5_ = param2.x() - param2.y() * _loc6_;
            _loc7_ = _loc6_ * (param1.y + param1.height) + _loc5_;
            if(_loc7_ >= param1.x && _loc7_ <= param1.x + param1.width) {
               return new Point(_loc7_,param1.y + param1.height);
            }
         }
         return null;
      }
      
      public static function getRotatedRectExtents2D(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Extents2D {
         var _loc10_:* = null;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc8_:Matrix = new Matrix();
         _loc8_.translate(-param4 * 0.5,-param5 * 0.5);
         _loc8_.rotate(param3);
         _loc8_.translate(param1,param2);
         var _loc6_:Extents2D = new Extents2D();
         var _loc9_:Point = new Point();
         while(_loc11_ <= 1) {
            _loc7_ = 0;
            while(_loc7_ <= 1) {
               _loc9_.x = _loc11_ * param4;
               _loc9_.y = _loc7_ * param5;
               _loc10_ = _loc8_.transformPoint(_loc9_);
               _loc6_.add(_loc10_.x,_loc10_.y);
               _loc7_++;
            }
            _loc11_++;
         }
         return _loc6_;
      }
   }
}
