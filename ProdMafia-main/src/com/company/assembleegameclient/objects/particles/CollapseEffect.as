package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import flash.geom.Point;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class CollapseEffect extends ParticleEffect {
       
      
      public var center_:Point;
      
      public var edgePoint_:Point;
      
      public var color_:int;
      
      public function CollapseEffect(param1:GameObject, param2:WorldPosData, param3:WorldPosData, param4:int) {
         super();
         this.center_ = new Point(param2.x_,param2.y_);
         this.edgePoint_ = new Point(param3.x_,param3.y_);
         this.color_ = param4;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc5_:Number = NaN;
         var _loc3_:Point = null;
         var _loc6_:Particle = null;
         x_ = this.center_.x;
         y_ = this.center_.y;
         var _loc4_:Number = Point.distance(this.center_,this.edgePoint_);
         var _loc10_:int = 0;
         while(_loc10_ < 24) {
            _loc5_ = _loc10_ * 6.28318530717959 / 24;
            _loc3_ = new Point(this.center_.x + _loc4_ * Math.cos(_loc5_),this.center_.y + _loc4_ * Math.sin(_loc5_));
            _loc6_ = new SparkerParticle(300,this.color_,200,_loc3_,this.center_);
            map_.addObj(_loc6_,x_,y_);
            _loc10_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc5_:Number = NaN;
         var _loc3_:Point = null;
         var _loc6_:Particle = null;
         x_ = this.center_.x;
         y_ = this.center_.y;
         var _loc4_:Number = Point.distance(this.center_,this.edgePoint_);
         var _loc10_:int = 0;
         while(_loc10_ < 8) {
            _loc5_ = _loc10_ * 6.28318530717959 / 8;
            _loc3_ = new Point(this.center_.x + _loc4_ * Math.cos(_loc5_),this.center_.y + _loc4_ * Math.sin(_loc5_));
            _loc6_ = new SparkerParticle(50,this.color_,150,_loc3_,this.center_);
            map_.addObj(_loc6_,x_,y_);
            _loc10_++;
         }
         return false;
      }
   }
}
