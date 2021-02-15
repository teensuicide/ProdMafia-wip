package com.company.assembleegameclient.ui.menu {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.CachingColorTransformer;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class MenuOption extends Sprite {
      
      protected static const mouseOverCT:ColorTransform = new ColorTransform(1,0.862745098039216,0.52156862745098);
       
      
      protected var origIconBitmapData_:BitmapData;
      
      protected var iconBitmapData_:BitmapData;
      
      protected var icon_:Bitmap;
      
      protected var text_:TextFieldDisplayConcrete;
      
      protected var ct_:ColorTransform = null;
      
      public function MenuOption(param1:BitmapData, param2:uint, param3:String) {
         super();
         this.origIconBitmapData_ = param1;
         this.iconBitmapData_ = TextureRedrawer.redraw(param1,this.redrawSize(),true,0);
         this.icon_ = new Bitmap(this.iconBitmapData_);
         this.icon_.filters = [new DropShadowFilter(0,0,0)];
         this.icon_.x = -12;
         this.icon_.y = -15;
         addChild(this.icon_);
         this.text_ = new TextFieldDisplayConcrete().setSize(18).setColor(param2);
         this.text_.setBold(true);
         this.text_.setStringBuilder(new LineBuilder().setParams(param3));
         this.text_.filters = [new DropShadowFilter(0,0,0)];
         this.text_.x = 20;
         this.text_.y = -6;
         addChild(this.text_);
         addEventListener("mouseOver",this.onMouseOver,false,0,true);
         addEventListener("mouseOut",this.onMouseOut,false,0,true);
      }
      
      public function setColorTransform(param1:ColorTransform) : void {
         if(param1 == this.ct_) {
            return;
         }
         this.ct_ = param1;
         if(this.ct_ == null) {
            this.icon_.bitmapData = this.iconBitmapData_;
            this.text_.transform.colorTransform = MoreColorUtil.identity;
         }
      }
      
      protected function redrawSize() : int {
         return 40 / (this.origIconBitmapData_.width / 8);
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         this.setColorTransform(mouseOverCT);
      }
      
      protected function onMouseOut(param1:MouseEvent) : void {
         this.setColorTransform(null);
      }
   }
}
