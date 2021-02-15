package com.company.util {
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapUtil {
      
      static const zeroPoint:Point = new Point(0,0);
      
      static var rect:Rectangle = new Rectangle();
       
      
      public function BitmapUtil(param1:StaticEnforcer_2478) {
         super();
      }
      
      public static function mirror(param1:BitmapData, param2:int = 0) : BitmapData {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(param2 == 0) {
            param2 = param1.width;
         }
         var _loc5_:int = param1.height;
         var _loc3_:BitmapData = new BitmapData(param1.width,_loc5_,true,0);
         while(_loc4_ < param2) {
            _loc6_ = 0;
            while(_loc6_ < _loc5_) {
               _loc3_.setPixel32(param2 - _loc4_ - 1,_loc6_,param1.getPixel32(_loc4_,_loc6_));
               _loc6_++;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function rotateBitmapData(param1:BitmapData, param2:int) : BitmapData {
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(-param1.width * 0.5,-param1.height * 0.5);
         _loc4_.rotate(param2 * 1.5707963267949);
         _loc4_.translate(param1.height * 0.5,param1.width * 0.5);
         var _loc3_:BitmapData = new BitmapData(param1.height,param1.width,true,0);
         _loc3_.draw(param1,_loc4_);
         return _loc3_;
      }
      
      public static function cropToBitmapData(param1:BitmapData, param2:int, param3:int, param4:int, param5:int, param6:int = 0, param7:int = 0, param8:int = 0) : BitmapData {
         var _loc9_:BitmapData = new BitmapData(param4,param5,true,0);
         rect.x = param2;
         rect.y = param3;
         rect.width = param4;
         rect.height = param5;
         _loc9_.copyPixels(param1,rect,new Point(param6 + param7,param6 + param8));
         return _loc9_;
      }
      
      public static function amountTransparent(param1:BitmapData) : Number {
         var _loc7_:int = 0;
         var _loc6_:* = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = param1.width;
         var _loc5_:int = param1.height;
         while(_loc4_ < _loc3_) {
            _loc7_ = 0;
            while(_loc7_ < _loc5_) {
               _loc6_ = uint(param1.getPixel32(_loc4_,_loc7_) & 4278190080);
               if(_loc6_ == 0) {
                  _loc2_++;
               }
               _loc7_++;
            }
            _loc4_++;
         }
         return _loc2_ / (_loc3_ * _loc5_);
      }
      
      public static function mostCommonColor(param1:BitmapData) : uint {
         var _loc4_:* = 0;
         var _loc10_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:* = null;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc12_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:Dictionary = new Dictionary();
         while(_loc11_ < param1.width) {
            _loc7_ = 0;
            while(_loc7_ < param1.width) {
               _loc4_ = uint(param1.getPixel32(_loc11_,_loc7_));
               if((_loc4_ & 4278190080) != 0) {
                  if(!_loc2_.hasOwnProperty(_loc4_.toString())) {
                     _loc2_[_loc4_] = 1;
                  } else {
                     _loc3_ = _loc2_;
                     _loc6_ = _loc4_;
                     _loc5_ = uint(_loc3_[_loc6_] + 1);
                     _loc3_[_loc6_] = _loc5_;
                  }
               }
               _loc7_++;
            }
            _loc11_++;
         }
         var _loc14_:int = 0;
         var _loc13_:* = _loc2_;
         for(_loc10_ in _loc2_) {
            _loc4_ = uint(parseInt(_loc10_));
            _loc8_ = _loc2_[_loc10_];
            if(_loc8_ > _loc9_ || _loc8_ == _loc9_ && _loc4_ > _loc12_) {
               _loc12_ = _loc4_;
               _loc9_ = uint(_loc8_);
            }
         }
         return _loc12_;
      }
      
      public static function lineOfSight(param1:BitmapData, param2:IntPoint, param3:IntPoint) : Boolean {
         var _loc4_:* = 0;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc21_:* = int(param1.width);
         var _loc10_:* = int(param1.height);
         var _loc15_:* = int(param2.x());
         var _loc6_:* = int(param2.y());
         var _loc18_:* = int(param3.x());
         var _loc19_:* = int(param3.y());
         var _loc11_:* = (_loc6_ > _loc19_?_loc6_ - _loc19_:Number(_loc19_ - _loc6_)) > (_loc15_ > _loc18_?_loc15_ - _loc18_:Number(_loc18_ - _loc15_));
         if(_loc11_) {
            _loc4_ = _loc15_;
            _loc15_ = _loc6_;
            _loc6_ = _loc4_;
            _loc4_ = _loc18_;
            _loc18_ = _loc19_;
            _loc19_ = _loc4_;
            _loc4_ = _loc21_;
            _loc21_ = _loc10_;
            _loc10_ = _loc4_;
         }
         if(_loc15_ > _loc18_) {
            _loc4_ = _loc15_;
            _loc15_ = _loc18_;
            _loc18_ = _loc4_;
            _loc4_ = _loc6_;
            _loc6_ = _loc19_;
            _loc19_ = _loc4_;
         }
         var _loc7_:int = _loc18_ - _loc15_;
         var _loc17_:int = _loc6_ > _loc19_?_loc6_ - _loc19_:Number(_loc19_ - _loc6_);
         var _loc14_:int = -(_loc7_ + 1) * 0.5;
         var _loc9_:int = _loc6_ > _loc19_?-1:1;
         var _loc16_:int = _loc18_ > _loc21_ - 1?_loc21_ - 1:_loc18_;
         var _loc12_:* = _loc6_;
         var _loc20_:* = _loc15_;
         if(_loc20_ < 0) {
            _loc14_ = _loc14_ + _loc17_ * -_loc20_;
            if(_loc14_ >= 0) {
               _loc5_ = _loc14_ / _loc7_ + 1;
               _loc12_ = _loc12_ + _loc9_ * _loc5_;
               _loc14_ = _loc14_ - _loc5_ * _loc7_;
            }
            _loc20_ = 0;
         }
         if(_loc9_ > 0 && _loc12_ < 0 || _loc9_ < 0 && _loc12_ >= _loc10_) {
            _loc8_ = _loc9_ > 0?-_loc12_ - 1:Number(_loc12_ - _loc10_);
            _loc14_ = _loc14_ - _loc7_ * _loc8_;
            _loc13_ = -_loc14_ / _loc17_;
            _loc20_ = _loc20_ + _loc13_;
            _loc14_ = _loc14_ + _loc13_ * _loc17_;
            _loc12_ = _loc12_ + _loc8_ * _loc9_;
         }
         while(_loc20_ <= _loc16_) {
            if(!(_loc9_ > 0 && _loc12_ >= _loc10_ || _loc9_ < 0 && _loc12_ < 0)) {
               if(_loc11_) {
                  if(_loc12_ >= 0 && _loc12_ < _loc10_ && param1.getPixel(_loc12_,_loc20_) == 0) {
                     return false;
                  }
               } else if(_loc12_ >= 0 && _loc12_ < _loc10_ && param1.getPixel(_loc20_,_loc12_) == 0) {
                  return false;
               }
               _loc14_ = _loc14_ + _loc17_;
               if(_loc14_ >= 0) {
                  _loc12_ = _loc12_ + _loc9_;
                  _loc14_ = _loc14_ - _loc7_;
               }
               _loc20_++;
               continue;
            }
            break;
         }
         return true;
      }
   }
}

class StaticEnforcer_2478 {
    
   
   function StaticEnforcer_2478() {
      super();
   }
}
