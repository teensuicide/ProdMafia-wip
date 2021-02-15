package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.ImageSet;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MeteorEffect extends ParticleEffect {
      
      public static var images:Vector.<BitmapData>;
       
      
      public var go_:GameObject;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public var color3_:uint;
      
      public var duration_:int;
      
      public var rad_:Number;
      
      public var spriteSheetOffsetIndex:int;
      
      private var timer:Timer;
      
      private var isDestroyed:Boolean = false;
      
      public function MeteorEffect(param1:GameObject, param2:int, param3:int = 0) {
         super();
         this.go_ = param1;
         this.duration_ = param2;
         this.spriteSheetOffsetIndex = param3;
         x_ = this.go_.x_;
         y_ = this.go_.y_;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         if(this.isDestroyed) {
            return false;
         }
         if(!this.timer) {
            this.initialize();
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         return true;
      }
      
      override public function removeFromMap() : void {
         this.destroy();
         super.removeFromMap();
      }
      
      public function destroy() : void {
         if(this.timer) {
            this.timer.removeEventListener("timer",this.onTimer);
            this.timer.removeEventListener("timer",this.onTimerComplete);
            this.timer.stop();
            this.timer = null;
         }
         this.go_ = null;
         this.isDestroyed = true;
      }
      
      private function initialize() : void {
         this.timer = new Timer(0,1);
         this.timer.addEventListener("timer",this.onTimer);
         this.timer.addEventListener("timerComplete",this.onTimerComplete);
         this.timer.start();
         this.parseBitmapDataFromImageSet();
      }
      
      private function parseBitmapDataFromImageSet() : void {
         var _loc2_:* = 0;
         images = new Vector.<BitmapData>();
         var _loc1_:ImageSet = AssetLibrary.getImageSet("lofiParticlesMeteor");
         _loc2_ = uint(0 + this.spriteSheetOffsetIndex);
         while(_loc2_ < 23) {
            images.push(TextureRedrawer.redraw(_loc1_.images[_loc2_],120,true,0,true,5,0,0,true));
            _loc2_++;
         }
      }
      
      private function onTimer(param1:TimerEvent) : void {
         if(map_) {
            map_.addObj(new MeteorParticle(this.go_,images,3,this.duration_),x_,y_);
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void {
         if(!map_) {
         }
      }
   }
}
