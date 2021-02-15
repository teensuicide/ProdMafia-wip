package com.company.util {
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class IntPoint {
       
      
      public var x_:int;
      
      public var y_:int;
      
      public function IntPoint(param1:int = 0, param2:int = 0) {
         super();
         this.x_ = param1;
         this.y_ = param2;
      }
      
      public static function unitTest() : void {
         var _loc1_:UnitTest_3632 = new UnitTest_3632();
      }
      
      public static function fromPoint(param1:Point) : IntPoint {
         return new IntPoint(Math.round(param1.x),Math.round(param1.y));
      }
      
      public function x() : int {
         return this.x_;
      }
      
      public function y() : int {
         return this.y_;
      }
      
      public function setX(param1:int) : void {
         this.x_ = param1;
      }
      
      public function setY(param1:int) : void {
         this.y_ = param1;
      }
      
      public function clone() : IntPoint {
         return new IntPoint(this.x_,this.y_);
      }
      
      public function same(param1:IntPoint) : Boolean {
         return this.x_ == param1.x_ && this.y_ == param1.y_;
      }
      
      public function distanceAsInt(param1:IntPoint) : int {
         var _loc2_:int = param1.x_ - this.x_;
         var _loc3_:int = param1.y_ - this.y_;
         return Math.round(Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_));
      }
      
      public function distanceAsNumber(param1:IntPoint) : Number {
         var _loc2_:int = param1.x_ - this.x_;
         var _loc3_:int = param1.y_ - this.y_;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function distanceToPoint(param1:Point) : Number {
         var _loc2_:int = param1.x - this.x_;
         var _loc3_:int = param1.y - this.y_;
         return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
      }
      
      public function trunc1000() : IntPoint {
         return new IntPoint(int(this.x_ / 1000) * 1000,int(this.y_ / 1000) * 1000);
      }
      
      public function round1000() : IntPoint {
         return new IntPoint(Math.round(this.x_ / 1000) * 1000,Math.round(this.y_ / 1000) * 1000);
      }
      
      public function distanceSquared(param1:IntPoint) : int {
         var _loc2_:int = param1.x() - this.x_;
         var _loc3_:int = param1.y() - this.y_;
         return _loc2_ * _loc2_ + _loc3_ * _loc3_;
      }
      
      public function toPoint() : Point {
         return new Point(this.x_,this.y_);
      }
      
      public function transform(param1:Matrix) : IntPoint {
         var _loc2_:Point = param1.transformPoint(this.toPoint());
         return new IntPoint(Math.round(_loc2_.x),Math.round(_loc2_.y));
      }
      
      public function toString() : String {
         return "(" + this.x_ + ", " + this.y_ + ")";
      }
   }
}

import com.company.util.IntPoint;

class UnitTest_3632 {
    
   
   function UnitTest_3632() {
      var _loc3_:* = NaN;
      var _loc2_:* = null;
      var _loc1_:* = null;
      super();
      trace("STARTING UNITTEST: IntPoint");
      _loc2_ = new IntPoint(999,1001);
      _loc1_ = _loc2_.round1000();
      if(_loc1_.x() != 1000 || _loc1_.y() != 1000) {
         trace("ERROR IN UNITTEST: IntPoint1");
      }
      _loc2_ = new IntPoint(500,400);
      _loc1_ = _loc2_.round1000();
      if(_loc1_.x() != 1000 || _loc1_.y() != 0) {
         trace("ERROR IN UNITTEST: IntPoint2");
      }
      _loc2_ = new IntPoint(-400,-500);
      _loc1_ = _loc2_.round1000();
      if(_loc1_.x() != 0 || _loc1_.y() != 0) {
         trace("ERROR IN UNITTEST: IntPoint3");
      }
      _loc2_ = new IntPoint(-501,-999);
      _loc1_ = _loc2_.round1000();
      if(_loc1_.x() != -1000 || _loc1_.y() != -1000) {
         trace("ERROR IN UNITTEST: IntPoint4");
      }
      _loc2_ = new IntPoint(-1000,-1001);
      _loc1_ = _loc2_.round1000();
      if(_loc1_.x() != -1000 || _loc1_.y() != -1000) {
         trace("ERROR IN UNITTEST: IntPoint5");
      }
      _loc2_ = new IntPoint(999,1001);
      _loc1_ = _loc2_.trunc1000();
      if(_loc1_.x() != 0 || _loc1_.y() != 1000) {
         trace("ERROR IN UNITTEST: IntPoint6");
      }
      _loc2_ = new IntPoint(500,400);
      _loc1_ = _loc2_.trunc1000();
      if(_loc1_.x() != 0 || _loc1_.y() != 0) {
         trace("ERROR IN UNITTEST: IntPoint7");
      }
      _loc2_ = new IntPoint(-400,-500);
      _loc1_ = _loc2_.trunc1000();
      if(_loc1_.x() != 0 || _loc1_.y() != 0) {
         trace("ERROR IN UNITTEST: IntPoint8");
      }
      _loc2_ = new IntPoint(-501,-999);
      _loc1_ = _loc2_.trunc1000();
      if(_loc1_.x() != 0 || _loc1_.y() != 0) {
         trace("ERROR IN UNITTEST: IntPoint9");
      }
      _loc2_ = new IntPoint(-1000,-1001);
      _loc1_ = _loc2_.trunc1000();
      if(_loc1_.x() != -1000 || _loc1_.y() != -1000) {
         trace("ERROR IN UNITTEST: IntPoint10");
      }
      _loc3_ = 0.9999998;
      if(_loc3_ != 0) {
         trace("ERROR IN UNITTEST: IntPoint40");
      }
      _loc3_ = 0.5;
      if(_loc3_ != 0) {
         trace("ERROR IN UNITTEST: IntPoint41");
      }
      _loc3_ = 0.499999;
      if(_loc3_ != 0) {
         trace("ERROR IN UNITTEST: IntPoint42");
      }
      _loc3_ = -0.499999;
      if(_loc3_ != 0) {
         trace("ERROR IN UNITTEST: IntPoint43");
      }
      _loc3_ = -0.5;
      if(_loc3_ != 0) {
         trace("ERROR IN UNITTEST: IntPoint44");
      }
      _loc3_ = -0.99999;
      if(_loc3_ != 0) {
         trace("ERROR IN UNITTEST: IntPoint45");
      }
   }
}
