package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import flash.geom.Point;
   
   public class NovaEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var novaRadius_:Number;
      
      public var color_:int;
      
      public function NovaEffect(param1:GameObject, param2:Number, param3:int) {
         super();
         this.start_ = new Point(param1.x_,param1.y_);
         this.novaRadius_ = param2;
         this.color_ = param3;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc9_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc7_:int = 4 + this.novaRadius_ * 2;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_) {
            _loc9_ = _loc8_ * 6.28318530717959 / _loc7_;
            _loc4_ = new Point(this.start_.x + this.novaRadius_ * Math.cos(_loc9_),this.start_.y + this.novaRadius_ * Math.sin(_loc9_));
            _loc5_ = new SparkerParticle(200,this.color_,200,this.start_,_loc4_);
            map_.addObj(_loc5_,x_,y_);
            _loc8_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc9_:Number = NaN;
         var _loc4_:Point = null;
         var _loc5_:Particle = null;
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc7_:int = this.novaRadius_ * 2;
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_) {
            _loc9_ = _loc8_ * 6.28318530717959 / _loc7_;
            _loc4_ = new Point(this.start_.x + this.novaRadius_ * Math.cos(_loc9_),this.start_.y + this.novaRadius_ * Math.sin(_loc9_));
            _loc5_ = new SparkerParticle(10,this.color_,200,this.start_,_loc4_);
            map_.addObj(_loc5_,x_,y_);
            _loc8_++;
         }
         return false;
      }
   }
}
