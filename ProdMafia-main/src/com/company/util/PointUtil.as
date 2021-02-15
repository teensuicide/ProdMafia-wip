package com.company.util {
   import flash.geom.Point;
   
   public class PointUtil {
      
      public static const ORIGIN:Point = new Point(0,0);
       
      
      public function PointUtil(param1:StaticEnforcer_3811) {
         super();
      }
      
      public static function roundPoint(param1:Point) : Point {
         var _loc2_:Point = param1.clone();
         _loc2_.x = Math.round(_loc2_.x);
         _loc2_.y = Math.round(_loc2_.y);
         return _loc2_;
      }
      
      public static function distanceSquared(param1:Point, param2:Point) : Number {
         return distanceSquaredXY(param1.x,param1.y,param2.x,param2.y);
      }
      
      public static function distanceSquaredXY(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         var _loc6_:Number = param3 - param1;
         var _loc5_:Number = param4 - param2;
         return _loc6_ * _loc6_ + _loc5_ * _loc5_;
      }
      
      public static function distanceXY(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         var _loc6_:Number = param3 - param1;
         var _loc5_:Number = param4 - param2;
         return Math.sqrt(_loc6_ * _loc6_ + _loc5_ * _loc5_);
      }
      
      public static function lerpXY(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Point {
         return new Point(param1 + (param3 - param1) * param5,param2 + (param4 - param2) * param5);
      }
      
      public static function angleTo(param1:Point, param2:Point) : Number {
         return Math.atan2(param2.y - param1.y,param2.x - param1.x);
      }
      
      public static function pointAt(param1:Point, param2:Number, param3:Number) : Point {
         var _loc4_:Point = new Point();
         _loc4_.x = param1.x + param3 * Math.cos(param2);
         _loc4_.y = param1.y + param3 * Math.sin(param2);
         return _loc4_;
      }
   }
}

class StaticEnforcer_3811 {
    
   
   function StaticEnforcer_3811() {
      super();
   }
}
