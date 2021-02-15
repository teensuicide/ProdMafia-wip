package com.company.assembleegameclient.objects {
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import kabam.rotmg.stage3D.GraphicsFillExtra;
   
   public class FlashDescription {
       
      
      public var startTime_:int;
      
      public var color_:uint;
      
      public var periodMS_:int;
      
      public var repeats_:int;
      
      public var targetR:int;
      
      public var targetG:int;
      
      public var targetB:int;
      
      public function FlashDescription(param1:int, param2:uint, param3:Number, param4:int) {
         super();
         this.startTime_ = param1;
         this.color_ = param2;
         this.periodMS_ = param3 * 1000;
         this.repeats_ = param4;
         this.targetR = param2 >> 16 & 255;
         this.targetG = param2 >> 8 & 255;
         this.targetB = param2 & 255;
      }
      
      public function applyCPU(param1:BitmapData, param2:int) : BitmapData {
         var _loc3_:int = (param2 - this.startTime_) % this.periodMS_;
         var _loc4_:Number = Math.sin(_loc3_ / this.periodMS_ * 3.14159265358979);
         var _loc5_:Number = _loc4_ * 0.5;
         var _loc6_:ColorTransform = new ColorTransform(1 - _loc5_,1 - _loc5_,1 - _loc5_,1,_loc5_ * this.targetR,_loc5_ * this.targetG,_loc5_ * this.targetB,0);
         var _loc7_:BitmapData = param1.clone();
         _loc7_.colorTransform(_loc7_.rect,_loc6_);
         return _loc7_;
      }
      
      public function applyGPU(param1:BitmapData, param2:int) : void {
         var _loc3_:int = (param2 - this.startTime_) % this.periodMS_;
         var _loc6_:Number = Math.sin(_loc3_ / this.periodMS_ * 3.14159265358979);
         var _loc4_:Number = _loc6_ * 0.5;
         var _loc5_:ColorTransform = new ColorTransform(1 - _loc4_,1 - _loc4_,1 - _loc4_,1,_loc4_ * this.targetR,_loc4_ * this.targetG,_loc4_ * this.targetB,0);
         GraphicsFillExtra.setColorTransform(param1,_loc5_);
      }
      
      public function doneAt(param1:int) : Boolean {
         return param1 > this.startTime_ + this.periodMS_ * this.repeats_;
      }
   }
}
