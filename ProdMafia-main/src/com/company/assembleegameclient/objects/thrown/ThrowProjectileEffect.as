package com.company.assembleegameclient.objects.thrown {
   import com.company.assembleegameclient.objects.particles.ParticleEffect;
   import flash.geom.Point;
   
   public class ThrowProjectileEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var end_:Point;
      
      public var id_:uint;
      
      public var duration_:int;
      
      public function ThrowProjectileEffect(param1:int, param2:Point, param3:Point, param4:int = 1500) {
         super();
         this.start_ = param2;
         this.end_ = param3;
         this.id_ = param1;
         this.duration_ = param4;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc3_:ThrownProjectile = new ThrownProjectile(this.id_,this.duration_,this.start_,this.end_);
         map_.addObj(_loc3_,x_,y_);
         return false;
      }
   }
}
