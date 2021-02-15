package kabam.rotmg.stage3D {
   import flash.display.BitmapData;
   import flash.display.GraphicsBitmapFill;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public class GraphicsFillExtra {
      
      public static const DEFAULT_OFFSET:Vector.<Number> = Vector.<Number>([0,0,0,0]);
      
      private static var textureOffsets:Dictionary = new Dictionary();
      
      private static var textureOffsetsSize:uint = 0;
      
      private static var waterSinks:Dictionary = new Dictionary();
      
      private static var waterSinksSize:uint = 0;
      
      private static var ctMarkers:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private static var colorTransforms:Dictionary = new Dictionary();
      
      private static var colorTransformsSize:uint = 0;
      
      private static var nullTfm:ColorTransform = new ColorTransform();
       
      
      public function GraphicsFillExtra() {
         super();
      }
      
      public static function setColorTransform(param1:BitmapData, param2:ColorTransform) : void {
         if(ctMarkers.indexOf(param1) == -1) {
            colorTransformsSize = Number(colorTransformsSize) + 1;
            ctMarkers.push(param1);
            colorTransforms[param1] = param2;
         }
      }
      
      public static function getColorTransform(param1:BitmapData) : ColorTransform {
         if(ctMarkers.indexOf(param1) != -1) {
            return colorTransforms[param1];
         }
         return nullTfm;
      }
      
      public static function clearColorTransform(param1:BitmapData) : void {
         var _loc2_:int = ctMarkers.indexOf(param1);
         if(_loc2_ != -1) {
            colorTransformsSize = colorTransformsSize - 1;
            ctMarkers.removeAt(_loc2_);
            delete colorTransforms[param1];
         }
      }
      
      public static function setOffsetUV(param1:GraphicsBitmapFill, param2:Number, param3:Number) : void {
         if(textureOffsets[param1] == null) {
            textureOffsetsSize = Number(textureOffsetsSize) + 1;
            textureOffsets[param1] = Vector.<Number>([0,0,0,0]);
         }
         textureOffsets[param1][0] = param2;
         textureOffsets[param1][1] = param3;
      }
      
      public static function getOffsetUV(param1:GraphicsBitmapFill) : Vector.<Number> {
         if(textureOffsets[param1] != null) {
            return textureOffsets[param1];
         }
         return DEFAULT_OFFSET;
      }
      
      public static function setSinkLevel(param1:GraphicsBitmapFill, param2:Number) : void {
         if(waterSinks[param1] == null) {
            waterSinksSize = Number(waterSinksSize) + 1;
         }
         waterSinks[param1] = param2;
      }
      
      public static function getSinkLevel(param1:GraphicsBitmapFill) : Number {
         if(waterSinks[param1] != null) {
            return waterSinks[param1];
         }
         return 0;
      }
      
      public static function clearSink(param1:GraphicsBitmapFill) : void {
         if(waterSinks[param1] != null) {
            waterSinksSize = waterSinksSize - 1;
            delete waterSinks[param1];
         }
      }
      
      public static function dispose() : void {
         textureOffsets = new Dictionary();
         waterSinks = new Dictionary();
         var _loc3_:int = 0;
         var _loc2_:* = ctMarkers;
         for each(var _loc1_ in ctMarkers) {
            _loc1_.dispose();
            _loc1_ = null;
         }
         ctMarkers = new Vector.<BitmapData>();
         colorTransforms = new Dictionary();
         textureOffsetsSize = 0;
         waterSinksSize = 0;
         colorTransformsSize = 0;
      }
      
      public static function manageSize() : void {
         if(colorTransformsSize > 2000) {
            ctMarkers = new Vector.<BitmapData>();
            var _loc3_:int = 0;
            var _loc2_:* = ctMarkers;
            for each(var _loc1_ in ctMarkers) {
               _loc1_.dispose();
               _loc1_ = null;
            }
            colorTransforms = new Dictionary();
            colorTransformsSize = 0;
         }
         if(textureOffsetsSize > 2000) {
            textureOffsets = new Dictionary();
            textureOffsetsSize = 0;
         }
         if(waterSinksSize > 2000) {
            waterSinks = new Dictionary();
            waterSinksSize = 0;
         }
      }
   }
}
