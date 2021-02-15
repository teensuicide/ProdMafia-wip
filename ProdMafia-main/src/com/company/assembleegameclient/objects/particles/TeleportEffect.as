package com.company.assembleegameclient.objects.particles {
   public class TeleportEffect extends ParticleEffect {
       
      
      public function TeleportEffect() {
         super();
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:TeleportParticle = null;
         var _loc5_:int = 0;
         while(_loc5_ < 20) {
            _loc6_ = 6.28318530717959 * Math.random();
            _loc7_ = 0.7 * Math.random();
            _loc8_ = 500 + 1000 * Math.random();
            _loc4_ = new TeleportParticle(255,50,0.1,_loc8_);
            map_.addObj(_loc4_,x_ + _loc7_ * Math.cos(_loc6_),y_ + _loc7_ * Math.sin(_loc6_));
            _loc5_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc4_:TeleportParticle = null;
         var _loc5_:int = 0;
         while(_loc5_ < 10) {
            _loc6_ = 6.28318530717959 * Math.random();
            _loc7_ = 0.7 * Math.random();
            _loc8_ = 5 + 500 * Math.random();
            _loc4_ = new TeleportParticle(255,50,0.1,_loc8_);
            map_.addObj(_loc4_,x_ + _loc7_ * Math.cos(_loc6_),y_ + _loc7_ * Math.sin(_loc6_));
            _loc5_++;
         }
         return false;
      }
   }
}

import com.company.assembleegameclient.objects.particles.Particle;
import flash.geom.Vector3D;

class TeleportParticle extends Particle {
    
   
   public var timeLeft_:int;
   
   protected var moveVec_:Vector3D;
   
   function TeleportParticle(param1:uint, param2:int, param3:Number, param4:int) {
      this.moveVec_ = new Vector3D();
      super(param1,0,param2);
      this.moveVec_.z = param3;
      this.timeLeft_ = param4;
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      this.timeLeft_ = this.timeLeft_ - param2;
      if(this.timeLeft_ <= 0) {
         return false;
      }
      z_ = z_ + this.moveVec_.z * param2 * 0.008;
      return true;
   }
}
