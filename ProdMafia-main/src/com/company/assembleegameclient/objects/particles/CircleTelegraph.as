package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.CachingColorTransformer;
   import com.company.util.ImageSet;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CircleTelegraph extends ParticleEffect {
      
      public static var images:Vector.<BitmapData>;
      
      public static var circle:Vector.<BitmapData>;
       
      
      public var go_:GameObject;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public var color3_:uint;
      
      public var duration_:int;
      
      public var rad_:Number;
      
      private var timer:Timer;
      
      private var isDestroyed:Boolean = false;
      
      public function CircleTelegraph(param1:GameObject, param2:int, param3:Number) {
         super();
         this.go_ = param1;
         this.duration_ = param2;
         this.rad_ = param3;
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
         this.timer = new Timer(1,1);
         this.timer.addEventListener("timer",this.onTimer);
         this.timer.addEventListener("timerComplete",this.onTimerComplete);
         this.timer.start();
         this.parseBitmapDataFromImageSet();
      }
      
      private function parseBitmapDataFromImageSet() : void {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         images = new Vector.<BitmapData>();
         circle = new Vector.<BitmapData>();
         var _loc2_:ImageSet = AssetLibrary.getImageSet("lofiParticlesTelegraph");
         var _loc1_:uint = this.getAmountFrames(this.duration_);
         var _loc6_:BitmapData = TextureRedrawer.redraw(_loc2_.images[0],Math.floor(this.rad_ * 100),true,0,true,5,0,0,true);
         circle.push(CachingColorTransformer.alphaBitmapData(_loc6_,0.9));
         var _loc4_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _loc1_) {
            _loc5_ = this.rad_ * 100 * (_loc3_ / _loc1_);
            _loc4_ = TextureRedrawer.redraw(_loc2_.images[1],_loc5_,true,0,true,5,0,0,true);
            images.push(CachingColorTransformer.alphaBitmapData(_loc4_,0.35));
            _loc3_++;
         }
      }
      
      private function getAmountFrames(param1:int) : int {
         return Math.floor(param1 / 24);
      }
      
      private function onTimer(param1:TimerEvent) : void {
         if(map_) {
            map_.addObj(new CircleTeleGraphParticle(this.go_,circle,this.duration_,this.rad_),x_,y_);
            map_.addObj(new CircleTeleGraphParticle(this.go_,images,this.duration_,this.rad_),x_,y_);
         }
      }
      
      private function onTimerComplete(param1:TimerEvent) : void {
         this.destroy();
      }
   }
}
