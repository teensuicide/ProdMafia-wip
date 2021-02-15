package com.company.assembleegameclient.tutorial {
   import com.company.util.ConversionUtil;
   import com.company.util.PointUtil;
   import flash.display.Graphics;
   import flash.geom.Point;
   
   public class UIDrawArrow {
       
      
      public const ANIMATION_MS:int = 500;
      
      public var p0_:Point;
      
      public var p1_:Point;
      
      public var color_:uint;
      
      public function UIDrawArrow(param1:XML) {
         super();
         var _loc2_:Array = ConversionUtil.toPointPair(param1);
         this.p0_ = _loc2_[0];
         this.p1_ = _loc2_[1];
         this.color_ = uint(param1.@color);
      }
      
      public function draw(param1:int, param2:Graphics, param3:int) : void {
         var _loc4_:* = null;
         var _loc6_:Point = new Point();
         if(param3 < 500) {
            _loc6_.x = this.p0_.x + (this.p1_.x - this.p0_.x) * param3 / 500;
            _loc6_.y = this.p0_.y + (this.p1_.y - this.p0_.y) * param3 / 500;
         } else {
            _loc6_.x = this.p1_.x;
            _loc6_.y = this.p1_.y;
         }
         param2.lineStyle(param1,this.color_);
         param2.moveTo(this.p0_.x,this.p0_.y);
         param2.lineTo(_loc6_.x,_loc6_.y);
         var _loc5_:Number = PointUtil.angleTo(_loc6_,this.p0_);
         _loc4_ = PointUtil.pointAt(_loc6_,_loc5_ + 0.392699081698724,30);
         param2.lineTo(_loc4_.x,_loc4_.y);
         _loc4_ = PointUtil.pointAt(_loc6_,_loc5_ - 0.392699081698724,30);
         param2.moveTo(_loc6_.x,_loc6_.y);
         param2.lineTo(_loc4_.x,_loc4_.y);
      }
   }
}
