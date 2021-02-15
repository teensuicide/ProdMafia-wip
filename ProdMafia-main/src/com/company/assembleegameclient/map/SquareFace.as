package com.company.assembleegameclient.map {
   import com.company.assembleegameclient.engine3d.Face3D;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import kabam.rotmg.stage3D.GraphicsFillExtra;
   
   public class SquareFace {
       
      
      public var animate_:int;
      
      public var face:Face3D;
      
      public var xOffset:Number = 0;
      
      public var yOffset:Number = 0;
      
      public var animateDx:Number = 0;
      
      public var animateDy:Number = 0;
      
      public function SquareFace(param1:BitmapData, param2:Vector.<Number>, param3:Number, param4:Number, param5:int, param6:Number, param7:Number) {
         super();
         this.face = new Face3D(param1,param2,Square.UVT.concat());
         this.xOffset = param3;
         this.yOffset = param4;
         if(this.xOffset != 0 || this.yOffset != 0) {
            this.face.bitmapFill.repeat = true;
         }
         this.animate_ = param5;
         if(this.animate_ != 0) {
            this.face.bitmapFill.repeat = true;
         }
         this.animateDx = param6;
         this.animateDy = param7;
      }
      
      public function dispose() : void {
         this.face.dispose();
         this.face = null;
      }
      
      public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : Boolean {
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.animate_ != 0) {
            var _loc7_:* = int(this.animate_) - 1;
            switch(_loc7_) {
               case 0:
                  _loc5_ = this.xOffset + Math.sin(this.animateDx * param3 / 1000);
                  _loc4_ = this.yOffset + Math.sin(this.animateDy * param3 / 1000);
                  break;
               case 1:
                  _loc5_ = this.xOffset + this.animateDx * param3 / 1000;
                  _loc4_ = this.yOffset + this.animateDy * param3 / 1000;
            }
         } else {
            _loc5_ = this.xOffset;
            _loc4_ = this.yOffset;
         }
         GraphicsFillExtra.setOffsetUV(this.face.bitmapFill,_loc5_,_loc4_);
         this.face.uvt.length = 0;
         this.face.uvt.push(0,0,0,1,0,0,1,1,0,0,1,0);
         this.face.setUVT(this.face.uvt);
         var _loc6_:Boolean = this.face.draw(param1,param2);
         return _loc6_;
      }
   }
}
