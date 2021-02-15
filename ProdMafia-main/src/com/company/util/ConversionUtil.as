package com.company.util {
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class ConversionUtil {
       
      
      public function ConversionUtil(param1:StaticEnforcer_3938) {
         super();
      }
      
      public static function toIntArray(param1:Object, param2:String = ",") : Array {
         if(param1 == null) {
            return [];
         }
         return param1.toString().split(param2).map(mapParseInt);
      }
      
      public static function toNumberArray(param1:Object, param2:String = ",") : Array {
         if(param1 == null) {
            return [];
         }
         return param1.toString().split(param2).map(mapParseFloat);
      }
      
      public static function toIntVector(param1:Object, param2:String = ",") : Vector.<int> {
         if(param1 == null) {
            return new Vector.<int>();
         }
         return Vector.<int>(param1.toString().split(param2).map(mapParseInt));
      }
      
      public static function toNumberVector(param1:Object, param2:String = ",") : Vector.<Number> {
         if(param1 == null) {
            return new Vector.<Number>();
         }
         return Vector.<Number>(param1.toString().split(param2).map(mapParseFloat));
      }
      
      public static function toStringArray(param1:Object, param2:String = ",") : Array {
         if(param1 == null) {
            return [];
         }
         return param1.toString().split(param2);
      }
      
      public static function toRectangle(param1:Object, param2:String = ",") : Rectangle {
         if(param1 == null) {
            return new Rectangle();
         }
         var _loc3_:Array = param1.toString().split(param2).map(mapParseFloat);
         return _loc3_ == null || _loc3_.length < 4?new Rectangle():new Rectangle(_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3]);
      }
      
      public static function toPoint(param1:Object, param2:String = ",") : Point {
         if(param1 == null) {
            return new Point();
         }
         var _loc3_:Array = param1.toString().split(param2).map(ConversionUtil.mapParseFloat);
         return _loc3_ == null || _loc3_.length < 2?new Point():new Point(_loc3_[0],_loc3_[1]);
      }
      
      public static function toPointPair(param1:Object, param2:String = ",") : Array {
         var _loc4_:* = [];
         if(param1 == null) {
            _loc4_.push(new Point());
            _loc4_.push(new Point());
            return _loc4_;
         }
         var _loc3_:Array = param1.toString().split(param2).map(ConversionUtil.mapParseFloat);
         if(_loc3_ == null || _loc3_.length < 4) {
            _loc4_.push(new Point());
            _loc4_.push(new Point());
            return _loc4_;
         }
         _loc4_.push(new Point(_loc3_[0],_loc3_[1]));
         _loc4_.push(new Point(_loc3_[2],_loc3_[3]));
         return _loc4_;
      }
      
      public static function toVector3D(param1:Object, param2:String = ",") : Vector3D {
         if(param1 == null) {
            return new Vector3D();
         }
         var _loc3_:Array = param1.toString().split(param2).map(ConversionUtil.mapParseFloat);
         return _loc3_ == null || _loc3_.length < 3?new Vector3D():new Vector3D(_loc3_[0],_loc3_[1],_loc3_[2]);
      }
      
      public static function toCharCodesVector(param1:Object, param2:String = ",") : Vector.<int> {
         if(param1 == null) {
            return new Vector.<int>();
         }
         return Vector.<int>(param1.toString().split(param2).map(mapParseCharCode));
      }
      
      public static function addToNumberVector(param1:Object, param2:Vector.<Number>, param3:String = ",") : void {
         var _loc6_:Number = NaN;
         if(param1 == null) {
            return;
         }
         var _loc7_:Array = param1.toString().split(param3).map(mapParseFloat);
         var _loc4_:* = _loc7_;
         var _loc9_:int = 0;
         var _loc8_:* = _loc7_;
         for each(_loc6_ in _loc7_) {
            param2.push(_loc6_);
         }
      }
      
      public static function addToIntVector(param1:Object, param2:Vector.<int>, param3:String = ",") : void {
         var _loc6_:int = 0;
         if(param1 == null) {
            return;
         }
         var _loc7_:Array = param1.toString().split(param3).map(mapParseFloat);
         var _loc4_:* = _loc7_;
         var _loc9_:int = 0;
         var _loc8_:* = _loc7_;
         for each(_loc6_ in _loc7_) {
            param2.push(_loc6_);
         }
      }
      
      public static function mapParseFloat(param1:*, ... rest) : Number {
         return parseFloat(param1);
      }
      
      public static function mapParseInt(param1:*, ... rest) : Number {
         return parseInt(param1);
      }
      
      public static function mapParseCharCode(param1:*, ... rest) : Number {
         return String(param1).charCodeAt();
      }
      
      public static function vector3DToShaderParameter(param1:Vector3D) : Array {
         return [param1.x,param1.y,param1.z];
      }
   }
}

class StaticEnforcer_3938 {
    
   
   function StaticEnforcer_3938() {
      super();
   }
}
