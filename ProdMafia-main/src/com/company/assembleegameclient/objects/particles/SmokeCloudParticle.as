package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.thrown.BitmapParticle;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import kabam.lib.math.easing.Expo;
   import kabam.lib.math.easing.Quad;
   
   public class SmokeCloudParticle extends BitmapParticle {
       
      
      private var percentDone:Number;
      
      private var startZ:Number;
      
      private var lifeTimeMS:int;
      
      private var currentTime:int;
      
      private var go:GameObject;
      
      private var images:Vector.<BitmapData>;
      
      private var dx_:Number;
      
      private var dy_:Number;
      
      private var plusX:Number = 0;
      
      private var plusY:Number = 0;
      
      public function SmokeCloudParticle(param1:GameObject, param2:Vector.<BitmapData>, param3:Number, param4:int, param5:Point, param6:Point) {
         this.go = param1;
         this.images = param2;
         this.percentDone = 0;
         this.currentTime = 0;
         this.lifeTimeMS = param4;
         super(param2[0],0);
         this.dx_ = param6.x - param5.x;
         this.dy_ = param6.y - param5.y;
         this.startZ = param3;
         z_ = this.startZ;
         _rotation = 0;
         this.percentDone = 0;
         y_ = param1.y_;
         x_ = param1.x_;
         this.plusX = this.dx_ * this.percentDone;
         this.plusY = this.dy_ * this.percentDone;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.percentDone = this.currentTime / this.lifeTimeMS;
         var _loc3_:int = 0;
         _loc3_ = Math.min(Math.max(0,Math.floor(this.images.length * Quad.easeOut(this.percentDone))),this.images.length - 1);
         _bitmapData = this.images[_loc3_];
         this.plusX = this.dx_ * Expo.easeOut(this.percentDone);
         this.plusY = this.dy_ * Expo.easeOut(this.percentDone);
         z_ = this.startZ * Expo.easeOut(this.percentDone);
         this.currentTime = this.currentTime + param2;
         moveTo(this.go.x_ + this.plusX,this.go.y_ + this.plusY);
         return this.percentDone < 1;
      }
      
      private function normalizedRange(param1:Number, param2:Number, param3:Number) : Number {
         var _loc4_:* = Number((param1 - param2) * (1 / (param3 - param2)));
         if(_loc4_ < 0) {
            _loc4_ = 0;
         } else if(_loc4_ > 1) {
            _loc4_ = 1;
         }
         return _loc4_;
      }
      
      private function GetAnimationIndex(param1:Number, param2:Number, param3:Number, param4:int, param5:int) : int {
         var _loc6_:int = Math.floor((param1 - param2) / (param3 - param2) * (param5 - param4) + param5);
         return _loc6_ <= 15?int(_loc6_):15;
      }
   }
}
