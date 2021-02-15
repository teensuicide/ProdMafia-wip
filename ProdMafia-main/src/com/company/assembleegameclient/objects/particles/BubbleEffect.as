package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.FreeList;
   
   public class BubbleEffect extends ParticleEffect {
      
      private static const PERIOD_MAX:Number = 400;
       
      
      public var go_:GameObject;
      
      public var lastUpdate_:int = -1;
      
      public var rate_:Number;
      
      private var poolID:String;
      
      private var fxProps:EffectProperties;
      
      public function BubbleEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.go_ = param1;
         this.fxProps = param2;
         this.rate_ = (1 - param2.rate) * 400 + 1;
         this.poolID = "BubbleEffect_" + Math.random();
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc3_:int = 0;
         var _loc13_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:int = 0;
         var _loc8_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:BubbleParticle = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         if(this.go_.map_ == null) {
            return false;
         }
         if(!this.lastUpdate_) {
            this.lastUpdate_ = param1;
            return true;
         }
         _loc3_ = this.lastUpdate_ / this.rate_;
         var _loc4_:int = param1 / this.rate_;
         _loc13_ = this.go_.x_;
         _loc12_ = this.go_.y_;
         if(this.lastUpdate_ < 0) {
            this.lastUpdate_ = Math.max(0,param1 - 400);
         }
         x_ = _loc13_;
         y_ = _loc12_;
         var _loc11_:* = _loc3_;
         while(_loc11_ < _loc4_) {
            _loc5_ = _loc11_ * this.rate_;
            _loc7_ = BubbleParticle.create(this.poolID,this.fxProps.color,this.fxProps.speed,this.fxProps.life,this.fxProps.lifeVariance,this.fxProps.speedVariance,this.fxProps.spread);
            _loc7_.restart(_loc5_,param1);
            _loc8_ = Math.random() * 3.14159265358979;
            _loc6_ = Math.random() * 0.4;
            _loc9_ = _loc13_ + _loc6_ * Math.cos(_loc8_);
            _loc10_ = _loc12_ + _loc6_ * Math.sin(_loc8_);
            map_.addObj(_loc7_,_loc9_,_loc10_);
            _loc11_++;
         }
         this.lastUpdate_ = param1;
         return true;
      }
      
      override public function removeFromMap() : void {
         super.removeFromMap();
         FreeList.dump(this.poolID);
      }
   }
}
