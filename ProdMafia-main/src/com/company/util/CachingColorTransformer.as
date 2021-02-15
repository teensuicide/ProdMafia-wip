package com.company.util {
   import flash.display.BitmapData;
   import flash.filters.BitmapFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class CachingColorTransformer {
      
      private static var texCache:Dictionary = new Dictionary();
      
      private static var baseTfm:ColorTransform = new ColorTransform(1,1,1);
       
      
      public function CachingColorTransformer() {
         super();
      }
      
      public static function transformBitmapData(param1:BitmapData, param2:ColorTransform) : BitmapData {
         var _loc5_:* = null;
         var _loc3_:Dictionary = texCache[param1];
         var _loc4_:uint = ((param2.redMultiplier * 907 + param2.greenMultiplier) * 911 + param2.blueMultiplier) * 919 + param2.alphaMultiplier;
         if(_loc3_) {
            return _loc3_[_loc4_];
         }
         _loc3_ = new Dictionary();
         _loc5_ = param1.clone();
         _loc5_.colorTransform(_loc5_.rect,param2);
         _loc3_[_loc4_] = _loc5_;
         texCache[param1] = _loc3_;
         return _loc5_;
      }
      
      public static function filterBitmapData(param1:BitmapData, param2:BitmapFilter) : BitmapData {
         var _loc4_:* = null;
         var _loc3_:Dictionary = texCache[param1];
         if(_loc3_) {
            return _loc3_[param2];
         }
         _loc3_ = new Dictionary();
         _loc4_ = param1.clone();
         _loc4_.applyFilter(_loc4_,_loc4_.rect,new Point(),param2);
         _loc3_[param2] = _loc4_;
         texCache[param1] = _loc3_;
         return _loc4_;
      }
      
      public static function alphaBitmapData(param1:BitmapData, param2:Number) : BitmapData {
         baseTfm.alphaMultiplier = param2 * 100 * 0.01;
         return transformBitmapData(param1,baseTfm);
      }
      
      public static function clear() : void {
         var _loc6_:int = 0;
         var _loc5_:* = texCache;
         for each(var _loc2_ in texCache) {
            var _loc4_:int = 0;
            var _loc3_:* = _loc2_;
            for each(var _loc1_ in _loc2_) {
               _loc1_.dispose();
            }
         }
         texCache = new Dictionary();
      }
   }
}
