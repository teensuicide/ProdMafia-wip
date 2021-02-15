package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Square;
   import com.company.assembleegameclient.objects.BasicObject;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.GraphicsUtil;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.display.GraphicsPath;
   import flash.geom.Matrix;
   
   public class Particle extends BasicObject {
       
      
      public var size_:int;
      
      public var color_:uint;
      
      protected var bitmapFill_:GraphicsBitmapFill;
      
      protected var path_:GraphicsPath;
      
      protected var vS_:Vector.<Number>;
      
      protected var fillMatrix_:Matrix;
      
      public function Particle(param1:uint, param2:Number, param3:int) {
         this.bitmapFill_ = new GraphicsBitmapFill(null,null,false,false);
         this.path_ = new GraphicsPath(GraphicsUtil.QUAD_COMMANDS,null);
         this.vS_ = new Vector.<Number>();
         this.fillMatrix_ = new Matrix();
         super();
         objectId_ = getNextFakeObjectId();
         this.setZ(param2);
         this.setColor(param1);
         this.setSize(param3);
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc6_:BitmapData = TextureRedrawer.redrawSolidSquare(this.color_,this.size_,this.size_);
         var _loc4_:int = _loc6_.width;
         var _loc5_:int = _loc6_.height;
         this.vS_.length = 0;
         this.vS_.push(posS_[3] - _loc4_ * 0.5,posS_[4] - _loc5_ * 0.5,posS_[3] + _loc4_ * 0.5,posS_[4] - _loc5_ * 0.5,posS_[3] + _loc4_ * 0.5,posS_[4] + _loc5_ * 0.5,posS_[3] - _loc4_ * 0.5,posS_[4] + _loc5_ * 0.5);
         this.path_.data = this.vS_;
         this.bitmapFill_.bitmapData = _loc6_;
         this.fillMatrix_.identity();
         this.fillMatrix_.translate(this.vS_[0],this.vS_[1]);
         this.bitmapFill_.matrix = this.fillMatrix_;
         param1.push(this.bitmapFill_);
      }
      
      public function moveTo(param1:Number, param2:Number) : Boolean {
         var _loc3_:Square = map_.getSquare(param1,param2);
         if(_loc3_ == null) {
            return false;
         }
         x_ = param1;
         y_ = param2;
         square = _loc3_;
         return true;
      }
      
      public function moveToInModal(param1:Number, param2:Number) : Boolean {
         x_ = param1;
         y_ = param2;
         return true;
      }
      
      public function setColor(param1:uint) : void {
         this.color_ = param1;
      }
      
      public function setZ(param1:Number) : void {
         z_ = param1;
      }
      
      public function setSize(param1:int) : void {
         this.size_ = param1 / 20;
      }
   }
}
