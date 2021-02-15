package io.decagames.rotmg.shop.mysteryBox.rollModal.elements {
   import com.company.assembleegameclient.util.TimeUtil;
   import flash.display.Sprite;
   import flash.events.Event;
   import io.decagames.rotmg.utils.colors.RGB;
   import io.decagames.rotmg.utils.colors.RandomColorGenerator;
   
   public class Spinner extends Sprite {
       
      
      private var secondsElapsed:Number;
      
      private var previousSeconds:Number;
      
      private var startColor:uint;
      
      private var endColor:uint;
      
      private var direction:Boolean;
      
      private var previousProgress:Number = 0;
      
      private var multicolor:Boolean;
      
      private var rStart:Number = -1;
      
      private var gStart:Number = -1;
      
      private var bStart:Number = -1;
      
      private var rFinal:Number = -1;
      
      private var gFinal:Number = -1;
      
      private var bFinal:Number = -1;
      
      private var _degreesPerSecond:int;
      
      public function Spinner(param1:int, param2:Boolean = false, param3:int = -1, param4:int = -1) {
         super();
         this._degreesPerSecond = param1;
         this.multicolor = param2;
         this.secondsElapsed = 0;
         this.setupStartAndFinalColors(param3,param4);
         this.applyColor(0);
         addEventListener("enterFrame",this.onEnterFrame);
         addEventListener("removedFromStage",this.onRemoved);
      }
      
      public function get degreesPerSecond() : int {
         return this._degreesPerSecond;
      }
      
      public function pause() : void {
         removeEventListener("enterFrame",this.onEnterFrame);
         this.previousSeconds = 0;
      }
      
      public function resume() : void {
         addEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function applyColor(param1:Number) : void {
         if(!this.multicolor) {
            return;
         }
         if(param1 < this.previousProgress) {
            this.direction = !this.direction;
         }
         this.previousProgress = param1;
         if(this.direction) {
            param1 = 1 - param1;
         }
      }
      
      private function getColorByProgress(param1:Number) : uint {
         var _loc2_:Number = this.rStart + (this.rFinal - this.rStart) * param1;
         var _loc3_:Number = this.gStart + (this.gFinal - this.gStart) * param1;
         var _loc4_:Number = this.bStart + (this.bFinal - this.bStart) * param1;
         return RGB.fromRGB(_loc2_,_loc3_,_loc4_);
      }
      
      private function setupStartAndFinalColors(param1:int = -1, param2:int = -1) : void {
         var _loc5_:RandomColorGenerator = new RandomColorGenerator();
         var _loc3_:Array = _loc5_.randomColor();
         var _loc4_:Array = _loc5_.randomColor();
         if(param1 == -1) {
            this.rStart = _loc3_[0];
            this.gStart = _loc3_[1];
            this.bStart = _loc3_[2];
         } else {
            this.rStart = param1 >> 16 & 255;
            this.gStart = param1 >> 8 & 255;
            this.bStart = param1 & 255;
         }
         if(param2 == -1) {
            this.rFinal = _loc4_[0];
            this.gFinal = _loc4_[1];
            this.bFinal = _loc4_[2];
         } else {
            this.rStart = param2 >> 16 & 255;
            this.gStart = param2 >> 8 & 255;
            this.bStart = param2 & 255;
         }
      }
      
      private function updateTimeElapsed() : void {
         var _loc1_:Number = TimeUtil.getTrueTime() / 1000;
         if(this.previousSeconds) {
            this.secondsElapsed = this.secondsElapsed + (_loc1_ - this.previousSeconds);
         }
         this.previousSeconds = _loc1_;
      }
      
      private function onRemoved(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemoved);
         removeEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void {
         this.updateTimeElapsed();
         var _loc2_:Number = this._degreesPerSecond * this.secondsElapsed % 6 * 60;
         rotation = _loc2_;
         this.applyColor(_loc2_ / 6 * 60);
      }
   }
}
