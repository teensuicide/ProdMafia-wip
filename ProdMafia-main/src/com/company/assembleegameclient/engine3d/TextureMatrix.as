package com.company.assembleegameclient.engine3d {
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class TextureMatrix {
       
      
      public var texture_:BitmapData = null;
      
      public var tToS_:Matrix;
      
      public var tempMatrix_:Matrix;
      
      public var uvMatrix_:Matrix;
      
      public function TextureMatrix(param1:BitmapData, param2:Vector.<Number>) {
         tToS_ = new Matrix();
         tempMatrix_ = new Matrix();
         uvMatrix_ = new Matrix();
         super();
         this.texture_ = param1;
         this.calculateUVMatrix(param2);
      }
      
      public function setUVT(param1:Vector.<Number>) : void {
         this.calculateUVMatrix(param1);
      }
      
      public function setVOut(param1:Vector.<Number>) : void {
         this.calculateTextureMatrix(param1);
      }
      
      public function calculateTextureMatrix(param1:Vector.<Number>) : void {
         this.tToS_.a = this.uvMatrix_.a;
         this.tToS_.b = this.uvMatrix_.b;
         this.tToS_.c = this.uvMatrix_.c;
         this.tToS_.d = this.uvMatrix_.d;
         this.tToS_.tx = this.uvMatrix_.tx;
         this.tToS_.ty = this.uvMatrix_.ty;
         var _loc2_:int = param1.length - 2;
         this.tempMatrix_.a = param1[2] - param1[0];
         this.tempMatrix_.b = param1[3] - param1[1];
         this.tempMatrix_.c = param1[_loc2_] - param1[0];
         this.tempMatrix_.d = param1[_loc2_ + 1] - param1[1];
         this.tempMatrix_.tx = param1[0];
         this.tempMatrix_.ty = param1[1];
         this.tToS_.concat(this.tempMatrix_);
      }
      
      public function calculateUVMatrix(param1:Vector.<Number>) : void {
         if(this.texture_ == null) {
            this.uvMatrix_ = null;
            return;
         }
         var _loc3_:int = this.texture_.height;
         var _loc2_:Number = param1[0] * _loc3_;
         var _loc4_:Number = param1[1] * _loc3_;
         this.uvMatrix_.a = param1[3] * _loc3_ - _loc2_;
         this.uvMatrix_.b = param1[4] * _loc3_ - _loc4_;
         this.uvMatrix_.c = param1[param1.length - 3] * _loc3_ - _loc2_;
         this.uvMatrix_.d = param1[param1.length - 2] * _loc3_ - _loc4_;
         this.uvMatrix_.tx = _loc2_;
         this.uvMatrix_.ty = _loc4_;
         this.uvMatrix_.invert();
      }
   }
}
