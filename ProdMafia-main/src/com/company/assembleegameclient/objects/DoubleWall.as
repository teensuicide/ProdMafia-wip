package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.engine3d.Face3D;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.BitmapUtil;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   
   public class DoubleWall extends GameObject {
      
      private static const UVT:Vector.<Number> = new <Number>[0,0,0,1,0,0,1,1,0,0,1,0];
      
      private static const UVTHEIGHT:Vector.<Number> = new <Number>[0,0,0,1,0,0,1,2,0,0,2,0];
      
      private static const sqX:Vector.<int> = new <int>[0,1,0,-1];
      
      private static const sqY:Vector.<int> = new <int>[-1,0,1,0];
       
      
      public var faces:Vector.<Face3D>;
      
      private var topFace:Face3D = null;
      
      private var topTexture:BitmapData = null;
      
      public function DoubleWall(param1:XML) {
         faces = new Vector.<Face3D>();
         super(param1);
         hasShadow_ = false;
         var _loc2_:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
         this.topTexture = _loc2_.getTexture(0);
      }
      
      override public function setObjectId(param1:int) : void {
         super.setObjectId(param1);
         var _loc2_:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
         this.topTexture = _loc2_.getTexture(param1);
      }
      
      override public function getColor() : uint {
         return BitmapUtil.mostCommonColor(this.topTexture);
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc4_:int = 0;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc6_:* = null;
         if(Parameters.lowCPUMode) {
            return;
         }
         if(texture == null) {
            return;
         }
         if(this.faces.length == 0) {
            this.rebuild3D();
         }
         var _loc8_:* = texture;
         if(animations_) {
            _loc7_ = animations_.getTexture(param3);
            if(_loc7_) {
               _loc8_ = _loc7_;
            }
         }
         var _loc5_:uint = this.faces.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_) {
            _loc9_ = this.faces[_loc4_];
            _loc6_ = map_.lookupSquare(x_ + sqX[_loc4_],y_ + sqY[_loc4_]);
            if(_loc6_ == null || _loc6_.texture_ == null || _loc6_ && _loc6_.obj_ is DoubleWall && !_loc6_.obj_.dead_) {
               _loc9_.blackOut_ = true;
            } else {
               _loc9_.blackOut_ = false;
               if(animations_) {
                  _loc9_.setTexture(_loc8_);
               }
            }
            _loc9_.draw(param1,param2);
            _loc4_++;
         }
         this.topFace.draw(param1,param2);
      }
      
      public function rebuild3D() : void {
         this.faces.length = 0;
         var _loc1_:int = x_;
         var _loc2_:int = y_;
         var _loc3_:Vector.<Number> = new <Number>[_loc1_,_loc2_,2,_loc1_ + 1,_loc2_,2,_loc1_ + 1,_loc2_ + 1,2,_loc1_,_loc2_ + 1,2];
         this.topFace = new Face3D(this.topTexture,_loc3_,UVT,false,true);
         this.topFace.bitmapFill.repeat = true;
         this.addFace(_loc1_,_loc2_,2,_loc1_ + 1,_loc2_,2);
         this.addFace(_loc1_ + 1,_loc2_,2,_loc1_ + 1,_loc2_ + 1,2);
         this.addFace(_loc1_ + 1,_loc2_ + 1,2,_loc1_,_loc2_ + 1,2);
         this.addFace(_loc1_,_loc2_ + 1,2,_loc1_,_loc2_,2);
      }
      
      private function addFace(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
         var _loc7_:Vector.<Number> = new <Number>[param1,param2,param3,param4,param5,param6,param4,param5,param6 - 1,param1,param2,param3 - 1];
         var _loc8_:Face3D = new Face3D(texture,_loc7_,UVTHEIGHT,true,true);
         _loc8_.bitmapFill.repeat = true;
         this.faces.push(_loc8_);
      }
   }
}
