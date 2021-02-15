package com.company.assembleegameclient.engine3d {
   import com.company.assembleegameclient.map.Camera;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.display.GraphicsEndFill;
   import flash.display.GraphicsPath;
   import flash.display.GraphicsSolidFill;
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Utils3D;
   import flash.geom.Vector3D;
   
   public class Point3D {
      
      private static const commands_:Vector.<int> = new <int>[1,2,2,2];
      
      private static const END_FILL:GraphicsEndFill = new GraphicsEndFill();
       
      
      private const data_:Vector.<Number> = new Vector.<Number>();
      
      private const path_:GraphicsPath = new GraphicsPath(commands_,data_);
      
      private const bitmapFill_:GraphicsBitmapFill = new GraphicsBitmapFill(null,new Matrix(),false,false);
      
      private const solidFill_:GraphicsSolidFill = new GraphicsSolidFill(0,1);
      
      public var size_:Number;
      
      public var posS_:Vector3D;
      
      public function Point3D(param1:Number) {
         super();
         this.size_ = param1;
      }
      
      public function setSize(param1:Number) : void {
         this.size_ = param1;
      }
      
      public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Vector3D, param3:Number, param4:Matrix3D, param5:Camera, param6:BitmapData, param7:uint = 0) : void {
         var _loc12_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:* = null;
         this.posS_ = Utils3D.projectVector(param4,param2);
         if(this.posS_.w < 0) {
            return;
         }
         var _loc11_:Number = this.posS_.w * Math.sin(param5.pp_.fieldOfView / 2 * 0.0174532925199433);
         var _loc8_:Number = this.size_ / _loc11_;
         this.data_.length = 0;
         if(param3 == 0) {
            this.data_.push(this.posS_.x - _loc8_,this.posS_.y - _loc8_,this.posS_.x + _loc8_,this.posS_.y - _loc8_,this.posS_.x + _loc8_,this.posS_.y + _loc8_,this.posS_.x - _loc8_,this.posS_.y + _loc8_);
         } else {
            _loc12_ = Math.cos(param3);
            _loc10_ = Math.sin(param3);
            this.data_.push(this.posS_.x + (_loc12_ * -_loc8_ + _loc10_ * -_loc8_),this.posS_.y + (_loc10_ * -_loc8_ - _loc12_ * -_loc8_),this.posS_.x + (_loc12_ * _loc8_ + _loc10_ * -_loc8_),this.posS_.y + (_loc10_ * _loc8_ - _loc12_ * -_loc8_),this.posS_.x + (_loc12_ * _loc8_ + _loc10_ * _loc8_),this.posS_.y + (_loc10_ * _loc8_ - _loc12_ * _loc8_),this.posS_.x + (_loc12_ * -_loc8_ + _loc10_ * _loc8_),this.posS_.y + (_loc10_ * -_loc8_ - _loc12_ * _loc8_));
         }
         if(param6 != null) {
            this.bitmapFill_.bitmapData = param6;
            _loc9_ = this.bitmapFill_.matrix;
            _loc9_.identity();
            _loc9_.scale(2 * _loc8_ / param6.width,2 * _loc8_ / param6.height);
            _loc9_.translate(-_loc8_,-_loc8_);
            _loc9_.rotate(param3);
            _loc9_.translate(this.posS_.x,this.posS_.y);
            param1.push(this.bitmapFill_);
         } else {
            this.solidFill_.color = param7;
            param1.push(this.solidFill_);
         }
      }
   }
}
