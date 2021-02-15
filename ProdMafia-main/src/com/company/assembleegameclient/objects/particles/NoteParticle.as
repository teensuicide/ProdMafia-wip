package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.thrown.BitmapParticle;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import kabam.lib.math.easing.Expo;
   
   public class NoteParticle extends BitmapParticle {
       
      
      private var numFramesRemaining:int;
      
      private var dx_:Number;
      
      private var dy_:Number;
      
      private var originX:Number;
      
      private var originY:Number;
      
      private var radians:Number;
      
      private var frameUpdateModulator:uint = 0;
      
      private var currentFrame:uint = 0;
      
      private var numFrames:uint;
      
      private var go:GameObject;
      
      private var plusX:Number = 0;
      
      private var plusY:Number = 0;
      
      private var cameraAngle:Number;
      
      private var images:Vector.<BitmapData>;
      
      private var percentageDone:Number = 0;
      
      private var duration:int;
      
      public function NoteParticle(param1:uint, param2:int, param3:uint, param4:Point, param5:Point, param6:Number, param7:GameObject, param8:Vector.<BitmapData>) {
         this.cameraAngle = Parameters.data.cameraAngle;
         this.go = param7;
         this.radians = param6;
         this.images = param8;
         super(param8[0],0);
         this.numFrames = param8.length;
         this.dx_ = param5.x - param4.x;
         this.dy_ = param5.y - param4.y;
         this.originX = param4.x - param7.x_;
         this.originY = param4.y - param7.y_;
         _rotation = -param6 - this.cameraAngle;
         this.duration = param2;
         this.numFramesRemaining = param2;
         var _loc9_:uint = Math.floor(Math.random() * param8.length);
         _bitmapData = param8[_loc9_];
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.numFramesRemaining--;
         if(this.numFramesRemaining <= 0) {
            return false;
         }
         this.percentageDone = 1 - this.numFramesRemaining / this.duration;
         this.plusX = Expo.easeOut(this.percentageDone) * this.dx_;
         this.plusY = Expo.easeOut(this.percentageDone) * this.dy_;
         if(Parameters.data.cameraAngle != this.cameraAngle) {
            this.cameraAngle = Parameters.data.cameraAngle;
            _rotation = -this.radians - this.cameraAngle;
         }
         moveTo(this.go.x_ + this.originX + this.plusX,this.go.y_ + this.originY + this.plusY);
         return true;
      }
   }
}
