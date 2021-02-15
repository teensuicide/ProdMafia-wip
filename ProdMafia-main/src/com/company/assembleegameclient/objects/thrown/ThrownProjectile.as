package com.company.assembleegameclient.objects.thrown {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class ThrownProjectile extends BitmapParticle {
       
      
      public var lifetime_:int;
      
      public var timeLeft_:int;
      
      public var start_:Point;
      
      public var end_:Point;
      
      public var dx_:Number;
      
      public var dy_:Number;
      
      public var pathX_:Number;
      
      public var pathY_:Number;
      
      private var bitmapData:BitmapData;
      
      public function ThrownProjectile(param1:uint, param2:int, param3:Point, param4:Point) {
         this.bitmapData = ObjectLibrary.getTextureFromType(param1);
         if (this.bitmapData)
            this.bitmapData = TextureRedrawer.redraw(this.bitmapData,ObjectLibrary.propsLibrary_[param1].minSize_,true,0,false);
         _rotationDelta = 0.2;
         super(this.bitmapData,0);
         var _loc5_:* = param2;
         this.timeLeft_ = _loc5_;
         this.lifetime_ = _loc5_;
         this.start_ = param3;
         this.end_ = param4;
         this.dx_ = (this.end_.x - this.start_.x) / this.timeLeft_;
         this.dy_ = (this.end_.y - this.start_.y) / this.timeLeft_;
         x_ = this.start_.x;
         this.pathX_ = this.start_.x;
         y_ = this.start_.y;
         this.pathY_ = this.start_.y;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         if (!this.bitmapData)
            return false;

         this.timeLeft_ = this.timeLeft_ - param2;
         if(this.timeLeft_ <= 0) {
            return false;
         }
         z_ = Math.sin(this.timeLeft_ / this.lifetime_ * 3.14159265358979) * 2;
         setSize(z_);
         this.pathX_ = this.pathX_ + this.dx_ * param2;
         this.pathY_ = this.pathY_ + this.dy_ * param2;
         moveTo(this.pathX_,this.pathY_);
         return true;
      }
   }
}
