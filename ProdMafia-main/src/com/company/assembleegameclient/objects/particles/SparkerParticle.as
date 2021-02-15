package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.util.RandomUtil;
   import flash.geom.Point;
   
   public class SparkerParticle extends Particle {
       
      
      public var lifetime_:int;
      
      public var timeLeft_:int;
      
      public var initialSize_:int;
      
      public var startX_:Number;
      
      public var startY_:Number;
      
      public var endX_:Number;
      
      public var endY_:Number;
      
      public var dx_:Number;
      
      public var dy_:Number;
      
      public var pathX_:Number;
      
      public var pathY_:Number;
      
      public function SparkerParticle(param1:int, param2:int, param3:int, param4:Point, param5:Point) {
         super(param2,0,param1);
         var _loc6_:* = param3;
         this.timeLeft_ = _loc6_;
         this.lifetime_ = _loc6_;
         this.initialSize_ = param1;
         this.startX_ = param4.x;
         this.startY_ = param4.y;
         this.endX_ = param5.x;
         this.endY_ = param5.y;
         this.dx_ = (this.endX_ - this.startX_) / this.timeLeft_;
         this.dy_ = (this.endY_ - this.startY_) / this.timeLeft_;
         x_ = this.startX_;
         this.pathX_ = this.startX_;
         y_ = this.startY_;
         this.pathY_ = this.startY_;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.timeLeft_ = this.timeLeft_ - param2;
         if(this.timeLeft_ <= 0) {
            return false;
         }
         this.pathX_ = this.pathX_ + this.dx_ * param2;
         this.pathY_ = this.pathY_ + this.dy_ * param2;
         moveTo(this.pathX_,this.pathY_);
         map_.addObj(new SparkParticle(100 * (z_ + 1),color_,600,z_,RandomUtil.plusMinus(1),-RandomUtil.plusMinus(1)),this.pathX_,this.pathY_);
         return true;
      }
   }
}
