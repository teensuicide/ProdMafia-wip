package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.map.GroundLibrary;
   import com.company.assembleegameclient.map.GroundProperties;
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.map.Square;
   import com.company.util.AssetLibrary;
   import com.company.util.BitmapUtil;
   import com.company.util.ImageSet;
   import com.company.util.PointUtil;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class TileRedrawer {
      
      private static const INNER:int = 0;
      
      private static const SIDE0:int = 1;
      
      private static const SIDE1:int = 2;
      
      private static const OUTER:int = 3;
      
      private static const INNERP1:int = 4;
      
      private static const INNERP2:int = 5;
      
      private static const rect0:Rectangle = new Rectangle(0,0,4,4);
      
      private static const p0:Point = new Point(0,0);
      
      private static const rect1:Rectangle = new Rectangle(4,0,4,4);
      
      private static const p1:Point = new Point(4,0);
      
      private static const rect2:Rectangle = new Rectangle(0,4,4,4);
      
      private static const p2:Point = new Point(0,4);
      
      private static const rect3:Rectangle = new Rectangle(4,4,4,4);
      
      private static const p3:Point = new Point(4,4);
      
      private static const mlist_:Vector.<Vector.<ImageSet>> = getMasks();
      
      private static const RECT01:Rectangle = new Rectangle(0,0,8,4);
      
      private static const RECT13:Rectangle = new Rectangle(4,0,4,8);
      
      private static const RECT23:Rectangle = new Rectangle(0,4,8,4);
      
      private static const RECT02:Rectangle = new Rectangle(0,0,4,8);
      
      private static const RECT0:Rectangle = new Rectangle(0,0,4,4);
      
      private static const RECT1:Rectangle = new Rectangle(4,0,4,4);
      
      private static const RECT2:Rectangle = new Rectangle(0,4,4,4);
      
      private static const RECT3:Rectangle = new Rectangle(4,4,4,4);
      
      private static const POINT0:Point = new Point(0,0);
      
      private static const POINT1:Point = new Point(4,0);
      
      private static const POINT2:Point = new Point(0,4);
      
      private static const POINT3:Point = new Point(4,4);
      
      private static var cache__:Dictionary = new Dictionary();
      
      private static var cache_:Vector.<Object> = new <Object>[null,{}];
       
      
      public function TileRedrawer() {
         super();
      }
      
      public static function clearCache() : void {
         var _loc3_:int = 0;
         var _loc2_:* = cache__;
         for each(var _loc1_ in cache__) {
            if(_loc1_) {
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         cache__ = new Dictionary();
      }
      
      public static function redraw(param1:Square, param2:Boolean) : BitmapData {
         var _loc9_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = param1.tileType == 253;
         if(_loc10_) {
            _loc8_ = getCompositeSig(param1);
         } else if(param1 && param1.props_ && param1.props_.hasEdge_) {
            _loc8_ = getEdgeSig(param1);
         } else {
            _loc8_ = getSig(param1);
         }
         if(_loc8_ == null) {
            return null;
         }
         if(_loc8_ in cache__) {
            return cache__[_loc8_];
         }
         if(_loc10_) {
            _loc7_ = buildComposite(_loc8_);
            cache__[_loc8_] = _loc7_;
            return _loc7_;
         }
         if(param1 && param1.props_ && param1.props_.hasEdge_) {
            _loc7_ = drawEdges(_loc8_);
            cache__[_loc8_] = _loc7_;
            return _loc7_;
         }
         var _loc3_:uint = _loc8_[4];
         if(_loc8_[1] != _loc3_) {
            _loc10_ = true;
            _loc9_ = true;
         }
         if(_loc8_[3] != _loc3_) {
            _loc10_ = true;
            _loc6_ = true;
         }
         if(_loc8_[5] != _loc3_) {
            _loc9_ = true;
            _loc4_ = true;
         }
         if(_loc8_[7] != _loc3_) {
            _loc6_ = true;
            _loc4_ = true;
         }
         if(!_loc10_ && _loc8_[0] != _loc3_) {
            _loc10_ = true;
         }
         if(!_loc9_ && _loc8_[2] != _loc3_) {
            _loc9_ = true;
         }
         if(!_loc6_ && _loc8_[6] != _loc3_) {
            _loc6_ = true;
         }
         if(!_loc4_ && _loc8_[8] != _loc3_) {
            _loc4_ = true;
         }
         if(!_loc10_ && !_loc9_ && !_loc6_ && !_loc4_) {
            cache__[_loc8_] = null;
            return null;
         }
         var _loc5_:BitmapData = param1.bmpRect_;
         if(param2) {
            _loc7_ = _loc5_.clone();
         } else {
            _loc7_ = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         }
         if(_loc10_) {
            redrawRect(_loc7_,rect0,p0,mlist_[0],_loc3_,_loc8_[3],_loc8_[0],_loc8_[1]);
         }
         if(_loc9_) {
            redrawRect(_loc7_,rect1,p1,mlist_[1],_loc3_,_loc8_[1],_loc8_[2],_loc8_[5]);
         }
         if(_loc6_) {
            redrawRect(_loc7_,rect2,p2,mlist_[2],_loc3_,_loc8_[7],_loc8_[6],_loc8_[3]);
         }
         if(_loc4_) {
            redrawRect(_loc7_,rect3,p3,mlist_[3],_loc3_,_loc8_[5],_loc8_[8],_loc8_[7]);
         }
         cache__[_loc8_] = _loc7_;
         _loc8_.length = 0;
         return _loc7_;
      }
      
      private static function redrawRect(param1:BitmapData, param2:Rectangle, param3:Point, param4:Vector.<ImageSet>, param5:uint, param6:uint, param7:uint, param8:uint) : void {
         var _loc10_:* = null;
         var _loc9_:* = null;
         if(param5 == param6 && param5 == param8) {
            _loc9_ = param4[3].random();
            _loc10_ = GroundLibrary.getBitmapData(param7);
         } else if(param5 != param6 && param5 != param8) {
            if(param6 != param8) {
               param1.copyPixels(GroundLibrary.getBitmapData(param6),param2,param3,param4[4].random(),p0,true);
               param1.copyPixels(GroundLibrary.getBitmapData(param8),param2,param3,param4[5].random(),p0,true);
               return;
            }
            _loc9_ = param4[0].random();
            _loc10_ = GroundLibrary.getBitmapData(param6);
         } else if(param5 != param6) {
            _loc9_ = param4[1].random();
            _loc10_ = GroundLibrary.getBitmapData(param6);
         } else {
            _loc9_ = param4[2].random();
            _loc10_ = GroundLibrary.getBitmapData(param8);
         }
         param1.copyPixels(_loc10_,param2,param3,_loc9_,p0,true);
      }
      
      private static function getSig(param1:Square) : Array {
         var _loc2_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:Square = null;
         var _loc7_:* = [];
         var _loc3_:Map = param1.map;
         var _loc10_:uint = param1.tileType;
         var _loc6_:int = param1.y_ + 1;
         var _loc5_:int = param1.x_ + 1;
         _loc9_ = param1.y_ - 1;
         while(_loc9_ <= _loc6_) {
            _loc8_ = _loc9_ * _loc3_.mapWidth;
            _loc2_ = param1.x_ - 1;
            while(_loc2_ <= _loc5_) {
               if(_loc2_ < 0 || _loc2_ >= _loc3_.mapWidth || _loc9_ < 0 || _loc9_ >= _loc3_.mapHeight || _loc2_ == param1.x_ && _loc9_ == param1.y_) {
                  _loc7_.push(_loc10_);
               } else {
                  _loc4_ = _loc3_.squares[_loc2_ + _loc8_];
                  if(_loc4_ == null || _loc4_.props_.blendPriority_ <= param1.props_.blendPriority_) {
                     _loc7_.push(_loc10_);
                  } else {
                     _loc7_.push(_loc4_.tileType);
                  }
               }
               _loc2_++;
            }
            _loc9_++;
         }
         return _loc7_;
      }
      
      private static function getMasks() : Vector.<Vector.<ImageSet>> {
         var _loc1_:Vector.<Vector.<ImageSet>> = new Vector.<Vector.<ImageSet>>();
         addMasks(_loc1_,AssetLibrary.getImageSet("inner_mask"),AssetLibrary.getImageSet("sides_mask"),AssetLibrary.getImageSet("outer_mask"),AssetLibrary.getImageSet("innerP1_mask"),AssetLibrary.getImageSet("innerP2_mask"));
         return _loc1_;
      }
      
      private static function addMasks(param1:Vector.<Vector.<ImageSet>>, param2:ImageSet, param3:ImageSet, param4:ImageSet, param5:ImageSet, param6:ImageSet) : void {
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:* = [-1,0,2,1];
         for each(_loc9_ in [-1,0,2,1]) {
            param1.push(new <ImageSet>[rotateImageSet(param2,_loc9_),rotateImageSet(param3,_loc9_ - 1),rotateImageSet(param3,_loc9_),rotateImageSet(param4,_loc9_),rotateImageSet(param5,_loc9_),rotateImageSet(param6,_loc9_)]);
         }
      }
      
      private static function rotateImageSet(param1:ImageSet, param2:int) : ImageSet {
         var _loc3_:* = null;
         var _loc5_:ImageSet = new ImageSet();
         var _loc6_:* = param1.images;
         var _loc8_:int = 0;
         var _loc7_:* = param1.images;
         for each(_loc3_ in param1.images) {
            _loc5_.add(BitmapUtil.rotateBitmapData(_loc3_,param2));
         }
         return _loc5_;
      }
      
      private static function getCompositeSig(param1:Square) : Array {
         var _loc11_:Square = null;
         var _loc3_:Square = null;
         var _loc9_:Square = null;
         var _loc17_:Square = null;
         var _loc5_:* = [];
         _loc5_.length = 4;
         var _loc7_:Map = param1.map;
         var _loc10_:int = param1.x_;
         var _loc13_:int = param1.y_;
         var _loc6_:Square = _loc7_.lookupSquare(_loc10_,_loc13_ - 1);
         var _loc14_:Square = _loc7_.lookupSquare(_loc10_ - 1,_loc13_);
         var _loc15_:Square = _loc7_.lookupSquare(_loc10_ + 1,_loc13_);
         var _loc12_:Square = _loc7_.lookupSquare(_loc10_,_loc13_ + 1);
         var _loc16_:int = !!_loc6_?_loc6_.props_.compositePriority_:-1;
         var _loc4_:int = !!_loc14_?_loc14_.props_.compositePriority_:-1;
         var _loc8_:int = !!_loc15_?_loc15_.props_.compositePriority_:-1;
         var _loc2_:int = !!_loc12_?_loc12_.props_.compositePriority_:-1;
         if(_loc16_ < 0 && _loc4_ < 0) {
            _loc11_ = _loc7_.lookupSquare(_loc10_ - 1,_loc13_ - 1);
            _loc5_[0] = _loc11_ == null || _loc11_.props_.compositePriority_ < 0?255:_loc11_.tileType;
         } else if(_loc16_ < _loc4_) {
            _loc5_[0] = _loc14_.tileType;
         } else {
            _loc5_[0] = _loc6_.tileType;
         }
         if(_loc16_ < 0 && _loc8_ < 0) {
            _loc3_ = _loc7_.lookupSquare(_loc10_ + 1,_loc13_ - 1);
            _loc5_[1] = _loc3_ == null || _loc3_.props_.compositePriority_ < 0?255:_loc3_.tileType;
         } else if(_loc16_ < _loc8_) {
            _loc5_[1] = _loc15_.tileType;
         } else {
            _loc5_[1] = _loc6_.tileType;
         }
         if(_loc4_ < 0 && _loc2_ < 0) {
            _loc9_ = _loc7_.lookupSquare(_loc10_ - 1,_loc13_ + 1);
            _loc5_[2] = _loc9_ == null || _loc9_.props_.compositePriority_ < 0?255:_loc9_.tileType;
         } else if(_loc4_ < _loc2_) {
            _loc5_[2] = _loc12_.tileType;
         } else {
            _loc5_[2] = _loc14_.tileType;
         }
         if(_loc8_ < 0 && _loc2_ < 0) {
            _loc17_ = _loc7_.lookupSquare(_loc10_ + 1,_loc13_ + 1);
            _loc5_[3] = _loc17_ == null || _loc17_.props_.compositePriority_ < 0?255:_loc17_.tileType;
         } else if(_loc8_ < _loc2_) {
            _loc5_[3] = _loc12_.tileType;
         } else {
            _loc5_[3] = _loc15_.tileType;
         }
         return _loc5_;
      }
      
      private static function buildComposite(param1:Array) : BitmapData {
         var _loc3_:* = null;
         var _loc2_:BitmapData = new BitmapData(8,8,false,0);
         if(param1[0] != 255) {
            _loc3_ = GroundLibrary.getBitmapData(param1[0]);
            _loc2_.copyPixels(_loc3_,RECT0,POINT0);
         }
         if(param1[1] != 255) {
            _loc3_ = GroundLibrary.getBitmapData(param1[1]);
            _loc2_.copyPixels(_loc3_,RECT1,POINT1);
         }
         if(param1[2] != 255) {
            _loc3_ = GroundLibrary.getBitmapData(param1[2]);
            _loc2_.copyPixels(_loc3_,RECT2,POINT2);
         }
         if(param1[3] != 255) {
            _loc3_ = GroundLibrary.getBitmapData(param1[3]);
            _loc2_.copyPixels(_loc3_,RECT3,POINT3);
         }
         return _loc2_;
      }
      
      private static function getEdgeSig(param1:Square) : Array {
         var _loc8_:* = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc5_:Square = null;
         var _loc11_:* = [];
         var _loc2_:Map = param1.map;
         var _loc10_:Boolean = param1.props_.sameTypeEdgeMode_;
         var _loc3_:int = param1.y_ - 1;
         var _loc9_:int = param1.y_ + 1;
         var _loc12_:int = param1.x_ - 1;
         var _loc4_:int = param1.x_ + 1;
         while(_loc3_ <= _loc9_) {
            _loc8_ = _loc12_;
            while(_loc8_ <= _loc4_) {
               _loc5_ = _loc2_.lookupSquare(_loc8_,_loc3_);
               if(_loc8_ == param1.x_ && _loc3_ == param1.y_) {
                  _loc11_.push(_loc5_.tileType);
               } else {
                  if(_loc10_) {
                     _loc6_ = _loc5_ == null || _loc5_.tileType == param1.tileType;
                  } else {
                     _loc6_ = _loc5_ == null || _loc5_.tileType != 255;
                  }
                  _loc11_.push(_loc6_);
                  _loc7_ = _loc7_ || !_loc6_;
               }
               _loc8_++;
            }
            _loc3_++;
         }
         return !!_loc7_?_loc11_:null;
      }
      
      private static function drawEdges(param1:Array) : BitmapData {
         var _loc2_:BitmapData = GroundLibrary.getBitmapData(param1[4]);
         var _loc4_:BitmapData = _loc2_.clone();
         var _loc3_:GroundProperties = GroundLibrary.propsLibrary_[param1[4]];
         var _loc5_:Vector.<BitmapData> = _loc3_.getEdges();
         var _loc7_:Vector.<BitmapData> = _loc3_.getInnerCorners();
         var _loc6_:int = 1;
         while(_loc6_ < 8) {
            if(!param1[_loc6_]) {
               _loc4_.copyPixels(_loc5_[_loc6_],_loc5_[_loc6_].rect,PointUtil.ORIGIN,null,null,true);
            }
            _loc6_ = _loc6_ + 2;
         }
         if(_loc5_[0]) {
            if(param1[3] && param1[1] && !param1[0]) {
               _loc4_.copyPixels(_loc5_[0],_loc5_[0].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(param1[1] && param1[5] && !param1[2]) {
               _loc4_.copyPixels(_loc5_[2],_loc5_[2].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(param1[5] && param1[7] && !param1[8]) {
               _loc4_.copyPixels(_loc5_[8],_loc5_[8].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(param1[3] && param1[7] && !param1[6]) {
               _loc4_.copyPixels(_loc5_[6],_loc5_[6].rect,PointUtil.ORIGIN,null,null,true);
            }
         }
         if(_loc7_) {
            if(!param1[3] && !param1[1]) {
               _loc4_.copyPixels(_loc7_[0],_loc7_[0].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(!param1[1] && !param1[5]) {
               _loc4_.copyPixels(_loc7_[2],_loc7_[2].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(!param1[5] && !param1[7]) {
               _loc4_.copyPixels(_loc7_[8],_loc7_[8].rect,PointUtil.ORIGIN,null,null,true);
            }
            if(!param1[3] && !param1[7]) {
               _loc4_.copyPixels(_loc7_[6],_loc7_[6].rect,PointUtil.ORIGIN,null,null,true);
            }
         }
         return _loc4_;
      }
   }
}
