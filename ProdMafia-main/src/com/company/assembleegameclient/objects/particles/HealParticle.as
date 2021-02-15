package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.util.MoreColorUtil;
   import flash.geom.Vector3D;
   
   public class HealParticle extends Particle {
       
      
      public var duration_:int;
      
      public var go_:GameObject;
      
      public var angle_:Number;
      
      public var dist_:Number;
      
      public var color1_:uint;
      
      public var color2_:uint;
      
      protected var moveVec_:Vector3D;
      
      private var percentDone:Number;
      
      private var currentLife:int;
      
      public function HealParticle(param1:uint, param2:Number, param3:int, param4:int, param5:Number, param6:GameObject, param7:Number, param8:Number, param9:uint) {
         this.moveVec_ = new Vector3D();
         super(param1,param2,param3);
         this.color1_ = param1;
         this.color2_ = param9;
         this.moveVec_.z = param5;
         this.duration_ = param4;
         this.go_ = param6;
         this.angle_ = param7;
         this.dist_ = param8;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         this.percentDone = this.currentLife / this.duration_;
         setColor(MoreColorUtil.lerpColor(this.color2_,this.color1_,this.percentDone));
         x_ = this.go_.x_ + this.dist_ * Math.cos(this.angle_);
         y_ = this.go_.y_ + this.dist_ * Math.sin(this.angle_);
         z_ = z_ + this.moveVec_.z * param2 * 0.008;
         this.currentLife = this.currentLife + param2;
         return this.percentDone < 1;
      }
   }
}
