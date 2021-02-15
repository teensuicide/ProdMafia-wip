package kabam.rotmg.friends.view {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.rotmg.graphics.DeleteXGraphic;
   import com.company.util.MoreColorUtil;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   
   public class FriendRemoveButton extends Sprite implements TooltipAble {
      
      protected static const mouseOverCT:ColorTransform = new ColorTransform(1,0.862745098039216,0.52156862745098);
       
      
      public var hoverTooltipDelegate:HoverTooltipDelegate;
      
      private var toolTip_:TextToolTip = null;
      
      public function FriendRemoveButton(param1:String = "", param2:String = "", param3:Object = null) {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         super();
         addChild(new DeleteXGraphic());
         if(param1 != "") {
            this.setToolTipTitle(param1,param2,param3);
         }
      }
      
      public function destroy() : void {
         while(numChildren > 0) {
            this.removeChildAt(numChildren - 1);
         }
         this.toolTip_ = null;
         this.hoverTooltipDelegate.removeDisplayObject();
         this.hoverTooltipDelegate = null;
         removeEventListener("mouseOver",this.onMouseOver);
         removeEventListener("mouseOut",this.onMouseOut);
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
      
      private function setToolTipTitle(param1:String, param2:String, param3:Object) : void {
         this.toolTip_ = new TextToolTip(3552822,10197915,param1,param2,200,param3);
         this.hoverTooltipDelegate.setDisplayObject(this);
         this.hoverTooltipDelegate.tooltip = this.toolTip_;
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("mouseOut",this.onMouseOut);
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         transform.colorTransform = mouseOverCT;
      }
      
      protected function onMouseOut(param1:MouseEvent) : void {
         transform.colorTransform = MoreColorUtil.identity;
      }
   }
}
