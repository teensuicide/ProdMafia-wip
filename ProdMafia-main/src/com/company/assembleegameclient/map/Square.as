package com.company.assembleegameclient.map {
   import com.company.assembleegameclient.engine3d.TextureMatrix;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.TileRedrawer;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   
   public class Square {
      
      public static const UVT:Vector.<Number> = new <Number>[0,0,0,1,0,0,1,1,0,0,1,0];
      
      private static const LOOKUP:Vector.<int> = new <int>[26171,44789,20333,70429,98257,59393,33961];
       
      
      public var map:Map;
      
      public var x_:int;
      
      public var y_:int;
      
      public var tileType:uint = 255;
      
      public var centerX_:Number;
      
      public var centerY_:Number;
      
      public var vin_:Vector.<Number>;
      
      public var obj_:GameObject = null;
      
      public var props_:GroundProperties;
      
      public var texture_:BitmapData = null;
      
      public var textureW_:int;
      
      public var textureH_:int;
      
      public var sink:int = 0;
      
      public var lastDamage_:int = 0;
      
      public var faces_:Vector.<SquareFace>;
      
      public var topFace_:SquareFace = null;
      
      public var baseTexMatrix_:TextureMatrix = null;
      
      public var lastVisible_:int;
      
      public var bmpRect_:BitmapData;
      
      public function Square(param1:Map, param2:int, param3:int) {
         props_ = GroundLibrary.defaultProps_;
         faces_ = new Vector.<SquareFace>();
         super();
         this.map = param1;
         this.x_ = param2;
         this.y_ = param3;
         this.centerX_ = this.x_ + 0.5;
         this.centerY_ = this.y_ + 0.5;
         this.vin_ = new <Number>[this.x_,this.y_,0,this.x_ + 1,this.y_,0,this.x_ + 1,this.y_ + 1,0,this.x_,this.y_ + 1,0];
      }
      
      public static function hash(param1:int, param2:int) : int {
         return ((param1 << 16 | param2) ^ 81397550) * LOOKUP[(param1 + param2) % 7] % 65535;
      }
      
      public function dispose() : void {
         var _loc3_:* = null;
         this.map = null;
         this.vin_.length = 0;
         this.vin_ = null;
         this.obj_ = null;
         this.texture_ = null;
         var _loc1_:* = this.faces_;
         var _loc5_:int = 0;
         var _loc4_:* = this.faces_;
         for each(_loc3_ in this.faces_) {
            _loc3_.dispose();
            _loc3_ = null;
         }
         this.faces_.length = 0;
         if(this.topFace_) {
            this.topFace_.dispose();
            this.topFace_ = null;
         }
         this.faces_ = null;
         this.baseTexMatrix_ = null;
      }
      
      public function setTileType(param1:uint) : void {
         this.tileType = param1;
         this.props_ = GroundLibrary.propsLibrary_[this.tileType];
         this.texture_ = GroundLibrary.getBitmapData(this.tileType,hash(this.x_,this.y_));
         this.bmpRect_ = GroundLibrary.getBitmapData(this.tileType);
         this.textureW_ = this.texture_.width;
         this.textureH_ = this.texture_.height;
         this.baseTexMatrix_ = new TextureMatrix(this.texture_,UVT);
         this.faces_.length = 0;
      }
      
      public function isWalkable() : Boolean {
         return !this.props_ || !this.props_.noWalk_ && (this.obj_ == null || !this.obj_.props_.occupySquare_);
      }
      
      public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         var _loc5_:SquareFace = null;
         if(Parameters.lowCPUMode && this.map && this.map.player_ && this != this.map.player_.square && this.props_.maxDamage_ == 0) {
            return;
         }
         if(Parameters.data.noClip && !this.isWalkable()) {
            return;
         }
         if(this.texture_ == null) {
            return;
         }
         if(this.faces_.length == 0) {
            this.rebuild3D();
         }
         var _loc4_:Number = param2.clipRect_.bottom;
         var _loc7_:int = 0;
         var _loc6_:* = this.faces_;
         for each(_loc5_ in this.faces_) {
            if(!_loc5_.draw(param1,param2,param3)) {
               if(_loc5_.face.vout_[1] < _loc4_) {
                  this.lastVisible_ = 0;
               }
               return;
            }
         }
      }
      
      public function drawTop(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
         this.topFace_.draw(param1,param2,param3);
      }
      
      private function rebuild3D() : void {
         var _loc3_:* = NaN;
         var _loc2_:* = NaN;
         var _loc1_:* = 0;
         var _loc6_:* = undefined;
         var _loc5_:* = 0;
         var _loc4_:* = null;
         var _loc7_:* = null;
         this.faces_.length = 0;
         this.topFace_ = null;
         if(this.props_ && this.props_.animate_.type_ != 0) {
            this.faces_.push(new SquareFace(this.texture_,this.vin_,this.props_.xOffset_,this.props_.yOffset_,this.props_.animate_.type_,this.props_.animate_.dx_,this.props_.animate_.dy_));
            _loc4_ = TileRedrawer.redraw(this,false);
            if(_loc4_) {
               this.faces_.push(new SquareFace(_loc4_,this.vin_,0,0,0,0,0));
            }
         } else {
            _loc4_ = TileRedrawer.redraw(this,true);
            _loc3_ = 0;
            _loc2_ = 0;
            if(_loc4_ == null) {
               if(this.props_ && this.props_.randomOffset_) {
                  _loc3_ = int(this.textureW_ * Math.random()) / this.textureW_;
                  _loc2_ = int(this.textureH_ * Math.random()) / this.textureH_;
               } else {
                  _loc3_ = !!this.props_?this.props_.xOffset_:0;
                  _loc2_ = !!this.props_?this.props_.yOffset_:0;
               }
               this.faces_.push(new SquareFace(this.texture_,this.vin_,_loc3_,_loc2_,0,0,0));
            } else {
               this.faces_.push(new SquareFace(_loc4_,this.vin_,_loc3_,_loc2_,0,0,0));
            }
         }
         if(this.props_ && this.props_.sink_) {
            this.sink = _loc4_ == null?12:6;
         } else {
            this.sink = 0;
         }
         if(this.props_ && this.props_.topTD_) {
            _loc7_ = this.props_.topTD_.getTexture();
            _loc6_ = this.vin_.concat();
            _loc1_ = uint(_loc6_.length);
            _loc5_ = 2;
            while(_loc5_ < _loc1_) {
               _loc6_[_loc5_] = 1;
               _loc5_ = uint(_loc5_ + 3);
            }
            this.topFace_ = new SquareFace(_loc7_,_loc6_,0,0,this.props_.topAnimate_.type_,this.props_.topAnimate_.dx_,this.props_.topAnimate_.dy_);
         }
      }
   }
}
