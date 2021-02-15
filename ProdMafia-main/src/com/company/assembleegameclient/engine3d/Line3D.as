package com.company.assembleegameclient.engine3d {
   import flash.geom.Vector3D;
   
   public class Line3D {
       
      
      public var v0_:Vector3D;
      
      public var v1_:Vector3D;
      
      public function Line3D(param1:Vector3D, param2:Vector3D) {
         super();
         this.v0_ = param1;
         this.v1_ = param2;
      }
      
      public static function unitTest() : Boolean {
         return UnitTest_5202.run();
      }
      
      public function crossZ(param1:Line3D) : int {
         var _loc2_:Number = (param1.v1_.y - param1.v0_.y) * (this.v1_.x - this.v0_.x) - (param1.v1_.x - param1.v0_.x) * (this.v1_.y - this.v0_.y);
         if(_loc2_ < 0.001 && _loc2_ > -0.001) {
            return 0;
         }
         var _loc4_:Number = (param1.v1_.x - param1.v0_.x) * (this.v0_.y - param1.v0_.y) - (param1.v1_.y - param1.v0_.y) * (this.v0_.x - param1.v0_.x);
         var _loc3_:Number = (this.v1_.x - this.v0_.x) * (this.v0_.y - param1.v0_.y) - (this.v1_.y - this.v0_.y) * (this.v0_.x - param1.v0_.x);
         if(_loc4_ < 0.001 && _loc4_ > -0.001 && _loc3_ < 0.001 && _loc3_ > -0.001) {
            return 0;
         }
         var _loc5_:Number = _loc4_ / _loc2_;
         var _loc7_:Number = _loc3_ / _loc2_;
         if(_loc5_ > 1 || _loc5_ < 0 || _loc7_ > 1 || _loc7_ < 0) {
            return 0;
         }
         var _loc6_:Number = this.v0_.z + _loc5_ * (this.v1_.z - this.v0_.z) - (param1.v0_.z + _loc7_ * (param1.v1_.z - param1.v0_.z));
         if(_loc6_ < 0.001 && _loc6_ > -0.001) {
            return 0;
         }
         if(_loc6_ > 0) {
            return 1;
         }
         return 2;
      }
      
      public function lerp(param1:Number) : Vector3D {
         return new Vector3D(this.v0_.x + (this.v1_.x - this.v0_.x) * param1,this.v0_.y + (this.v1_.y - this.v0_.y) * param1,this.v0_.z + (this.v1_.z - this.v0_.z) * param1);
      }
      
      public function toString() : String {
         return "(" + this.v0_ + ", " + this.v1_ + ")";
      }
   }
}

import com.company.assembleegameclient.engine3d.Line3D;
import flash.geom.Vector3D;

class UnitTest_5202 {
    
   
   function UnitTest_5202() {
      super();
   }
   
   public static function run() : Boolean {
      return testCrossZ();
   }
   
   private static function testCrossZ() : Boolean {
      var _loc2_:Line3D = new Line3D(new Vector3D(0,0,0),new Vector3D(0,100,0));
      var _loc1_:Line3D = new Line3D(new Vector3D(10,0,10),new Vector3D(-10,100,-100));
      if(_loc2_.crossZ(_loc1_) != 1) {
         return false;
      }
      if(_loc1_.crossZ(_loc2_) != 2) {
         return false;
      }
      _loc2_ = new Line3D(new Vector3D(1,1,200),new Vector3D(6,6,200));
      _loc1_ = new Line3D(new Vector3D(3,1,-100),new Vector3D(1,3,-100));
      if(_loc2_.crossZ(_loc1_) != 1) {
         return false;
      }
      if(_loc1_.crossZ(_loc2_) != 2) {
         return false;
      }
      return true;
   }
}
