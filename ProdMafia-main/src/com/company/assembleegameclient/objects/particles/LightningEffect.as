package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.RandomUtil;
   import flash.geom.Point;
   import kabam.rotmg.messaging.impl.data.WorldPosData;
   
   public class LightningEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var end_:Point;
      
      public var color_:int;
      
      public var particleSize_:int;
      
      public var lifetimeMultiplier_:Number;
      
      public function LightningEffect(param1:GameObject, param2:WorldPosData, param3:int, param4:int, param5:Number = 1.0) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.end_ = new Point(param2.x_,param2.y_);
         this.color_ = param3;
         this.particleSize_ = param4;
         this.lifetimeMultiplier_ = param5;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc4_:Number = NaN;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc3_:Number = Point.distance(this.start_,this.end_);
         var _loc5_:int = _loc3_ * 3;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_) {
            _loc7_ = Point.interpolate(this.start_,this.end_,_loc6_ / _loc5_);
            _loc8_ = new SparkParticle(this.particleSize_,this.color_,1000 * this.lifetimeMultiplier_ - _loc6_ / _loc5_ * 15 * 60 * this.lifetimeMultiplier_,0.5,0,0);
            _loc4_ = Math.min(_loc6_,_loc5_ - _loc6_);
            map_.addObj(_loc8_,_loc7_.x + RandomUtil.plusMinus(_loc3_ / 200 * _loc4_),_loc7_.y + RandomUtil.plusMinus(_loc3_ / 200 * _loc4_));
            _loc6_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc7_:Point = null;
         var _loc8_:Particle = null;
         var _loc4_:Number = NaN;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc3_:Number = Point.distance(this.start_,this.end_);
         var _loc5_:int = _loc3_ * 2;
         this.particleSize_ = 80;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_) {
            _loc7_ = Point.interpolate(this.start_,this.end_,_loc6_ / _loc5_);
            _loc8_ = new SparkParticle(this.particleSize_,this.color_,750 * this.lifetimeMultiplier_ - _loc6_ / _loc5_ * 675 * this.lifetimeMultiplier_,0.5,0,0);
            _loc4_ = Math.min(_loc6_,_loc5_ - _loc6_);
            map_.addObj(_loc8_,_loc7_.x + RandomUtil.plusMinus(_loc3_ / 200 * _loc4_),_loc7_.y + RandomUtil.plusMinus(_loc3_ / 200 * _loc4_));
            _loc6_++;
         }
         return false;
      }
   }
}
