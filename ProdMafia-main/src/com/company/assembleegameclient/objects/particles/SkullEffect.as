package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.thrown.BitmapParticle;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import kabam.lib.math.easing.Quart;
   
   public class SkullEffect extends BitmapParticle {
       
      
      public var target_:Point;
      
      private var images:Vector.<BitmapData>;
      
      private var percentDone:Number;
      
      private var lifeTimeMS:int = 1000;
      
      private var currentTime:int;
      
      public function SkullEffect(param1:Point, param2:Vector.<BitmapData>) {
         super(param2[0],0);
         this.target_ = param1;
         this.images = param2;
         this.currentTime = 0;
         this.percentDone = 0;
         z_ = 0.3;
         x_ = this.target_.x;
         y_ = this.target_.y;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.percentDone = this.currentTime / this.lifeTimeMS;
         var _loc3_:int = Math.min(Math.max(0,Math.floor(this.images.length * this.percentDone)),this.images.length - 1);
         _bitmapData = this.images[_loc3_];
         z_ = 1.618 * Quart.easeOut(this.percentDone);
         this.currentTime = this.currentTime + param2;
         return this.percentDone < 1;
      }
   }
}
