package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   
   public class GildedEffect extends ParticleEffect {
       
      
      public var go_:GameObject;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public var color3_:uint;
      
      public var rad_:Number;
      
      public var duration_:int;
      
      public var delayBetweenParticles:Number = 150;
      
      public var particlesOffset:Number = 0;
      
      private var numArm:int = 3;
      
      private var partPerArm:int = 10;
      
      private var healEffectDelay:int;
      
      private var lastUpdate:int;
      
      private var healUpdate:int;
      
      private var runs:int;
      
      public function GildedEffect(param1:GameObject, param2:uint, param3:uint, param4:uint, param5:Number, param6:int) {
         super();
         this.go_ = param1;
         this.color1_ = param2;
         this.color2_ = param3;
         this.color3_ = param4;
         this.rad_ = param5;
         this.duration_ = param6;
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         this.particlesOffset = 0;
         this.healEffectDelay = this.duration_;
         this.lastUpdate = 0;
         this.runs = 0;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         if(param1 - this.lastUpdate > this.delayBetweenParticles) {
            if(this.runs < this.partPerArm) {
               this.addParticles();
               this.lastUpdate = param1;
               this.runs++;
               if(this.runs >= this.numArm) {
                  this.healUpdate = param1;
               }
            }
         }
         if(this.healUpdate != 0) {
            if(param1 - this.healUpdate > this.healEffectDelay) {
               this.go_.map_.addObj(new HealEffect(this.go_,this.color3_,this.color1_),this.go_.x_,this.go_.y_);
               return false;
            }
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         return true;
      }
      
      private function addParticles() : void {
         var _loc3_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:GildedParticle = null;
         if(!map_) {
            return;
         }
         this.particlesOffset = this.particlesOffset - 0.01618;
         this.healEffectDelay = this.healEffectDelay - this.delayBetweenParticles;
         var _loc2_:int = 0;
         while(_loc2_ < this.numArm) {
            _loc3_ = _loc2_ / this.numArm - this.particlesOffset;
            _loc1_ = Math.cos(_loc3_) * this.rad_;
            _loc4_ = Math.sin(_loc3_) * this.rad_;
            _loc5_ = new GildedParticle(this.go_,_loc1_,_loc4_,_loc3_,this.rad_,this.healEffectDelay,this.color1_,this.color2_,this.color3_);
            map_.addObj(_loc5_,x_ + _loc1_,y_ + _loc4_);
            _loc2_++;
         }
      }
   }
}
