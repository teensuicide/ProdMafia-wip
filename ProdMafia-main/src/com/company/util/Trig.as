package com.company.util {
   public class Trig {

      public static const toDegrees:Number = (180 / Math.PI);//57.2957795130823
      public static const toRadians:Number = (Math.PI / 180);//0.0174532925199433
       
      
      public function Trig(param1:StaticEnforcer_2846) {
         super();
      }
      
      public static function slerp(param1:Number, param2:Number, param3:Number) : Number {
         var _loc4_:* = Infinity;
         if(param1 > param2) {
            if(param1 - param2 > 3.14159265358979) {
               _loc4_ = param1 * (1 - param3) + (param2 + 6.28318530717959) * param3;
            } else {
               _loc4_ = param1 * (1 - param3) + param2 * param3;
            }
         } else if(param2 - param1 > 3.14159265358979) {
            _loc4_ = (param1 + 6.28318530717959) * (1 - param3) + param2 * param3;
         } else {
            _loc4_ = param1 * (1 - param3) + param2 * param3;
         }
         if(_loc4_ < -3.14159265358979 || _loc4_ > 3.14159265358979) {
            _loc4_ = boundToPI(_loc4_);
         }
         return _loc4_;
      }
      
      public static function angleDiff(param1:Number, param2:Number) : Number {
         if(param1 > param2) {
            if(param1 - param2 > 3.14159265358979) {
               return param2 + 6.28318530717959 - param1;
            }
            return param1 - param2;
         }
         if(param2 - param1 > 3.14159265358979) {
            return param1 + 6.28318530717959 - param2;
         }
         return param2 - param1;
      }
      
      public static function sin(param1:Number) : Number {
         var _loc2_:Number = NaN;
         if(param1 < -3.14159265358979 || param1 > 3.14159265358979) {
            param1 = boundToPI(param1);
         }
         if(param1 < 0) {
            _loc2_ = 1.27323954 * param1 + 0.405284735 * param1 * param1;
            if(_loc2_ < 0) {
               _loc2_ = 0.225 * (_loc2_ * -_loc2_ - _loc2_) + _loc2_;
            } else {
               _loc2_ = 0.225 * (_loc2_ * _loc2_ - _loc2_) + _loc2_;
            }
         } else {
            _loc2_ = 1.27323954 * param1 - 0.405284735 * param1 * param1;
            if(_loc2_ < 0) {
               _loc2_ = 0.225 * (_loc2_ * -_loc2_ - _loc2_) + _loc2_;
            } else {
               _loc2_ = 0.225 * (_loc2_ * _loc2_ - _loc2_) + _loc2_;
            }
         }
         return _loc2_;
      }
      
      public static function cos(param1:Number) : Number {
         return sin(param1 + 1.5707963267949);
      }
      
      public static function atan2(param1:Number, param2:Number) : Number {
         var _loc3_:Number = NaN;
         if(param2 == 0) {
            if(param1 < 0) {
               return -1.5707963267949;
            }
            if(param1 > 0) {
               return 1.5707963267949;
            }
            return undefined;
         }
         if(param1 == 0) {
            if(param2 < 0) {
               return 3.14159265358979;
            }
            return 0;
         }
         if((param2 > 0?param2:Number(-param2)) > (param1 > 0?param1:Number(-param1))) {
            _loc3_ = (param2 < 0?-3.14159265358979:0) + atan2Helper(param1,param2);
         } else {
            _loc3_ = (param1 > 0?1.5707963267949:-1.5707963267949) - atan2Helper(param2,param1);
         }
         if(_loc3_ < -3.14159265358979 || _loc3_ > 3.14159265358979) {
            _loc3_ = boundToPI(_loc3_);
         }
         return _loc3_;
      }
      
      public static function atan2Helper(param1:Number, param2:Number) : Number {
         var _loc4_:Number = param1 / param2;
         var _loc3_:* = _loc4_;
         var _loc5_:* = _loc4_;
         var _loc7_:* = 1;
         var _loc6_:int = 1;
         do {
            _loc7_ = _loc7_ + 2;
            _loc6_ = _loc6_ > 0?-1:1;
            _loc5_ = _loc5_ * _loc4_ * _loc4_;
            _loc3_ = _loc3_ + _loc6_ * _loc5_ / _loc7_;
         }
         while((_loc5_ > 0.01 || _loc5_ < -0.01) && _loc7_ <= 11);
         
         return _loc3_;
      }


      public static function boundToPI(_arg1:Number):Number {
         var _local2:int;
         if (_arg1 < -(Math.PI)) {
            _local2 = ((int((_arg1 / -(Math.PI))) + 1) / 2);
            _arg1 = (_arg1 + ((_local2 * 2) * Math.PI));
         }
         else {
            if (_arg1 > Math.PI) {
               _local2 = ((int((_arg1 / Math.PI)) + 1) / 2);
               _arg1 = (_arg1 - ((_local2 * 2) * Math.PI));
            }
         }
         return (_arg1);
      }
      
      public static function boundTo180(param1:Number) : Number {
         var _loc2_:int = 0;
         if(param1 < -180) {
            _loc2_ = (int(param1 / -180) + 1) * 0.5;
            param1 = param1 + _loc2_ * 360;
         } else if(param1 > 180) {
            _loc2_ = (int(param1 / 180) + 1) * 0.5;
            param1 = param1 - _loc2_ * 360;
         }
         return param1;
      }
      
      public static function unitTest() : Boolean {
         trace("STARTING UNITTEST: Trig");
         var _loc1_:Boolean = testFunc1(Math.sin,sin) && testFunc1(Math.cos,cos) && testFunc2(Math.atan2,atan2);
         if(!_loc1_) {
            trace("Trig Unit Test FAILED!");
         }
         trace("FINISHED UNITTEST: Trig");
         return _loc1_;
      }
      
      public static function testFunc1(param1:Function, param2:Function) : Boolean {
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:Random = new Random();
         while(_loc5_ < 1000) {
            _loc3_ = _loc4_.nextInt() % 2000 - 1000 + _loc4_.nextDouble();
            _loc6_ = Math.abs(param1(_loc3_) - param2(_loc3_));
            if(_loc6_ > 0.1) {
               return false;
            }
            _loc5_++;
         }
         return true;
      }
      
      public static function testFunc2(param1:Function, param2:Function) : Boolean {
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:Random = new Random();
         while(_loc3_ < 1000) {
            _loc5_ = _loc4_.nextInt() % 2000 - 1000 + _loc4_.nextDouble();
            _loc7_ = _loc4_.nextInt() % 2000 - 1000 + _loc4_.nextDouble();
            _loc6_ = Math.abs(param1(_loc5_,_loc7_) - param2(_loc5_,_loc7_));
            if(_loc6_ > 0.1) {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
   }
}

class StaticEnforcer_2846 {
    
   
   function StaticEnforcer_2846() {
      super();
   }
}
