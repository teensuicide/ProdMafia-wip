package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.BitmapData;
   
   public class ParticleGenerator extends ParticleEffect {
       
      
      private var particlePool:Vector.<BaseParticle>;
      
      private var liveParticles:Vector.<BaseParticle>;
      
      private var targetGO:GameObject;
      
      private var generatedParticles:Number = 0;
      
      private var totalTime:Number = 0;
      
      private var effectProps:EffectProperties;
      
      private var bitmapData:BitmapData;
      
      private var friction:Number;
      
      public function ParticleGenerator(param1:EffectProperties, param2:GameObject) {
         super();
         this.targetGO = param2;
         this.particlePool = new Vector.<BaseParticle>();
         this.liveParticles = new Vector.<BaseParticle>();
         this.effectProps = param1;
         if(this.effectProps.bitmapFile) {
            this.bitmapData = AssetLibrary.getImageFromSet(this.effectProps.bitmapFile,this.effectProps.bitmapIndex);
            this.bitmapData = TextureRedrawer.redraw(this.bitmapData,this.effectProps.size,true,0);
         } else {
            this.bitmapData = TextureRedrawer.redrawSolidSquare(this.effectProps.color,this.effectProps.size,this.effectProps.size);
         }
      }
      
      public static function attachParticleGenerator(param1:EffectProperties, param2:GameObject) : ParticleGenerator {
         return new ParticleGenerator(param1,param2);
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc9_:Number = NaN;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:Number = param1 / 1000;
         _loc9_ = param2 / 1000;
         if(this.targetGO.map_ == null) {
            return false;
         }
         x_ = this.targetGO.x_;
         y_ = this.targetGO.y_;
         z_ = this.targetGO.z_ + this.effectProps.zOffset;
         this.totalTime = this.totalTime + _loc9_;
         var _loc10_:Number = this.effectProps.rate * this.totalTime;
         var _loc7_:int = _loc10_ - this.generatedParticles;
         while(_loc8_ < _loc7_) {
            if(this.particlePool.length) {
               _loc6_ = this.particlePool.pop();
            } else {
               _loc6_ = new BaseParticle(this.bitmapData);
            }
            _loc6_.initialize(this.effectProps.life + this.effectProps.lifeVariance * (2 * Math.random() - 1),this.effectProps.speed + this.effectProps.speedVariance * (2 * Math.random() - 1),this.effectProps.speed + this.effectProps.speedVariance * (2 * Math.random() - 1),this.effectProps.rise + this.effectProps.riseVariance * (2 * Math.random() - 1),z_);
            map_.addObj(_loc6_,x_ + this.effectProps.rangeX * (2 * Math.random() - 1),y_ + this.effectProps.rangeY * (2 * Math.random() - 1));
            this.liveParticles.push(_loc6_);
            _loc8_++;
         }
         this.generatedParticles = this.generatedParticles + _loc7_;
         while(_loc5_ < this.liveParticles.length) {
            _loc3_ = this.liveParticles[_loc5_];
            _loc3_.timeLeft = _loc3_.timeLeft - _loc9_;
            if(_loc3_.timeLeft <= 0) {
               this.liveParticles.splice(_loc5_,1);
               map_.removeObj(_loc3_.objectId_);
               _loc5_--;
               this.particlePool.push(_loc3_);
            } else {
               _loc3_.spdZ = _loc3_.spdZ + this.effectProps.riseAcc * _loc9_;
               _loc3_.x_ = _loc3_.x_ + _loc3_.spdX * _loc9_;
               _loc3_.y_ = _loc3_.y_ + _loc3_.spdY * _loc9_;
               _loc3_.z_ = _loc3_.z_ + _loc3_.spdZ * _loc9_;
            }
            _loc5_++;
         }
         return true;
      }
      
      override public function removeFromMap() : void {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = this.liveParticles;
         for each(_loc1_ in this.liveParticles) {
            map_.removeObj(_loc1_.objectId_);
         }
         this.liveParticles = null;
         this.particlePool = null;
         super.removeFromMap();
      }
   }
}
