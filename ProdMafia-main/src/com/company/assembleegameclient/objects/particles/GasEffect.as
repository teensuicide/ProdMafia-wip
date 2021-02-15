package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.util.RandomUtil;
   
   public class GasEffect extends ParticleEffect {
       
      
      public var go_:GameObject;
      
      public var props:EffectProperties;
      
      public var color_:int;
      
      public var rate:Number;
      
      public var type:String;
      
      public function GasEffect(param1:GameObject, param2:EffectProperties) {
         super();
         this.go_ = param1;
         this.color_ = param2.color;
         this.rate = param2.rate;
         this.props = param2;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:* = null;
         if(this.go_.map_ == null) {
            return false;
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         var _loc7_:int = 0;
         while(_loc7_ < this.rate) {
            _loc8_ = (Math.random() + 0.3) * 200;
            _loc9_ = Math.random();
            _loc10_ = RandomUtil.plusMinus(this.props.speed - this.props.speed * (_loc9_ * (1 - this.props.speedVariance)));
            _loc5_ = RandomUtil.plusMinus(this.props.speed - this.props.speed * (_loc9_ * (1 - this.props.speedVariance)));
            _loc3_ = this.props.life * 1000 - this.props.life * 1000 * (_loc9_ * this.props.lifeVariance);
            _loc6_ = new GasParticle(_loc8_,this.color_,_loc3_,this.props.spread,0.75,_loc10_,_loc5_);
            map_.addObj(_loc6_,x_,y_);
            _loc7_++;
         }
         return true;
      }
   }
}
