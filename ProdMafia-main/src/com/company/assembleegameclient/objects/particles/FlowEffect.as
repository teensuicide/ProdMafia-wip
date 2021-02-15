package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import flash.geom.Point;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class FlowEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var go_:GameObject;
      
      public var color_:int;
      
      public function FlowEffect(param1:WorldPosData, param2:GameObject, param3:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.go_ = param2;
         this.color_ = param3;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc4_:int = 0;
         var _loc5_:Particle = null;
         if(FlowParticle.total_ > 200) {
            return false;
         }
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc6_:int = 0;
         while(_loc6_ < 5) {
            _loc4_ = (3 + int(Math.random() * 5)) * 20;
            _loc5_ = new FlowParticle(0.5,_loc4_,this.color_,this.start_,this.go_);
            map_.addObj(_loc5_,x_,y_);
            _loc6_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc4_:int = 0;
         var _loc5_:Particle = null;
         if(FlowParticle.total_ > 200) {
            return false;
         }
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc6_:int = 0;
         while(_loc6_ < 3) {
            _loc4_ = (3 + int(Math.random() * 5)) * 10;
            _loc5_ = new FlowParticle(0.5,_loc4_,this.color_,this.start_,this.go_);
            map_.addObj(_loc5_,x_,y_);
            _loc6_++;
         }
         return false;
      }
   }
}

import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.particles.Particle;
import flash.geom.Point;

class FlowParticle extends Particle {
   
   public static var total_:int = 0;
    
   
   public var start_:Point;
   
   public var go_:GameObject;
   
   public var maxDist_:Number;
   
   public var flowSpeed_:Number;
   
   function FlowParticle(param1:Number, param2:int, param3:int, param4:Point, param5:GameObject) {
      super(param3,param1,param2);
      this.start_ = param4;
      this.go_ = param5;
      var _loc6_:Point = new Point(x_,y_);
      var _loc7_:Point = new Point(this.go_.x_,this.go_.y_);
      this.maxDist_ = Point.distance(_loc6_,_loc7_);
      this.flowSpeed_ = Math.random() * 5;
      total_ = total_ + 1;
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      var _loc6_:Point = new Point(x_,y_);
      var _loc7_:Point = new Point(this.go_.x_,this.go_.y_);
      var _loc8_:Number = Point.distance(_loc6_,_loc7_);
      if(_loc8_ < 0.5) {
         total_ = total_ - 1;
         return false;
      }
      this.flowSpeed_ = this.flowSpeed_ + 8 * param2 / 1000;
      this.maxDist_ = this.maxDist_ - this.flowSpeed_ * param2 / 1000;
      var _loc9_:Number = _loc8_ - this.flowSpeed_ * param2 / 1000;
      if(_loc9_ > this.maxDist_) {
         _loc9_ = this.maxDist_;
      }
      var _loc4_:Number = this.go_.x_ - x_;
      var _loc5_:Number = this.go_.y_ - y_;
      _loc4_ = _loc4_ * (_loc9_ / _loc8_);
      _loc5_ = _loc5_ * (_loc9_ / _loc8_);
      moveTo(this.go_.x_ - _loc4_,this.go_.y_ - _loc5_);
      return true;
   }
}

import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.particles.Particle;
import flash.geom.Point;

class FlowParticle2 extends Particle {
    
   
   public var start_:Point;
   
   public var go_:GameObject;
   
   public var accel_:Number;
   
   public var dx_:Number;
   
   public var dy_:Number;
   
   function FlowParticle2(param1:Number, param2:int, param3:int, param4:Number, param5:Point, param6:GameObject) {
      super(param3,param1,param2);
      this.start_ = param5;
      this.go_ = param6;
      this.accel_ = param4;
      this.dx_ = Math.random() - 0.5;
      this.dy_ = Math.random() - 0.5;
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      var _loc3_:Point = new Point(x_,y_);
      var _loc5_:Point = new Point(this.go_.x_,this.go_.y_);
      var _loc6_:Number = Point.distance(_loc3_,_loc5_);
      if(_loc6_ < 0.5) {
         return false;
      }
      var _loc7_:Number = Math.atan2(this.go_.y_ - y_,this.go_.x_ - x_);
      this.dx_ = this.dx_ + this.accel_ * Math.cos(_loc7_) * param2 / 1000;
      this.dy_ = this.dy_ + this.accel_ * Math.sin(_loc7_) * param2 / 1000;
      var _loc8_:Number = x_ + this.dx_ * param2 / 1000;
      var _loc4_:Number = y_ + this.dy_ * param2 / 1000;
      moveTo(_loc8_,_loc4_);
      return true;
   }
}
