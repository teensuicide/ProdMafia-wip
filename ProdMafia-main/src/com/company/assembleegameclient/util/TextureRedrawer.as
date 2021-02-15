package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.PointUtil;
   import flash.display.BitmapData;
   import flash.display.Shader;
   import flash.filters.GlowFilter;
   import flash.filters.ShaderFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TextureRedrawer {
      
      public static const magic:int = 12;
      
      public static const minSize:int = 24;
      
      private static const BORDER:int = 4;
      
      public static var OUTLINE_FILTER:GlowFilter = new GlowFilter(0,0.8,1.4,1.4,255,1,false,false);
      
      public static var sharedTexture_:BitmapData = null;
      
      static var rect:Rectangle = new Rectangle();
      
      static var ct:ColorTransform = new ColorTransform();
      
      private static var caches:Dictionary = new Dictionary();
      
      private static var faceCaches:Dictionary = new Dictionary();
      
      private static var redrawCaches:Dictionary = new Dictionary();
      
      private static var textureShaderEmbed_:Class = TextureRedrawer_textureShaderEmbed;
      
      private static var textureShaderData_:ByteArray = new textureShaderEmbed_() as ByteArray;
      
      private static var colorTexture1:BitmapData = new BitmapData(1,1,false,0);
      
      private static var colorTexture2:BitmapData = new BitmapData(1,1,false,0);
       
      
      public function TextureRedrawer() {
         super();
      }
      
      public static function redraw(param1:BitmapData, param2:int, param3:Boolean, param4:uint, param5:Boolean = true, param6:Number = 5, param7:Number = 0, param8:Number = 1.4, param9:Boolean = false, param10:BitmapData = null, param11:int = 0, param12:int = 0) : BitmapData {
         var _loc14_:int = getHash(param2,param3,param4,param6,param8,param11,param12);
         if(param5 && isCached(param1,_loc14_)) {
            return redrawCaches[param1][_loc14_];
         }
         var _loc13_:BitmapData = resize(param1,param10,param2,param3,param11,param12,param6,param9);
         _loc13_ = GlowRedrawer.outlineGlow(_loc13_,param4,param8,param5);
         if(param5) {
            cache(param1,_loc14_,_loc13_);
         }
         return _loc13_;
      }
      
      public static function resize(param1:BitmapData, param2:BitmapData, param3:int, param4:Boolean, param5:int, param6:int, param7:Number = 5, param8:Boolean = false) : BitmapData {
         if(!param1) {
            return null;
         }
         if(param2 && (param5 != 0 || param6 != 0)) {
            param1 = retexture(param1,param2,param5,param6,param8);
            param3 = param3 / 5;
         }
         param5 = param1.width;
         param6 = param1.height;
         var _loc10_:int = param7 * (param3 / 100) * param5;
         var _loc12_:int = param7 * (param3 / 100) * param6;
         var _loc9_:Matrix = new Matrix();
         _loc9_.scale(_loc10_ / param5,_loc12_ / param6);
         _loc9_.translate(12,12);
         var _loc11_:BitmapData = new BitmapData(_loc10_ + 24,_loc12_ + (!!param4?12:1) + 12,true,0);
         _loc11_.draw(param1,_loc9_);
         return _loc11_;
      }
      
      public static function redrawSolidSquare(param1:uint, param2:int, param3:int, param4:int = 0) : BitmapData {
         var _loc5_:uint = ((param2 * 907 + param3) * 911 + param4) * 919 + param1;
         var _loc6_:BitmapData = caches[_loc5_];
         if(_loc6_) {
            return _loc6_;
         }
         _loc6_ = new BitmapData(param2 + 8,param3 + 8,true,0);
         rect.x = 4;
         rect.y = 4;
         rect.width = param2;
         rect.height = param3;
         _loc6_.fillRect(rect,4278190080 | param1);
         if(param4 != -1) {
            _loc6_.applyFilter(_loc6_,_loc6_.rect,PointUtil.ORIGIN,param4 == 0?OUTLINE_FILTER:new GlowFilter(param4,0.8,1.4,1.4,255,1,false,false));
         }
         caches[_loc5_] = _loc6_;
         return _loc6_;
      }
      
      public static function clearCache() : void {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = caches;
         for each(_loc2_ in caches) {
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for each(_loc1_ in _loc2_) {
               _loc1_.dispose();
               delete _loc2_[_loc1_];
               _loc1_ = null;
            }
            delete caches[_loc2_];
         }
         caches = new Dictionary();
         var _loc10_:int = 0;
         var _loc9_:* = faceCaches;
         for each(_loc2_ in faceCaches) {
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_;
            for each(_loc1_ in _loc2_) {
               _loc1_.dispose();
               delete _loc2_[_loc1_];
               _loc1_ = null;
            }
            delete faceCaches[_loc2_];
         }
         faceCaches = new Dictionary();
         var _loc14_:int = 0;
         var _loc13_:* = redrawCaches;
         for each(_loc2_ in redrawCaches) {
            var _loc12_:int = 0;
            var _loc11_:* = _loc2_;
            for each(_loc1_ in _loc2_) {
               _loc1_.dispose();
               delete _loc2_[_loc1_];
               _loc1_ = null;
            }
            delete redrawCaches[_loc2_];
         }
         redrawCaches = new Dictionary();
      }
      
      public static function redrawFace(param1:BitmapData, param2:Number) : BitmapData {
         if(param2 == 1) {
            return param1;
         }
         if(faceCaches[param2] == null) {
            faceCaches[param2] = new Dictionary();
         }
         var _loc3_:BitmapData = faceCaches[param2][param1];
         if(_loc3_) {
            return _loc3_;
         }
         _loc3_ = param1.clone();
         ct.redMultiplier = param2;
         ct.greenMultiplier = param2;
         ct.blueMultiplier = param2;
         _loc3_.colorTransform(_loc3_.rect,ct);
         faceCaches[param2][param1] = _loc3_;
         return _loc3_;
      }
      
      public static function retextureNoSizeChange(param1:BitmapData, param2:BitmapData, param3:int, param4:int) : BitmapData {
         var _loc5_:* = null;
         var _loc6_:Matrix = new Matrix();
         _loc6_.scale(5,5);
         var _loc9_:BitmapData = new BitmapData(param1.width * 5,param1.height * 5,true,0);
         _loc9_.draw(param1,_loc6_);
         var _loc7_:BitmapData = getTexture(param3 >= 0?param3:0,colorTexture1);
         var _loc8_:BitmapData = getTexture(param4 >= 0?param4:0,colorTexture2);
         if(!Parameters.data.evenLowerGraphics) {
            _loc5_ = new Shader(textureShaderData_);
            _loc5_.data.src.input = _loc9_;
            _loc5_.data.mask.input = param2;
            _loc5_.data.texture1.input = _loc7_;
            _loc5_.data.texture2.input = _loc8_;
            _loc5_.data.texture1Size.value = [param3 == 0?0:_loc7_.width];
            _loc5_.data.texture2Size.value = [param4 == 0?0:_loc8_.width];
            _loc9_.applyFilter(_loc9_,_loc9_.rect,PointUtil.ORIGIN,new ShaderFilter(_loc5_));
         }
         return _loc9_;
      }
      
      private static function getHash(param1:int, param2:Boolean, param3:uint, param4:Number, param5:Number, param6:int, param7:int) : int {
         return (!!param2?134217728:0) | param1 * param4 | param3 | param5 | param6 | param7;
      }
      
      private static function cache(param1:BitmapData, param2:int, param3:BitmapData) : void {
         if(!(param1 in redrawCaches)) {
            redrawCaches[param1] = new Dictionary();
         }
         redrawCaches[param1][param2] = param3;
      }
      
      private static function isCached(param1:BitmapData, param2:int) : Boolean {
         return param1 in redrawCaches && param2 in redrawCaches[param1];
      }
      
      private static function getTexture(param1:int, param2:BitmapData) : BitmapData {
         var _loc4_:* = null;
         var _loc3_:* = param1 >> 24 & 255;
         if(_loc3_ == 0) {
            _loc4_ = param2;
         } else if(_loc3_ == 1) {
            param2.setPixel(0,0,param1 & 16777215);
            _loc4_ = param2;
         } else if(_loc3_ == 4) {
            _loc4_ = AssetLibrary.getImageFromSet("textile4x4",param1 & 16777215);
         } else if(_loc3_ == 5) {
            _loc4_ = AssetLibrary.getImageFromSet("textile5x5",param1 & 16777215);
         } else if(_loc3_ == 9) {
            _loc4_ = AssetLibrary.getImageFromSet("textile9x9",param1 & 16777215);
         } else if(_loc3_ == 10) {
            _loc4_ = AssetLibrary.getImageFromSet("textile10x10",param1 & 16777215);
         } else if(_loc3_ == 255) {
            _loc4_ = sharedTexture_;
         } else {
            _loc4_ = param2;
         }
         return _loc4_;
      }
      
      private static function retexture(param1:BitmapData, param2:BitmapData, param3:int, param4:int, param5:Boolean) : BitmapData {
         var _loc6_:* = null;
         var _loc7_:Matrix = new Matrix();
         _loc7_.scale(5,5);
         var _loc10_:BitmapData = new BitmapData(param1.width * 5,param1.height * 5,true,0);
         _loc10_.draw(param1,_loc7_);
         var _loc8_:BitmapData = getTexture(param3 >= 0?param3:0,colorTexture1);
         var _loc9_:BitmapData = getTexture(param4 >= 0?param4:0,colorTexture2);
         if(!Parameters.data.evenLowerGraphics && !param5) {
            _loc6_ = new Shader(textureShaderData_);
            _loc6_.data.src.input = _loc10_;
            _loc6_.data.mask.input = param2;
            _loc6_.data.texture1.input = _loc8_;
            _loc6_.data.texture2.input = _loc9_;
            _loc6_.data.texture1Size.value = [param3 == 0?0:_loc8_.width];
            _loc6_.data.texture2Size.value = [param4 == 0?0:_loc9_.width];
            _loc10_.applyFilter(_loc10_,_loc10_.rect,PointUtil.ORIGIN,new ShaderFilter(_loc6_));
         }
         return _loc10_;
      }
   }
}
