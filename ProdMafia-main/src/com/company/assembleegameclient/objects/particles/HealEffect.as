package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   
   public class HealEffect extends ParticleEffect {
       
      
      public var go_:GameObject;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      public function HealEffect(param1:GameObject, param2:uint, param3:uint = 16777215) {
         super();
         this.go_ = param1;
         this.color1_ = param2;
         this.color2_ = uint(param3 == 16777215?this.color1_:uint(param3));
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc6_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc4_:HealParticle = null;
         if(this.go_.map_ == null) {
            return false;
         }
         x_ = this.go_.x_;
         y_ = this.go_.y_;
         var _loc5_:int = 0;
         while(_loc5_ < 10) {
            _loc6_ = 6.28318530717959 * (_loc5_ / 10);
            _loc7_ = (3 + int(Math.random() * 5)) * 20;
            _loc8_ = 0.3 + 0.4 * Math.random();
            _loc4_ = new HealParticle(this.color1_,Math.random() * 0.3,_loc7_,1000,0.1 + Math.random() * 0.1,this.go_,_loc6_,_loc8_,this.color2_);
            map_.addObj(_loc4_,x_ + _loc8_ * Math.cos(_loc6_),y_ + _loc8_ * Math.sin(_loc6_));
            _loc5_++;
         }
         return false;
      }
   }
}
