package com.company.util {
   public class Random {
       
      
      public var seed:uint;
      
      public function Random(param1:uint = 1) {
         super();
         this.seed = param1;
      }
      
      public static function randomSeed() : uint {
         return Math.round(Math.random() * 4294967294 + 1);
      }
      
      public function nextInt() : uint {
         return this.gen();
      }
      
      public function nextDouble() : Number {
         return this.gen() / 2147483647;
      }
      
      public function nextNormal(param1:Number = 0, param2:Number = 1) : Number {
         var _loc5_:Number = this.gen() / 2147483647;
         var _loc4_:Number = this.gen() / 2147483647;
         var _loc3_:Number = Math.sqrt(-2 * Math.log(_loc5_)) * Math.cos(_loc4_ * 6.28318530717959);
         return param1 + _loc3_ * param2;
      }
      
      public function nextIntRange(param1:uint, param2:uint) : uint {
         return param1 == param2?param1:param1 + this.gen() % (param2 - param1);
      }
      
      public function peekIntRange(param1:uint, param2:uint) : uint {
         return param1 == param2?param1:param1 + this.genPeek() % (param2 - param1);
      }
      
      public function nextDoubleRange(param1:Number, param2:Number) : Number {
         return param1 + (param2 - param1) * this.nextDouble();
      }
      
      private function genPeek() : uint {
         var _loc2_:uint = 16807 * (this.seed & 65535);
         var _loc1_:uint = 16807 * (this.seed >> 16);
         _loc2_ = _loc2_ + ((_loc1_ & 32767) << 16);
         _loc2_ = _loc2_ + (_loc1_ >> 15);
         if(_loc2_ > 2147483647) {
            _loc2_ = _loc2_ - 2147483647;
         }
         return _loc2_;
      }
      
      private function gen() : uint {
         var _loc3_:uint = 16807 * (this.seed & 65535);
         var _loc1_:uint = 16807 * (this.seed >> 16);
         _loc3_ = _loc3_ + ((_loc1_ & 32767) << 16);
         _loc3_ = _loc3_ + (_loc1_ >> 15);
         if(_loc3_ > 2147483647) {
            _loc3_ = _loc3_ - 2147483647;
         }
         var _loc2_:* = _loc3_;
         this.seed = _loc2_;
         return _loc2_;
      }
   }
}
