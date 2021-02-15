package com.company.assembleegameclient.objects.particles {
   public class GasParticle extends SparkParticle {
       
      
      private var noise:Number;
      
      public function GasParticle(param1:int, param2:int, param3:int, param4:Number, param5:Number, param6:Number, param7:Number) {
         this.noise = param4 * 0.001;
         super(param1,param2,param3,param5,param6,param7);
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc4_:Number = NaN;
         timeLeft_ = timeLeft_ - param2;
         if(timeLeft_ <= 0) {
            return false;
         }
         if(square.obj_ && square.obj_.props_.static_) {
            return false;
         }
         var _loc3_:Number = Math.random() * this.noise;
         _loc4_ = Math.random() * this.noise;
         x_ = x_ + dx_ * _loc3_ * param2;
         y_ = y_ + dy_ * _loc4_ * param2;
         setSize(timeLeft_ / lifetime_ * initialSize_);
         return true;
      }
   }
}
