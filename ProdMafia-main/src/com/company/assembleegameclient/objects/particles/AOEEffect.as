package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.geom.Point;
   
   public class AOEEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var novaRadius_:Number;
      
      public var color_:int;
      
      public function AOEEffect(param1:Point, param2:Number, param3:int) {
         super();
         this.start_ = param1;
         this.novaRadius_ = param2;
         this.color_ = param3;
      }
      
      override public function runNormalRendering(param1:int, param2:int) : Boolean {
         var _loc9_:int = 0;
         _loc9_ = 40;
         var _loc7_:int = 0;
         _loc7_ = 200;
         var _loc4_:Number = NaN;
         var _loc3_:Point = null;
         var _loc6_:Particle = null;
         if(this.color_ == -1) {
            return false;
         }
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc8_:int = 4 + this.novaRadius_ * 2;
         var _loc5_:int = 0;
         while(_loc5_ < _loc8_) {
            _loc4_ = _loc5_ * 6.28318530717959 / _loc8_;
            _loc3_ = new Point(this.start_.x + this.novaRadius_ * Math.cos(_loc4_),this.start_.y + this.novaRadius_ * Math.sin(_loc4_));
            _loc6_ = new SparkerParticle(40,this.color_,200,this.start_,_loc3_);
            map_.addObj(_loc6_,x_,y_);
            _loc5_++;
         }
         return false;
      }
      
      override public function runEasyRendering(param1:int, param2:int) : Boolean {
         var _loc9_:int = 0;
         _loc9_ = 200;
         var _loc7_:int = 0;
         _loc7_ = 200;
         var _loc4_:Number = NaN;
         var _loc3_:Point = null;
         var _loc6_:Particle = null;
         if(this.color_ == -1) {
            return false;
         }
         x_ = this.start_.x;
         y_ = this.start_.y;
         var _loc8_:int = 4 + this.novaRadius_ * (!!Parameters.data.liteParticle?1:2);
         var _loc5_:int = 0;
         while(_loc5_ < _loc8_) {
            _loc4_ = _loc5_ * 6.28318530717959 / _loc8_;
            _loc3_ = new Point(this.start_.x + this.novaRadius_ * Math.cos(_loc4_),this.start_.y + this.novaRadius_ * Math.sin(_loc4_));
            _loc6_ = new SparkerParticle(200,this.color_,200,this.start_,_loc3_);
            map_.addObj(_loc6_,x_,y_);
            _loc5_++;
         }
         return false;
      }
   }
}
