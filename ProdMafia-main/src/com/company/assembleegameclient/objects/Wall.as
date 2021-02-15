package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.engine3d.Face3D;
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Square;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.util.BitmapUtil;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   
   public class Wall extends GameObject {
      
      private static const UVT:Vector.<Number> = new <Number>[0,0,0,1,0,0,1,1,0,0,1,0];
      
      private static const sqX:Vector.<int> = new <int>[0,1,0,-1];
      
      private static const sqY:Vector.<int> = new <int>[-1,0,1,0];
      
      private static var nums:Vector.<Number> = new <Number>[0,0,0,0,0,0,0,0,0,0,0,0];
       
      
      public var faces_:Vector.<Face3D>;
      
      private var topFace_:Face3D = null;
      
      private var topTexture_:BitmapData = null;
      
      public function Wall(param1:XML) {
         faces_ = new Vector.<Face3D>();
         super(param1);
         hasShadow_ = false;
         var _loc2_:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
         this.topTexture_ = _loc2_.getTexture(0);
      }
      
      override public function setObjectId(param1:int) : void {
         super.setObjectId(param1);
         var _loc2_:TextureData = ObjectLibrary.typeToTopTextureData_[objectType_];
         this.topTexture_ = _loc2_.getTexture(param1);
      }
      
      override public function getColor() : uint {
         return BitmapUtil.mostCommonColor(this.topTexture_);
      }
      
      override public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc4_:int = 0;
         var _loc8_:BitmapData = null;
         var _loc9_:Face3D = null;
         var _loc6_:Square = null;
         if(Parameters.lowCPUMode) {
            return;
         }
         if(texture == null) {
            return;
         }
         if(this.faces_.length == 0) {
            this.rebuild3D_clean();
         }
         var _loc7_:* = texture;
         if(this.animations_) {
            _loc8_ = this.animations_.getTexture(param3);
            if(_loc8_) {
               _loc7_ = _loc8_;
            }
         }
         var _loc5_:uint = this.faces_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc5_) {
            _loc9_ = this.faces_[_loc4_];
            _loc6_ = this.map_.lookupSquare(x_ + sqX[_loc4_],y_ + sqY[_loc4_]);
            if(_loc6_ == null || _loc6_.texture_ == null || _loc6_ && _loc6_.obj_ is Wall && !_loc6_.obj_.dead_) {
               _loc9_.blackOut_ = true;
            } else {
               _loc9_.blackOut_ = false;
               if(this.animations_) {
                  _loc9_.setTexture(_loc7_);
               }
            }
            _loc9_.draw(param1,param2);
            _loc4_++;
         }
         this.topFace_.draw(param1,param2);
      }
      
      public function rebuild3D_clean() : void {
         this.faces_.length = 0;
         var _loc2_:int = x_;
         var _loc1_:int = y_;
         var _loc3_:Vector.<Number> = new <Number>[_loc2_,_loc1_,1,_loc2_ + 1,_loc1_,1,_loc2_ + 1,_loc1_ + 1,1,_loc2_,_loc1_ + 1,1];
         this.topFace_ = new Face3D(this.topTexture_,_loc3_,UVT,false,true);
         this.topFace_.bitmapFill.repeat = true;
         this.addWall(_loc2_,_loc1_,1,_loc2_ + 1,_loc1_,1);
         this.addWall(_loc2_ + 1,_loc1_,1,_loc2_ + 1,_loc1_ + 1,1);
         this.addWall(_loc2_ + 1,_loc1_ + 1,1,_loc2_,_loc1_ + 1,1);
         this.addWall(_loc2_,_loc1_ + 1,1,_loc2_,_loc1_,1);
      }
      
      public function rebuild3D_2() : void {
         this.faces_.length = 0;
         var _loc2_:int = x_ + 1;
         var _loc1_:int = y_ + 1;
         nums[0] = x_;
         nums[1] = y_;
         nums[2] = 1;
         nums[3] = _loc2_;
         nums[4] = y_;
         nums[5] = 1;
         nums[6] = _loc2_;
         nums[7] = _loc1_;
         nums[8] = 1;
         nums[9] = x_;
         nums[10] = _loc1_;
         nums[11] = 1;
         this.topFace_ = new Face3D(this.topTexture_,nums,UVT,false,true);
         this.topFace_.bitmapFill.repeat = true;
         this.addWall(x_,y_,1,_loc2_,y_,1);
         this.addWall(_loc2_,y_,1,_loc2_,_loc1_,1);
         this.addWall(_loc2_,_loc1_,1,x_,_loc1_,1);
         this.addWall(x_,_loc1_,1,x_,y_,1);
      }
      
      private function addWall(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : void {
         var _loc7_:Vector.<Number> = new <Number>[param1,param2,param3,param4,param5,param6,param4,param5,param6 - 1,param1,param2,param3 - 1];
         var _loc8_:Face3D = new Face3D(texture,_loc7_,UVT,true,true);
         _loc8_.bitmapFill.repeat = true;
         this.faces_.push(_loc8_);
      }
   }
}
