package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.ColorUtil;
   import flash.geom.Point;
   
   public class SnowflakeEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var color1_:int;
      
      public var color2_:int;
      
      public var minRad_:Number;
      
      public var maxRad_:Number;
      
      public var maxLife_:int;
      
      public function SnowflakeEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.color1_ = param2.color;
         this.color2_ = param2.color2;
         this.minRad_ = param2.minRadius;
         this.maxRad_ = param2.maxRadius;
         this.maxLife_ = param2.life * 1000;
         size_ = param2.size;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         return this.run(param1,param2,6);
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         return this.run(param1,param2,6);
      }
      
      private function run(param1:int, param2:int, param3:int) : Boolean {
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc4_:Particle = null;
         var _loc5_:Number = this.minRad_ + Math.random() * (this.maxRad_ - this.minRad_);
         var _loc6_:int = 0;
         while(_loc6_ < param3) {
            _loc7_ = ColorUtil.rangeRandomSmart(this.color1_,this.color2_);
            _loc8_ = _loc6_ * 2 * 3.14159265358979 / param3;
            _loc4_ = new SnowflakeParticle(size_,_loc7_,this.maxLife_,_loc8_,_loc5_,true);
            map_.addObj(_loc4_,x_,y_);
            _loc6_++;
         }
         return false;
      }
   }
}

import com.company.assembleegameclient.objects.particles.Particle;
import com.company.assembleegameclient.objects.particles.SparkParticle;
import com.company.assembleegameclient.util.RandomUtil;

class SnowflakeParticle extends Particle {
    
   
   private var timeLeft_:int;
   
   private var angle_:Number;
   
   private var radius_:Number;
   
   private var dx_:Number;
   
   private var dy_:Number;
   
   private var split_:Boolean;
   
   private var timeSplit_:int;
   
   function SnowflakeParticle(param1:int, param2:int, param3:int, param4:Number, param5:Number, param6:Boolean = false) {
      super(param2,0,param1);
      this.timeLeft_ = param3;
      this.timeSplit_ = this.timeLeft_ * 0.5;
      this.angle_ = param4;
      this.radius_ = param5;
      this.dx_ = param5 * Math.cos(param4) / this.timeLeft_;
      this.dy_ = param5 * Math.sin(param4) / this.timeLeft_;
      this.split_ = param6;
   }
   
   override public function update(param1:int, param2:int) : Boolean {
      this.timeLeft_ = this.timeLeft_ - param2;
      if(this.timeLeft_ <= 0) {
         return false;
      }
      moveTo(x_ + this.dx_ * param2,y_ + this.dy_ * param2);
      if(this.split_ && this.timeLeft_ < this.timeSplit_) {
         map_.addObj(new SnowflakeParticle(size_,color_,this.timeLeft_,this.angle_ + 1.0471975511966,this.radius_ * 0.5),x_,y_);
         map_.addObj(new SnowflakeParticle(size_,color_,this.timeLeft_,this.angle_ - 1.0471975511966,this.radius_ * 0.5),x_,y_);
         this.split_ = false;
      }
      map_.addObj(new SparkParticle(100 * (z_ + 1),color_,600,z_,RandomUtil.plusMinus(1),RandomUtil.plusMinus(1)),x_,y_);
      return true;
   }
}
