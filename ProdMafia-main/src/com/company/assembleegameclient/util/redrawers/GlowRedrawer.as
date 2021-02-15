package com.company.assembleegameclient.util.redrawers {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.PointUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.utils.Dictionary;
   
   public class GlowRedrawer {
      
      private static const GLOW_FILTER:GlowFilter = new GlowFilter(0,0.3,12,12,2,1,false,false);
      
      private static const GLOW_FILTER_ALT:GlowFilter = new GlowFilter(0,0.5,16,16,3,1,false,false);
      
      private static const GLOW_FILTER_SUPPORT:GlowFilter = new GlowFilter(0,0.3,12,12,3,1,false,false);
      
      private static const GLOW_FILTER_SUPPORT_DARK:GlowFilter = new GlowFilter(0,0.4,6,6,2,1,false,false);
      
      private static const GLOW_FILTER_SUPPORT_OUTLINE:GlowFilter = new GlowFilter(0,1,2,2,255,1,false,false);
      
      private static const GLOW_FILTER_SUPPORT_ALT:GlowFilter = new GlowFilter(0,0.3,12,12,4,1,false,false);
      
      private static const GLOW_FILTER_SUPPORT_DARK_ALT:GlowFilter = new GlowFilter(0,0.4,6,6,2,1,false,false);
      
      private static const GLOW_FILTER_SUPPORT_OUTLINE_ALT:GlowFilter = new GlowFilter(0,1,2,2,255,1,false,false);
      
      private static var tempMatrix_:Matrix = new Matrix();
      
      private static var glowHashes:Dictionary = new Dictionary();
       
      
      public function GlowRedrawer() {
         super();
      }
      
      public static function outlineGlow(param1:BitmapData, param2:uint, param3:Number = 1.4, param4:Boolean = false, param5:Boolean = false) : BitmapData {
         if(!param1) {
            return null;
         }
         var _loc6_:String = getHash(param2,param3,param5);
         if(param4 && isCached(param1,_loc6_)) {
            return glowHashes[param1][_loc6_];
         }
         var _loc7_:BitmapData = param1.clone();
         tempMatrix_.identity();
         tempMatrix_.scale(param1.width / 256,param1.height / 256);
         _loc7_.draw(new Bitmap(param1),null,null,"alpha");
         TextureRedrawer.OUTLINE_FILTER.blurX = param3;
         TextureRedrawer.OUTLINE_FILTER.blurY = param3;
         TextureRedrawer.OUTLINE_FILTER.color = 0;
         _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,TextureRedrawer.OUTLINE_FILTER);
         if(!Parameters.data.evenLowerGraphics) {
            if(param2 != 4294967295) {
               if(param2 != 0) {
                  if(!param5) {
                     GLOW_FILTER_ALT.color = param2;
                     _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_ALT);
                  } else {
                     GLOW_FILTER_SUPPORT_ALT.color = param2;
                     GLOW_FILTER_SUPPORT_DARK_ALT.color = param2 - 2385408;
                     GLOW_FILTER_SUPPORT_OUTLINE_ALT.color = param2;
                     _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_SUPPORT_OUTLINE_ALT);
                     _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_SUPPORT_DARK_ALT);
                     _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_SUPPORT_ALT);
                  }
               } else if(!param5) {
                  GLOW_FILTER.color = param2;
                  _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER);
               } else {
                  GLOW_FILTER_SUPPORT.color = param2;
                  GLOW_FILTER_SUPPORT_DARK.color = param2 - 2385408;
                  GLOW_FILTER_SUPPORT_OUTLINE.color = param2;
                  _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_SUPPORT_OUTLINE);
                  _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_SUPPORT_DARK);
                  _loc7_.applyFilter(_loc7_,_loc7_.rect,PointUtil.ORIGIN,GLOW_FILTER_SUPPORT);
               }
            }
         }
         if(param4) {
            cache(param1,param2,param3,param5,_loc7_);
         }
         return _loc7_;
      }
      
      public static function clearCache() : void {
         var _loc6_:int = 0;
         var _loc5_:* = glowHashes;
         for each(var _loc2_ in glowHashes) {
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for each(var _loc1_ in _loc2_) {
               _loc1_.dispose();
               delete _loc2_[_loc1_];
               _loc1_ = null;
            }
            delete glowHashes[_loc2_];
         }
         glowHashes = new Dictionary();
      }
      
      private static function cache(param1:BitmapData, param2:uint, param3:Number, param4:Boolean, param5:BitmapData) : void {
         var _loc6_:* = null;
         var _loc7_:String = getHash(param2,param3,param4);
         if(param1 in glowHashes && _loc7_ in glowHashes[param1]) {
            glowHashes[param1][_loc7_] = param5;
         } else {
            _loc6_ = new Dictionary();
            _loc6_[_loc7_] = param5;
            glowHashes[param1] = _loc6_;
         }
      }
      
      private static function isCached(param1:BitmapData, param2:String) : Boolean {
         return glowHashes[param1] != null && glowHashes[param1][param2] != null;
      }
      
      private static function getHash(param1:uint, param2:Number, param3:Boolean) : String {
         return !!(param2.toString() + param1.toString() + param3)?"1":"0";
      }
   }
}
