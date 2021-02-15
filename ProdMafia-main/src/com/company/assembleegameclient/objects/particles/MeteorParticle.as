package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.thrown.BitmapParticle;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.BitmapData;
   import kabam.lib.math.easing.Expo;
   import kabam.lib.math.easing.Quad;
   
   public class MeteorParticle extends BitmapParticle {
       
      
      private var percentDone:Number;
      
      private var startZ:Number;
      
      private var lifeTimeMS:int;
      
      private var currentTime:int;
      
      private var go:GameObject;
      
      private var images:Vector.<BitmapData>;
      
      private var cameraAngle:Number;
      
      public function MeteorParticle(param1:GameObject, param2:Vector.<BitmapData>, param3:Number, param4:int) {
         this.cameraAngle = Parameters.data.cameraAngle;
         this.go = param1;
         this.images = param2;
         this.percentDone = 0;
         this.currentTime = 0;
         this.lifeTimeMS = param4;
         super(param2[0],0);
         this.startZ = param3;
         z_ = this.startZ;
         _rotation = 0;
         this.percentDone = 0;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.percentDone = this.currentTime / this.lifeTimeMS;
         var _loc3_:int = 0;
         _loc3_ = Math.min(Math.max(0,Math.floor(this.images.length * Quad.easeOut(this.percentDone))),this.images.length - 1);
         _bitmapData = this.images[_loc3_];
         y_ = this.go.y_;
         x_ = this.go.x_;
         z_ = 0.5 + this.startZ * (1 - Expo.easeOut(this.percentDone));
         this.currentTime = this.currentTime + param2;
         return this.percentDone < 1;
      }
   }
}
