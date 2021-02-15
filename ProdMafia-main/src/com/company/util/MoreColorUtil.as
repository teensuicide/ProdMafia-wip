package com.company.util {
   import flash.geom.ColorTransform;
   
   public class MoreColorUtil {
      
      public static const greyscaleFilterMatrix:Array = [0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0];
      
      public static const redFilterMatrix:Array = [0.3,0.59,0.11,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0];
      
      public static const identity:ColorTransform = new ColorTransform();
      
      public static const invisible:ColorTransform = new ColorTransform(1,1,1,0,0,0,0,0);
      
      public static const transparentCT:ColorTransform = new ColorTransform(1,1,1,0.3,0,0,0,0);
      
      public static const slightlyTransparentCT:ColorTransform = new ColorTransform(1,1,1,0.7,0,0,0,0);
      
      public static const greenCT:ColorTransform = new ColorTransform(0.6,1,0.6,1,0,0,0,0);
      
      public static const lightGreenCT:ColorTransform = new ColorTransform(0.8,1,0.8,1,0,0,0,0);
      
      public static const veryGreenCT:ColorTransform = new ColorTransform(0.2,1,0.2,1,0,100,0,0);
      
      public static const transparentGreenCT:ColorTransform = new ColorTransform(0.5,1,0.5,0.3,0,0,0,0);
      
      public static const transparentVeryGreenCT:ColorTransform = new ColorTransform(0.3,1,0.3,0.5,0,0,0,0);
      
      public static const redCT:ColorTransform = new ColorTransform(1,0.5,0.5,1,0,0,0,0);
      
      public static const lightRedCT:ColorTransform = new ColorTransform(1,0.7,0.7,1,0,0,0,0);
      
      public static const veryRedCT:ColorTransform = new ColorTransform(1,0.2,0.2,1,100,0,0,0);
      
      public static const transparentRedCT:ColorTransform = new ColorTransform(1,0.5,0.5,0.3,0,0,0,0);
      
      public static const transparentVeryRedCT:ColorTransform = new ColorTransform(1,0.3,0.3,0.5,0,0,0,0);
      
      public static const blueCT:ColorTransform = new ColorTransform(0.5,0.5,1,1,0,0,0,0);
      
      public static const lightBlueCT:ColorTransform = new ColorTransform(0.7,0.7,1,1,0,0,100,0);
      
      public static const veryBlueCT:ColorTransform = new ColorTransform(0.3,0.3,1,1,0,0,100,0);
      
      public static const transparentBlueCT:ColorTransform = new ColorTransform(0.5,0.5,1,0.3,0,0,0,0);
      
      public static const transparentVeryBlueCT:ColorTransform = new ColorTransform(0.3,0.3,1,0.5,0,0,0,0);
      
      public static const purpleCT:ColorTransform = new ColorTransform(1,0.5,1,1,0,0,0,0);
      
      public static const veryPurpleCT:ColorTransform = new ColorTransform(1,0.2,1,1,100,0,100,0);
      
      public static const darkCT:ColorTransform = new ColorTransform(0.6,0.6,0.6,1,0,0,0,0);
      
      public static const veryDarkCT:ColorTransform = new ColorTransform(0.4,0.4,0.4,1,0,0,0,0);
      
      public static const makeWhiteCT:ColorTransform = new ColorTransform(1,1,1,1,255,255,255,0);
       
      
      public function MoreColorUtil(param1:StaticEnforcer_3719) {
         super();
      }
      
      public static function hsvToRgb(param1:Number, param2:Number, param3:Number) : int {
         var _loc10_:* = NaN;
         var _loc7_:* = NaN;
         var _loc9_:* = NaN;
         var _loc5_:int = int(param1 / 60) % 6;
         var _loc4_:Number = param1 / 60 - Math.floor(param1 / 60);
         var _loc6_:Number = param3 * (1 - param2);
         var _loc8_:Number = param3 * (1 - _loc4_ * param2);
         var _loc11_:Number = param3 * (1 - (1 - _loc4_) * param2);
         switch(int(_loc5_)) {
            case 0:
               _loc10_ = param3;
               _loc7_ = _loc11_;
               _loc9_ = _loc6_;
               break;
            case 1:
               _loc10_ = _loc8_;
               _loc7_ = param3;
               _loc9_ = _loc6_;
               break;
            case 2:
               _loc10_ = _loc6_;
               _loc7_ = param3;
               _loc9_ = _loc11_;
               break;
            case 3:
               _loc10_ = _loc6_;
               _loc7_ = _loc8_;
               _loc9_ = param3;
               break;
            case 4:
               _loc10_ = _loc11_;
               _loc7_ = _loc6_;
               _loc9_ = param3;
               break;
            case 5:
               _loc10_ = param3;
               _loc7_ = _loc6_;
               _loc9_ = _loc8_;
         }
         return Math.min(255,Math.floor(_loc10_ * 255)) << 16 | Math.min(255,Math.floor(_loc7_ * 255)) << 8 | Math.min(255,Math.floor(_loc9_ * 255));
      }
      
      public static function randomColor() : uint {
         return uint(16777215 * Math.random());
      }
      
      public static function randomColor32() : uint {
         return uint(16777215 * Math.random()) | 4278190080;
      }
      
      public static function transformColor(param1:ColorTransform, param2:uint) : uint {
         var _loc5_:int = ((param2 & 16711680) >> 16) * param1.redMultiplier + param1.redOffset;
         _loc5_ = _loc5_ < 0?0:_loc5_ > 255?255:_loc5_;
         var _loc4_:int = ((param2 & 65280) >> 8) * param1.greenMultiplier + param1.greenOffset;
         _loc4_ = _loc4_ < 0?0:_loc4_ > 255?255:_loc4_;
         var _loc3_:int = (param2 & 255) * param1.blueMultiplier + param1.blueOffset;
         _loc3_ = _loc3_ < 0?0:_loc3_ > 255?255:_loc3_;
         return _loc5_ << 16 | _loc4_ << 8 | _loc3_;
      }
      
      public static function copyColorTransform(param1:ColorTransform) : ColorTransform {
         return new ColorTransform(param1.redMultiplier,param1.greenMultiplier,param1.blueMultiplier,param1.alphaMultiplier,param1.redOffset,param1.greenOffset,param1.blueOffset,param1.alphaOffset);
      }
      
      public static function lerpColorTransform(param1:ColorTransform, param2:ColorTransform, param3:Number) : ColorTransform {
         if(param1 == null) {
            param1 = identity;
         }
         if(param2 == null) {
            param2 = identity;
         }
         var _loc5_:Number = 1 - param3;
         var _loc4_:ColorTransform = new ColorTransform(param1.redMultiplier * _loc5_ + param2.redMultiplier * param3,param1.greenMultiplier * _loc5_ + param2.greenMultiplier * param3,param1.blueMultiplier * _loc5_ + param2.blueMultiplier * param3,param1.alphaMultiplier * _loc5_ + param2.alphaMultiplier * param3,param1.redOffset * _loc5_ + param2.redOffset * param3,param1.greenOffset * _loc5_ + param2.greenOffset * param3,param1.blueOffset * _loc5_ + param2.blueOffset * param3,param1.alphaOffset * _loc5_ + param2.alphaOffset * param3);
         return _loc4_;
      }
      
      public static function lerpColor(param1:uint, param2:uint, param3:Number) : uint {
         var _loc11_:Number = 1 - param3;
         var _loc9_:uint = param1 >> 24 & 255;
         var _loc4_:uint = param1 >> 16 & 255;
         var _loc7_:uint = param1 >> 8 & 255;
         var _loc5_:uint = param1 & 255;
         var _loc17_:uint = param2 >> 24 & 255;
         var _loc13_:uint = param2 >> 16 & 255;
         var _loc12_:uint = param2 >> 8 & 255;
         var _loc6_:uint = param2 & 255;
         var _loc8_:uint = _loc9_ * _loc11_ + _loc17_ * param3;
         var _loc10_:uint = _loc4_ * _loc11_ + _loc13_ * param3;
         var _loc15_:uint = _loc7_ * _loc11_ + _loc12_ * param3;
         var _loc14_:uint = _loc5_ * _loc11_ + _loc6_ * param3;
         var _loc16_:uint = _loc8_ << 24 | _loc10_ << 16 | _loc15_ << 8 | _loc14_;
         return _loc16_;
      }
      
      public static function transformAlpha(param1:ColorTransform, param2:Number) : Number {
         var _loc4_:uint = param2 * 255;
         var _loc3_:uint = _loc4_ * param1.alphaMultiplier + param1.alphaOffset;
         _loc3_ = _loc3_ < 0?0:_loc3_ > 255?255:_loc3_;
         return _loc3_ / 255;
      }
      
      public static function multiplyColor(param1:uint, param2:Number) : uint {
         var _loc5_:int = ((param1 & 16711680) >> 16) * param2;
         _loc5_ = _loc5_ < 0?0:_loc5_ > 255?255:_loc5_;
         var _loc4_:int = ((param1 & 65280) >> 8) * param2;
         _loc4_ = _loc4_ < 0?0:_loc4_ > 255?255:_loc4_;
         var _loc3_:int = (param1 & 255) * param2;
         _loc3_ = _loc3_ < 0?0:_loc3_ > 255?255:_loc3_;
         return _loc5_ << 16 | _loc4_ << 8 | _loc3_;
      }
      
      public static function adjustBrightness(param1:uint, param2:Number) : uint {
         var _loc4_:uint = param1 & 4278190080;
         var _loc5_:int = ((param1 & 16711680) >> 16) + param2 * 255;
         _loc5_ = _loc5_ < 0?0:_loc5_ > 255?255:_loc5_;
         var _loc3_:int = ((param1 & 65280) >> 8) + param2 * 255;
         _loc3_ = _loc3_ < 0?0:_loc3_ > 255?255:_loc3_;
         var _loc6_:int = (param1 & 255) + param2 * 255;
         _loc6_ = _loc6_ < 0?0:_loc6_ > 255?255:_loc6_;
         return _loc4_ | _loc5_ << 16 | _loc3_ << 8 | _loc6_;
      }
      
      public static function colorToShaderParameter(param1:uint) : Array {
         var _loc2_:Number = (param1 >> 24 & 255) / 256;
         return [_loc2_ * ((param1 >> 16 & 255) / 256),_loc2_ * ((param1 >> 8 & 255) / 256),_loc2_ * ((param1 & 255) / 256),_loc2_];
      }
      
      public static function singleColorFilterMatrix(param1:uint) : Array {
         return [0,0,0,0,(param1 & 16711680) >> 16,0,0,0,0,(param1 & 65280) >> 8,0,0,0,0,param1 & 255,0,0,0,1,0];
      }
   }
}

class StaticEnforcer_3719 {
    
   
   function StaticEnforcer_3719() {
      super();
   }
}
