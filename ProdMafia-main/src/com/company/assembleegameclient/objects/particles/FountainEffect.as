package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.FreeList;
   
   public class FountainEffect extends ParticleEffect {
       
      
      public var go_:GameObject;
      
      public var color_:uint;
      
      public var lastUpdate_:int = -1;
      
      public function FountainEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.go_ = param1;
         this.color_ = param2.color;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc4_:int = 0;
         var _loc5_:FountainParticle = null;
         if(this.go_.map_ == null) {
            return false;
         }
         if(this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0,param1 - 400);
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         var _loc3_:int = this.lastUpdate_ / 50;
         while(_loc3_ < param1 / 50) {
            _loc4_ = _loc3_ * 50;
            _loc5_ = FreeList.newObject(FountainParticle) as FountainParticle;
            _loc5_.setColor(this.color_);
            _loc5_.restart(_loc4_,param1);
            map_.addObj(_loc5_,x_,y_);
            _loc3_++;
         }
         this.lastUpdate_ = param1;
         return true;
      }
   }
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.util.FreeList;
import flash.geom.Vector3D;

class FountainParticle extends Particle {
   
   private static const G:Number = -4.9;
   
   private static const VI:Number = 6.5;
   
   private static const ZI:Number = 0.75;
    
   
   public var startTime_:int;
   
   protected var moveVec_:Vector3D;
   
   function FountainParticle(param1:uint = 4285909) {
      this.moveVec_ = new Vector3D();
      super(param1,0.75,100);
   }
   
   override public function removeFromMap() : void {
      super.removeFromMap();
      FreeList.deleteObject(this);
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      var _loc3_:Number = (param1 - this.startTime_) / 1000;
      moveTo(x_ + this.moveVec_.x * param2 * 0.0008,y_ + this.moveVec_.y * param2 * 0.0008);
      z_ = 0.75 + 6.5 * _loc3_ + -4.9 * (_loc3_ * _loc3_);
      return z_ > 0;
   }
   
   public function restart(param1:int, param2:int) : void {
      var _loc3_:Number = 6.28318530717959 * Math.random();
      this.moveVec_.x = Math.cos(_loc3_);
      this.moveVec_.y = Math.sin(_loc3_);
      this.startTime_ = param1;
      var _loc4_:int = param2 - this.startTime_;
      x_ = x_ + this.moveVec_.x * _loc4_ * 0.0008;
      y_ = y_ + this.moveVec_.y * _loc4_ * 0.0008;
      var _loc5_:Number = (param2 - this.startTime_) / 1000;
      z_ = 0.75 + 6.5 * _loc5_ + -4.9 * (_loc5_ * _loc5_);
   }
}
