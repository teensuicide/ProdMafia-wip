package com.company.assembleegameclient.objects.thrown {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.objects.BasicObject;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.geom.Matrix;
   
   public class BitmapParticle extends BasicObject {
       
      
      public var size_:int;
      
      public var _bitmapData:BitmapData;
      
      public var _rotation:Number = 0;
      
      protected var bitmapFill_:GraphicsBitmapFill;
      
      protected var vS_:Vector.<Number>;
      
      protected var fillMatrix_:Matrix;
      
      protected var _rotationDelta:Number = 0;
      
      public function BitmapParticle(param1:BitmapData, param2:Number) {
         bitmapFill_ = new GraphicsBitmapFill();
         vS_ = new Vector.<Number>();
         fillMatrix_ = new Matrix();
         super();
         objectId_ = getNextFakeObjectId();
         this._bitmapData = param1;
         z_ = param2;
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         _loc5_ = this._bitmapData;
         _loc6_ = _loc5_.width;
         _loc4_ = _loc5_.height;
         if(!_loc6_ || !_loc4_) {
            return;
         }
         this.vS_.length = 0;
         this.vS_.push(posS_[3] - _loc6_ / 2,posS_[4] - _loc4_ / 2,posS_[3] + _loc6_ / 2,posS_[4] - _loc4_ / 2,posS_[3] + _loc6_ / 2,posS_[4] + _loc4_ / 2,posS_[3] - _loc6_ / 2,posS_[4] + _loc4_ / 2);
         this.bitmapFill_.bitmapData = _loc5_;
         this.fillMatrix_.identity();
         if(this._rotation || Number(this._rotationDelta)) {
            if(this._rotationDelta) {
               this._rotation = this._rotation + this._rotationDelta;
            }
            this.fillMatrix_.translate(-_loc6_ / 2,-_loc4_ / 2);
            this.fillMatrix_.rotate(this._rotation);
            this.fillMatrix_.translate(_loc6_ / 2,_loc4_ / 2);
         }
         this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
         this.bitmapFill_.matrix = this.fillMatrix_;
         param1.push(this.bitmapFill_);
      }
      
      public function moveTo(param1:Number, param2:Number) : Boolean {
         var _loc3_:* = null;
         _loc3_ = map_.getSquare(param1,param2);
         if(!_loc3_) {
            return false;
         }
         x_ = param1;
         y_ = param2;
         square = _loc3_;
         return true;
      }
      
      public function setSize(param1:int) : void {
         this.size_ = param1 / 100 * 5;
      }
   }
}
