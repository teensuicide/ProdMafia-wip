package com.company.assembleegameclient.objects {
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import kabam.rotmg.stage3D.GraphicsFillExtra;
   
   public class StatusFlashDescription {
       
      
      public var startTime_:int;
      
      public var color_:uint;
      
      public var periodMS_:int;
      
      public var repeats_:int;
      
      public var duration_:int;
      
      public var percentDone:Number;
      
      public var curTime:Number;
      
      public var targetR:int;
      
      public var targetG:int;
      
      public var targetB:int;
      
      public function StatusFlashDescription(param1:int, param2:uint, param3:int) {
         super();
         this.startTime_ = param1;
         this.color_ = param2;
         this.duration_ = param3 * 1000;
         this.targetR = param2 >> 16 & 255;
         this.targetG = param2 >> 8 & 255;
         this.targetB = param2 & 255;
         this.curTime = 0;
      }
      
      public function apply(param1:BitmapData, param2:int) : BitmapData {
         var _loc3_:BitmapData = param1.clone();
         var _loc4_:int = (param2 - this.startTime_) % this.duration_;
         var _loc5_:Number = Math.abs(Math.sin(_loc4_ / this.duration_ * 3.14159265358979 * (this.percentDone * 10)));
         var _loc6_:Number = _loc5_ * 0.5;
         var _loc7_:ColorTransform = new ColorTransform(1 - _loc6_,1 - _loc6_,1 - _loc6_,1,_loc6_ * this.targetR,_loc6_ * this.targetG,_loc6_ * this.targetB,0);
         _loc3_.colorTransform(_loc3_.rect,_loc7_);
         return _loc3_;
      }
      
      public function applyGPUTextureColorTransform(param1:BitmapData, param2:int) : void {
         var _loc3_:int = (param2 - this.startTime_) % this.duration_;
         var _loc6_:Number = Math.abs(Math.sin(_loc3_ / this.duration_ * 3.14159265358979 * (this.percentDone * 10)));
         var _loc4_:Number = _loc6_ * 0.5;
         var _loc5_:ColorTransform = new ColorTransform(1 - _loc4_,1 - _loc4_,1 - _loc4_,1,_loc4_ * this.targetR,_loc4_ * this.targetG,_loc4_ * this.targetB,0);
         GraphicsFillExtra.setColorTransform(param1,_loc5_);
      }
      
      public function doneAt(param1:int) : Boolean {
         this.percentDone = this.curTime / this.duration_;
         this.curTime = param1 - this.startTime_;
         return this.percentDone > 1;
      }
   }
}
