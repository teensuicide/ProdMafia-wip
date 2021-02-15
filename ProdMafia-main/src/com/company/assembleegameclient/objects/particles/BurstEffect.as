package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import flash.geom.Point;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class BurstEffect extends ParticleEffect {
       
      
      public var center_:Point;
      
      public var edgePoint_:Point;
      
      public var color_:int;
      
      public function BurstEffect(param1:GameObject, param2:WorldPosData, param3:WorldPosData, param4:int) {
         super();
         this.center_ = new Point(param2.x_,param2.y_);
         this.edgePoint_ = new Point(param3.x_,param3.y_);
         this.color_ = param4;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc9_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:Particle = null;
         x_ = this.center_.x;
         y_ = this.center_.y;
         var _loc3_:Number = Point.distance(this.center_,this.edgePoint_);
         var _loc8_:int = 0;
         while(_loc8_ < 24) {
            _loc9_ = _loc8_ * 6.28318530717959 / 24;
            _loc4_ = new Point(this.center_.x + _loc3_ * Math.cos(_loc9_),this.center_.y + _loc3_ * Math.sin(_loc9_));
            _loc5_ = new SparkerParticle(100,this.color_,100 + Math.random() * 200,this.center_,_loc4_);
            map_.addObj(_loc5_,x_,y_);
            _loc8_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc9_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:Particle = null;
         x_ = this.center_.x;
         y_ = this.center_.y;
         var _loc3_:Number = Point.distance(this.center_,this.edgePoint_);
         var _loc8_:int = 0;
         while(_loc8_ < 10) {
            _loc9_ = _loc8_ * 6.28318530717959 / 10;
            _loc4_ = new Point(this.center_.x + _loc3_ * Math.cos(_loc9_),this.center_.y + _loc3_ * Math.sin(_loc9_));
            _loc5_ = new SparkerParticle(10,this.color_,50 + Math.random() * 20,this.center_,_loc4_);
            map_.addObj(_loc5_,x_,y_);
            _loc8_++;
         }
         return false;
      }
   }
}
