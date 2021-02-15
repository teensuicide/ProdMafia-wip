package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.map.Camera;
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.map.Square;
   import com.company.assembleegameclient.util.BloodComposition;
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   
   public class BasicObject {
      
      private static var nextFakeObjectId_:int = 0;
       
      
      public var map_:Map;
      
      public var square:Square;
      
      public var objectId_:int;
      
      public var x_:Number;
      
      public var y_:Number;
      
      public var z_:Number;
      
      public var hasShadow_:Boolean;
      
      public var drawn_:Boolean;
      
      public var posW_:Vector.<Number>;
      
      public var posS_:Vector.<Number>;
      
      public var sortVal_:int;
      
      public function BasicObject() {
         this.posW_ = new Vector.<Number>();
         this.posS_ = new Vector.<Number>();
         super();
         this.clear();
      }
      
      public static function getNextFakeObjectId() : int {
         nextFakeObjectId_ = Number(nextFakeObjectId_) + 1;
         return 2130706432 | nextFakeObjectId_;
      }
      
      public function clear() : void {
         this.map_ = null;
         this.square = null;
         this.objectId_ = -1;
         this.x_ = 0;
         this.y_ = 0;
         this.z_ = 0;
         this.hasShadow_ = false;
         this.drawn_ = false;
         this.posW_.length = 0;
         this.posS_.length = 0;
         this.sortVal_ = 0;
      }
      
      public function dispose() : void {
         this.map_ = null;
         this.square = null;
         this.posW_ = null;
         this.posS_ = null;
      }
      
      public function update(param1:int, param2:int) : Boolean {
         return true;
      }
      
      public function draw(param1:Vector.<GraphicsBitmapFill>, param2:Camera, param3:int) : void {
      }
      
      public function computeSortVal(param1:Camera) : void {
         this.posW_.length = 0;
         this.posW_.push(this.x_,this.y_,0,this.x_,this.y_,this.z_);
         this.posS_.length = 0;
         param1.wToS_.transformVectors(this.posW_,this.posS_);
         this.sortVal_ = int(this.posS_[1]);
      }
      
      public function computeSortValNoCamera(param1:Number = 12) : void {
         this.posW_.length = 0;
         this.posW_.push(this.x_,this.y_,0,this.x_,this.y_,this.z_);
         this.posS_.length = 0;
         this.posS_.push(this.x_ * param1,this.y_ * param1,0,this.x_ * param1,this.y_ * param1,0);
         this.sortVal_ = int(this.posS_[1]);
      }
      
      public function addTo(param1:Map, param2:Number, param3:Number) : Boolean {
         this.map_ = param1;
         this.square = this.map_.getSquare(param2,param3);
         if(this.square == null) {
            this.map_ = null;
            return false;
         }
         this.x_ = param2;
         this.y_ = param3;
         return true;
      }
      
      public function removeFromMap() : void {
         this.map_ = null;
         this.square = null;
      }
      
      public function getBloodComposition(param1:int, param2:BitmapData, param3:Number, param4:uint) : Vector.<uint> {
         var _loc8_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:Vector.<uint> = BloodComposition.idDict_[param1];
         if(_loc7_) {
            return _loc7_;
         }
         _loc7_ = new Vector.<uint>();
         var _loc5_:Vector.<uint> = this.getColors(param2);
         var _loc9_:uint = _loc5_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc9_) {
            _loc8_ = Math.random();
            if(_loc8_ < param3) {
               _loc7_.push(param4);
            } else {
               _loc7_.push(_loc5_[int(_loc9_ * _loc8_)]);
            }
            _loc6_++;
         }
         return _loc7_;
      }
      
      public function getColors(param1:BitmapData) : Vector.<uint> {
         var _loc2_:Vector.<uint> = BloodComposition.imageDict_[param1];
         if(_loc2_ == null) {
            _loc2_ = this.buildColors(param1);
            BloodComposition.imageDict_[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function buildColors(param1:BitmapData) : Vector.<uint> {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         var _loc4_:int = param1.width;
         var _loc7_:int = param1.height;
         var _loc5_:Vector.<uint> = new Vector.<uint>();
         _loc6_ = 0;
         while(_loc6_ < _loc4_) {
            _loc3_ = 0;
            while(_loc3_ < _loc7_) {
               _loc2_ = uint(param1.getPixel32(_loc6_,_loc3_));
               if((_loc2_ & 4278190080) != 0) {
                  _loc5_.push(_loc2_);
               }
               _loc3_++;
            }
            _loc6_++;
         }
         return _loc5_;
      }
   }
}
