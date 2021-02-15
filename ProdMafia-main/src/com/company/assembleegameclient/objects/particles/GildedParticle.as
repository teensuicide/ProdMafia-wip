package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.util.MoreColorUtil;
   import kabam.lib.math.easing.Quad;
   
   public class GildedParticle extends Particle {
       
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public var color3_:uint;
      
      private var mSize:Number;
      
      private var fSize:Number = 0;
      
      private var go:GameObject;
      
      private var currentLife:int;
      
      private var lifetimeMS:int = 2500;
      
      private var radius:Number;
      
      private var armOffset:Number = 0;
      
      public function GildedParticle(param1:GameObject, param2:Number, param3:Number, param4:Number, param5:Number, param6:int, param7:uint = 2556008, param8:uint = 2556008, param9:uint = 2556008) {
         this.mSize = 3.5 + 2 * Math.random();
         super(param7,1,0);
         this.lifetimeMS = param6;
         this.radius = param5;
         this.color1_ = param7;
         this.color2_ = param8;
         this.color3_ = param9;
         z_ = 0;
         this.fSize = 0;
         size_ = this.fSize;
         this.currentLife = 0;
         this.armOffset = param4;
         this.go = param1;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc3_:Number = this.currentLife / this.lifetimeMS;
         if(this.mSize > size_) {
            this.fSize = this.fSize + param2 * 0.01;
         }
         size_ = this.fSize;
         var _loc5_:Number = Quad.easeOut(_loc3_);
         var _loc6_:Number = 6.28318530717958 * (_loc5_ + this.armOffset);
         var _loc7_:Number = this.radius * (1 - _loc5_);
         var _loc8_:Number = _loc7_ * Math.cos(_loc6_);
         var _loc4_:Number = _loc7_ * Math.sin(_loc6_);
         moveTo(this.go.x_ + _loc8_,this.go.y_ + _loc4_);
         if(_loc3_ < 0.33) {
            setColor(MoreColorUtil.lerpColor(this.color3_,this.color2_,this.normalizedRange(_loc3_,0,0.33)));
         } else if(_loc3_ > 0.5) {
            setColor(MoreColorUtil.lerpColor(this.color2_,this.color1_,this.normalizedRange(_loc3_,0.5,1)));
         }
         this.currentLife = this.currentLife + param2;
         return _loc3_ < 1;
      }
      
      public function normalizedRange(param1:Number, param2:Number, param3:Number) : Number {
         var _loc4_:* = Number((param1 - param2) / (param3 - param2));
         if(_loc4_ < 0) {
            _loc4_ = 0;
         } else if(_loc4_ > 1) {
            _loc4_ = 1;
         }
         return _loc4_;
      }
   }
}
