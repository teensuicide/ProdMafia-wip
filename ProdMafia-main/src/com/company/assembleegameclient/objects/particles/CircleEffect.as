package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.ColorUtil;
   
   public class CircleEffect extends ParticleEffect {
       
      
      public var go_:GameObject;
      
      public var color_:uint;
      
      public var rise_:Number;
      
      public var rad_:Number;
      
      public var maxRad_:Number;
      
      public var lastUpdate_:int = -1;
      
      public var bInitialized_:Boolean = false;
      
      public var amount_:int;
      
      public var maxLife_:int;
      
      public var speed_:Number;
      
      public var parts_:Vector.<CircleParticle>;
      
      public function CircleEffect(param1:GameObject, param2:EffectProperties) {
         this.parts_ = new Vector.<CircleParticle>();
         super();
         this.go_ = param1;
         this.color_ = param2.color;
         this.rise_ = param2.rise;
         this.rad_ = param2.minRadius;
         this.maxRad_ = param2.maxRadius;
         this.amount_ = param2.amount;
         this.maxLife_ = param2.life * 1000;
         this.speed_ = param2.speed;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc7_:CircleParticle = null;
         var _loc8_:* = NaN;
         var _loc9_:Number = NaN;
         if(this.go_.map_ == null) {
            return false;
         }
         if(this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0,param1 - 400);
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         if(!this.bInitialized_) {
            _loc6_ = 0;
            while(_loc6_ < this.amount_) {
               _loc7_ = new CircleParticle(ColorUtil.randomSmart(this.color_));
               _loc7_.cX_ = x_;
               _loc7_.cY_ = y_;
               _loc8_ = 6.28318530717958;
               _loc9_ = _loc8_ / this.amount_;
               _loc7_.startTime_ = param1;
               _loc7_.angle_ = _loc9_ * _loc6_;
               _loc7_.rad_ = this.rad_;
               _loc7_.speed_ = this.speed_;
               this.parts_.push(_loc7_);
               map_.addObj(_loc7_,x_,y_);
               _loc7_.move();
               _loc6_++;
            }
            this.bInitialized_ = true;
         }
         var _loc4_:* = this.parts_;
         var _loc11_:int = 0;
         var _loc10_:* = this.parts_;
         for each(_loc3_ in this.parts_) {
            _loc3_.rad_ = this.rad_;
         }
         this.rad_ = Math.min(this.rad_ + this.rise_ * (param2 / 1000),this.maxRad_);
         this.maxLife_ = this.maxLife_ - param2;
         if(this.maxLife_ <= 0) {
            this.endEffect();
            return false;
         }
         this.lastUpdate_ = param1;
         return true;
      }
      
      override public function removeFromMap() : void {
         this.endEffect();
         super.removeFromMap();
      }
      
      private function endEffect() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.parts_;
         var _loc5_:int = 0;
         var _loc4_:* = this.parts_;
         for each(_loc3_ in this.parts_) {
            _loc3_.alive_ = false;
         }
      }
   }
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;

class CircleParticle extends Particle {
    
   
   public var startTime_:int;
   
   public var speed_:Number;
   
   public var cX_:Number;
   
   public var cY_:Number;
   
   public var angle_:Number;
   
   public var rad_:Number;
   
   public var alive_:Boolean = true;
   
   function CircleParticle(param1:uint = 0) {
      var _loc2_:Number = Math.random();
      super(param1,0.2 + Math.random() * 0.2,100 + _loc2_ * 20);
   }
   
   override public function removeFromMap() : void {
      super.removeFromMap();
      FreeList.deleteObject(this);
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      this.move();
      return this.alive_;
   }
   
   public function move() : void {
      x_ = this.cX_ + this.rad_ * Math.cos(this.angle_);
      y_ = this.cY_ + this.rad_ * Math.sin(this.angle_);
      this.angle_ = this.angle_ + this.speed_;
   }
}
