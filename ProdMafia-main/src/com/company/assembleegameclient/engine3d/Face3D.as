package com.company.assembleegameclient.engine3d {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.Triangle;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.geom.Utils3D;
   import flash.geom.Vector3D;
   
   public class Face3D {
       
      
      public var origTexture_:BitmapData;
      
      public var vin_:Vector.<Number>;
      
      public var uvt:Vector.<Number>;
      
      public var vout_:Vector.<Number>;
      
      public var backfaceCull_:Boolean;
      
      public var shade_:Number = 1;
      
      public var blackOut_:Boolean = false;
      
      public var bitmapFill:GraphicsBitmapFill;
      
      private var blackOutFill:GraphicsBitmapFill;
      
      private var needGen_:Boolean = true;
      
      private var textureMatrix_:TextureMatrix = null;
      
      public function Face3D(param1:BitmapData, param2:Vector.<Number>, param3:Vector.<Number>, param4:Boolean = false, param5:Boolean = false) {
         var _loc6_:* = null;
         vout_ = new Vector.<Number>();
         bitmapFill = new GraphicsBitmapFill(null,null,false,false);
         blackOutFill = new GraphicsBitmapFill(null,null,false,false);
         super();
         this.origTexture_ = param1;
         this.vin_ = param2;
         this.uvt = param3;
         this.backfaceCull_ = param4;
         if(param5) {
            _loc6_ = new Vector3D();
            Plane3D.computeNormalVec(param2,_loc6_);
            this.shade_ = Lighting3D.shadeValue(_loc6_,0.75);
         }
      }
      
      public function dispose() : void {
         this.origTexture_ = null;
         this.vin_.length = 0;
         this.vin_ = null;
         this.uvt.length = 0;
         this.uvt = null;
         this.vout_.length = 0;
         this.vout_ = null;
         this.textureMatrix_.uvMatrix_ = null;
         this.textureMatrix_.tToS_ = null;
         this.textureMatrix_.tempMatrix_ = null;
         this.textureMatrix_ = null;
         this.bitmapFill = null;
      }
      
      public function setTexture(param1:BitmapData) : void {
         if(this.origTexture_ == param1) {
            return;
         }
         this.origTexture_ = param1;
         this.needGen_ = true;
      }
      
      public function setUVT(param1:Vector.<Number>) : void {
         this.uvt = param1;
         this.needGen_ = true;
      }
      
      public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera) : Boolean {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         Utils3D.projectVectors(param2.wToS_,this.vin_,this.vout_,this.uvt);
         if(this.backfaceCull_ && (this.vout_[2] - this.vout_[0]) * (this.vout_[5] - this.vout_[1]) - (this.vout_[3] - this.vout_[1]) * (this.vout_[4] - this.vout_[0]) > 0) {
            return false;
         }
         var _loc3_:uint = this.vout_.length;
         var _loc6_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _loc3_) {
            if(this.vout_[_loc5_] >= param2.clipRect_.x - 10 && this.vout_[_loc5_] <= param2.clipRect_.right + 10 && this.vout_[_loc5_ + 1] >= param2.clipRect_.y - 10 && this.vout_[_loc5_ + 1] <= param2.clipRect_.bottom + 10) {
               _loc6_ = false;
               break;
            }
            _loc5_ = _loc5_ + 2;
         }
         if(_loc6_) {
            return false;
         }
         if(this.needGen_) {
            this.generateTextureMatrix();
         }
         this.textureMatrix_.calculateTextureMatrix(this.vout_);
         if(this.blackOut_) {
            if(this.needGen_ || !this.blackOutFill.bitmapData) {
               _loc4_ = this.textureMatrix_.texture_;
               this.blackOutFill.bitmapData = new BitmapData(_loc4_.width,_loc4_.height,false,0);
            }
            this.blackOutFill.matrix = this.textureMatrix_.tToS_;
            param1.push(blackOutFill);
            return true;
         }
         this.bitmapFill.bitmapData = this.textureMatrix_.texture_;
         this.bitmapFill.matrix = this.textureMatrix_.tToS_;
         param1.push(this.bitmapFill);
         return true;
      }
      
      public function contains(param1:Number, param2:Number) : Boolean {
         if(Triangle.containsXY(this.vout_[0],this.vout_[1],this.vout_[2],this.vout_[3],this.vout_[4],this.vout_[5],param1,param2)) {
            return true;
         }
         return this.vout_.length == 8 && Triangle.containsXY(this.vout_[0],this.vout_[1],this.vout_[4],this.vout_[5],this.vout_[6],this.vout_[7],param1,param2);
      }
      
      private function generateTextureMatrix() : void {
         var _loc1_:BitmapData = TextureRedrawer.redrawFace(this.origTexture_,this.shade_);
         if(this.textureMatrix_ == null) {
            this.textureMatrix_ = new TextureMatrix(_loc1_,this.uvt);
         } else {
            this.textureMatrix_.texture_ = _loc1_;
            this.textureMatrix_.calculateUVMatrix(this.uvt);
         }
         this.needGen_ = false;
      }
   }
}
