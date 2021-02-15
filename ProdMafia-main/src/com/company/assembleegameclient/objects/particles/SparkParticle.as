package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.parameters.Parameters;
   
   public class SparkParticle extends Particle {
       
      
      public var lifetime_:int;
      
      public var timeLeft_:int;
      
      public var initialSize_:int;
      
      public var dx_:Number;
      
      public var dy_:Number;
      
      public function SparkParticle(param1:int, param2:int, param3:int, param4:Number, param5:Number, param6:Number) {
         super(param2,param4,param1 / (!!Parameters.data.liteParticle?2:1));
         this.initialSize_ = param1;
         var _loc7_:* = param3;
         this.timeLeft_ = _loc7_;
         this.lifetime_ = _loc7_;
         this.dx_ = param5;
         this.dy_ = param6;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.timeLeft_ = this.timeLeft_ - param2;
         if(this.timeLeft_ <= 0) {
            return false;
         }
         x_ = x_ + this.dx_ * param2 * 0.001;
         y_ = y_ + this.dy_ * param2 * 0.001;
         if(!Parameters.data.liteParticle) {
            setSize(this.timeLeft_ / this.lifetime_ * this.initialSize_);
         }
         return true;
      }
   }
}
