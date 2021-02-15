package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.thrown.BitmapParticle;
   import flash.display.BitmapData;
   import kabam.lib.math.easing.Quad;
   
   public class AnimatedEffect extends BitmapParticle {
       
      
      public var go:GameObject;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public var color3_:uint;
      
      private var images:Vector.<BitmapData>;
      
      private var percentDone:Number;
      
      private var startZ:Number;
      
      private var lifeTimeMS:int;
      
      private var delay:int;
      
      private var currentTime:int;
      
      public function AnimatedEffect(param1:Vector.<BitmapData>, param2:int, param3:int, param4:int) {
         super(param1[0],param2);
         this.images = param1;
         this.delay = param3;
         this.currentTime = 0;
         this.percentDone = 0;
         z_ = param2;
         this.lifeTimeMS = param4;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc3_:int = 0;
         this.delay = this.delay - param2;
         if(this.delay <= 0) {
            this.percentDone = this.currentTime / this.lifeTimeMS;
            _loc3_ = Math.min(Math.max(0,Math.floor(this.images.length * Quad.easeOut(this.percentDone))),this.images.length - 1);
            _bitmapData = this.images[_loc3_];
            this.currentTime = this.currentTime + param2;
            return this.percentDone < 1;
         }
         return this.percentDone < 1;
      }
   }
}
