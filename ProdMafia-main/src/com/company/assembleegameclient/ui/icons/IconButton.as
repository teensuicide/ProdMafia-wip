package com.company.assembleegameclient.ui.icons {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.KeyCodes;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   
   public class IconButton extends Sprite implements TooltipAble {
      
      protected static const mouseOverCT:ColorTransform = new ColorTransform(1,0.862745098039216,0.52156862745098);
      
      protected static const disableCT:ColorTransform = new ColorTransform(0.6,0.6,0.6,1);
       
      
      public var hoverTooltipDelegate:HoverTooltipDelegate;
      
      protected var origIconBitmapData_:BitmapData;
      
      protected var iconBitmapData_:BitmapData;
      
      protected var icon_:Bitmap;
      
      protected var label_:TextFieldDisplayConcrete;
      
      protected var hotkeyName_:String;
      
      protected var ct_:ColorTransform = null;
      
      private var toolTip_:TextToolTip = null;
      
      public function IconButton(param1:BitmapData, param2:String, param3:String, param4:String = "", param5:int = 0, noRedraw:Boolean = false) {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         super();
         this.origIconBitmapData_ = param1;
         this.iconBitmapData_ = this.origIconBitmapData_;
         if (!noRedraw)
            this.iconBitmapData_ = TextureRedrawer.redraw(this.origIconBitmapData_,320 / this.origIconBitmapData_.width,true,0);
         this.icon_ = new Bitmap(this.getCroppedBitmapData(this.iconBitmapData_,param5));
         this.icon_.x = -12;
         this.icon_.y = -12;
         addChild(this.icon_);
         if(param2 != "") {
            this.label_ = new TextFieldDisplayConcrete().setColor(16777215).setSize(14);
            this.label_.setStringBuilder(new LineBuilder().setParams(param2));
            this.label_.x = this.icon_.x + this.icon_.width - 8;
            this.label_.y = 0;
            addChild(this.label_);
         }
         addEventListener("mouseOver",this.onMouseOver,false,0,true);
         addEventListener("mouseOut",this.onMouseOut,false,0,true);
         this.setToolTipTitle(param3);
         this.hotkeyName_ = param4;
         if(this.hotkeyName_ != "") {
            this.setToolTipText("IconButton.hotKey",{"hotkey":KeyCodes.CharCodeStrings[Parameters.data[this.hotkeyName_]]});
         }
      }
      
      public function set enabled(param1:Boolean) : void {
         if(param1) {
            addEventListener("mouseOver",this.onMouseOver,false,0,true);
            addEventListener("mouseOut",this.onMouseOut,false,0,true);
            this.setColorTransform(null);
            mouseChildren = true;
            mouseEnabled = true;
         } else {
            removeEventListener("mouseOver",this.onMouseOver);
            removeEventListener("mouseOut",this.onMouseOut);
            this.setColorTransform(disableCT);
            mouseChildren = false;
            mouseEnabled = false;
         }
      }
      
      public function destroy() : void {
         removeEventListener("mouseOver",this.onMouseOver);
         removeEventListener("mouseOut",this.onMouseOut);
         this.hoverTooltipDelegate.removeDisplayObject();
         this.hoverTooltipDelegate.tooltip = null;
         this.hoverTooltipDelegate = null;
         this.origIconBitmapData_ = null;
         this.iconBitmapData_ = null;
         this.icon_ = null;
         this.label_ = null;
         this.toolTip_ = null;
      }
      
      public function setToolTipTitle(param1:String, param2:Object = null) : void {
         if(param1 != "") {
            if(this.toolTip_ == null) {
               this.toolTip_ = new TextToolTip(3552822,10197915,"","",200);
               this.hoverTooltipDelegate.setDisplayObject(this);
               this.hoverTooltipDelegate.tooltip = this.toolTip_;
            }
            this.toolTip_.setTitle(new LineBuilder().setParams(param1,param2));
         }
      }
      
      public function setToolTipText(param1:String, param2:Object = null) : void {
         if(param1 != "") {
            if(this.toolTip_ == null) {
               this.toolTip_ = new TextToolTip(3552822,10197915,"","",200);
               this.hoverTooltipDelegate.setDisplayObject(this);
               this.hoverTooltipDelegate.tooltip = this.toolTip_;
            }
            this.toolTip_.setText(new LineBuilder().setParams(param1,param2));
         }
      }
      
      public function setColorTransform(param1:ColorTransform) : void {
         if(param1 == this.ct_) {
            return;
         }
         this.ct_ = param1;
         if(this.ct_ == null) {
            transform.colorTransform = MoreColorUtil.identity;
         } else {
            transform.colorTransform = this.ct_;
         }
      }
      
      public function setShowToolTipSignal(param1:ShowTooltipSignal) : void {
         this.hoverTooltipDelegate.setShowToolTipSignal(param1);
      }
      
      public function getShowToolTip() : ShowTooltipSignal {
         return this.hoverTooltipDelegate.getShowToolTip();
      }
      
      public function setHideToolTipsSignal(param1:HideTooltipsSignal) : void {
         this.hoverTooltipDelegate.setHideToolTipsSignal(param1);
      }
      
      public function getHideToolTips() : HideTooltipsSignal {
         return this.hoverTooltipDelegate.getHideToolTips();
      }
      
      private function getCroppedBitmapData(param1:BitmapData, param2:int) : BitmapData {
         if(!param2) {
            return param1;
         }
         var _loc4_:Rectangle = new Rectangle(0,param2,param1.width,param1.height - param2);
         var _loc3_:BitmapData = new BitmapData(param1.width,param1.height - param2);
         _loc3_.copyPixels(param1,_loc4_,new Point(0,0));
         return _loc3_;
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         this.setColorTransform(mouseOverCT);
      }
      
      protected function onMouseOut(param1:MouseEvent) : void {
         this.setColorTransform(null);
      }
   }
}
