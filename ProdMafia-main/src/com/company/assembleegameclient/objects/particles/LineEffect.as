package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.RandomUtil;
   import flash.geom.Point;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class LineEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var end_:Point;
      
      public var color_:int;
      
      public function LineEffect(param1:GameObject, param2:WorldPosData, param3:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.end_ = new Point(param2.x_,param2.y_);
         this.color_ = param3;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc4_:Point = null;
         var _loc5_:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc6_:int = 0;
         while(_loc6_ < 30) {
            _loc4_ = Point.interpolate(this.start_,this.end_,_loc6_ / 30);
            _loc5_ = new SparkParticle(100,this.color_,700,0.5,RandomUtil.plusMinus(1),RandomUtil.plusMinus(1));
            map_.addObj(_loc5_,_loc4_.x,_loc4_.y);
            _loc6_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc4_:Point = null;
         var _loc5_:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc6_:int = 0;
         while(_loc6_ < 5) {
            _loc4_ = Point.interpolate(this.start_,this.end_,_loc6_ / 5);
            _loc5_ = new SparkParticle(100,this.color_,200,0.5,RandomUtil.plusMinus(1),RandomUtil.plusMinus(1));
            map_.addObj(_loc5_,_loc4_.x,_loc4_.y);
            _loc6_++;
         }
         return false;
      }
   }
}
