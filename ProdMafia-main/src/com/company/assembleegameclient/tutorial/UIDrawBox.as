package com.company.assembleegameclient.tutorial {
   import com.company.util.ConversionUtil;
   import flash.display.Graphics;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class UIDrawBox {
       
      
      public const ANIMATION_MS:int = 500;
      
      public const ORIGIN:Point = new Point(250,200);
      
      public var rect_:Rectangle;
      
      public var color_:uint;
      
      public function UIDrawBox(param1:XML) {
         super();
         this.rect_ = ConversionUtil.toRectangle(param1);
         this.color_ = uint(param1.@color);
      }
      
      public function draw(param1:int, param2:Graphics, param3:int) : void {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = this.rect_.width - param1;
         var _loc7_:Number = this.rect_.height - param1;
         if(param3 < 500) {
            _loc6_ = this.ORIGIN.x + (this.rect_.x - this.ORIGIN.x) * param3 / 500;
            _loc5_ = this.ORIGIN.y + (this.rect_.y - this.ORIGIN.y) * param3 / 500;
            _loc4_ = _loc4_ * (param3 / 500);
            _loc7_ = _loc7_ * (param3 / 500);
         } else {
            _loc6_ = this.rect_.x + param1 / 2;
            _loc5_ = this.rect_.y + param1 / 2;
         }
         param2.lineStyle(param1,this.color_);
         param2.drawRect(_loc6_,_loc5_,_loc4_,_loc7_);
      }
   }
}
