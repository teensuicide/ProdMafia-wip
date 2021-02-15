package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import kabam.lib.math.easing.Back;
   
   public class InspireEffect extends ParticleEffect {
      
      private static const LIFETIME:int = 1000;
       
      
      public var go_:GameObject;
      
      public var parts1_:Vector.<InspireParticle>;
      
      public var parts2_:Vector.<InspireParticle>;
      
      public var startTime_:int = -1;
      
      private var percentageDone:Number = 0;
      
      public function InspireEffect(param1:GameObject, param2:uint, param3:int) {
         var _loc4_:InspireParticle = null;
         this.parts1_ = new Vector.<InspireParticle>();
         this.parts2_ = new Vector.<InspireParticle>();
         super();
         this.go_ = param1;
         var _loc5_:int = 0;
         while(_loc5_ < param3) {
            _loc4_ = new InspireParticle(param2,100);
            this.parts1_.push(_loc4_);
            _loc4_ = new InspireParticle(param2,100);
            this.parts2_.push(_loc4_);
            _loc5_++;
         }
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         if(this.go_.map_ == null) {
            this.endEffect();
            return false;
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         if(this.startTime_ < 0) {
            this.startTime_ = param1;
         }
         var _loc3_:Number = (param1 - this.startTime_) / 1000;
         if(_loc3_ >= 1) {
            this.endEffect();
            return false;
         }
         this.updateSwirl(this.parts1_,1,0,_loc3_);
         this.updateSwirl(this.parts2_,1,3.14159265358979,_loc3_);
         return true;
      }
      
      public function updateSwirl(param1:Vector.<InspireParticle>, param2:Number, param3:Number, param4:Number) : void {
         var _loc8_:int = 0;
         var _loc9_:InspireParticle = null;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc8_ = 0;
         while(_loc8_ < param1.length) {
            _loc9_ = param1[_loc8_];
            _loc9_.z_ = Back.easeOut(param4) * 2 - 1 + _loc8_ / param1.length;
            if(_loc9_.z_ >= 0) {
               if(_loc9_.z_ > 1) {
                  _loc9_.alive_ = false;
               } else {
                  _loc7_ = param2 * (6.28318530717958 * (_loc8_ / param1.length) + 6.28318530717958 * Back.easeOut(param4) + param3);
                  _loc5_ = this.go_.x_ + 0.5 * Math.cos(_loc7_);
                  _loc6_ = this.go_.y_ + 0.5 * Math.sin(_loc7_);
                  if(_loc9_.map_ == null) {
                     map_.addObj(_loc9_,_loc5_,_loc6_);
                  } else {
                     _loc9_.moveTo(_loc5_,_loc6_);
                  }
               }
            }
            _loc8_++;
         }
      }
      
      private function endEffect() : void {
         var _loc3_:InspireParticle = null;
         var _loc1_:* = this.parts1_;
         var _loc7_:int = 0;
         var _loc6_:* = this.parts1_;
         for each(_loc3_ in this.parts1_) {
            _loc3_.alive_ = false;
         }
         var _loc4_:* = this.parts2_;
         var _loc9_:int = 0;
         var _loc8_:* = this.parts2_;
         for each(_loc3_ in this.parts2_) {
            _loc3_.alive_ = false;
         }
      }
   }
}

import com.company.assembleegameclient.objects.particles.Particle;

class InspireParticle extends Particle {
    
   
   public var alive_:Boolean = true;
   
   function InspireParticle(param1:uint, param2:int) {
      super(param1,0,param2);
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      return this.alive_;
   }
}
