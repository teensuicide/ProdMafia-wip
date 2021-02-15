package kabam.rotmg.util.components {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   import org.osflash.signals.Signal;
   
   public class ItemWithTooltip extends Sprite implements TooltipAble {
       
      
      public var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public var onMouseOver:Signal;
      
      public var onMouseOut:Signal;
      
      public var itemBitmap:Bitmap;
      
      private var itemId:int;
      
      private var tooltip:ToolTip;
      
      public function ItemWithTooltip(param1:int, param2:int = 100, param3:Boolean = false) {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         onMouseOver = new Signal();
         onMouseOut = new Signal();
         super();
         this.itemId = param1;
         var _loc5_:BitmapData = ObjectLibrary.getRedrawnTextureFromType(param1,param2,true,false);
         var _loc4_:BitmapData = ObjectLibrary.getRedrawnTextureFromType(param1,param2,true,false);
         this.itemBitmap = new Bitmap(_loc4_);
         addChild(this.itemBitmap);
         this.hoverTooltipDelegate.setDisplayObject(this);
         this.tooltip = new EquipmentToolTip(param1,null,-1,"NPC");
         this.tooltip.forcePostionLeft();
         this.hoverTooltipDelegate.tooltip = this.tooltip;
         if(param3) {
            addEventListener("removedFromStage",this.onDestruct);
            addEventListener("rollOver",this.onRollOver);
            addEventListener("rollOut",this.onRollOut);
         }
      }
      
      public function disableTooltip() : void {
         this.hoverTooltipDelegate.removeDisplayObject();
      }
      
      public function enableTooltip() : void {
         this.hoverTooltipDelegate.setDisplayObject(this);
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
      
      public function setXPos(param1:Number) : void {
         this.x = param1 - this.width / 2;
      }
      
      public function setYPos(param1:Number) : void {
         this.y = param1 - this.height / 2;
      }
      
      public function getCenterX() : Number {
         return this.x + this.width / 2;
      }
      
      public function getCenterY() : Number {
         return this.y + this.height / 2;
      }
      
      private function onDestruct(param1:Event) : void {
         removeEventListener("removedFromStage",this.onDestruct);
         removeEventListener("rollOver",this.onRollOver);
         removeEventListener("rollOut",this.onRollOut);
         this.onMouseOver.removeAll();
         this.onMouseOut.removeAll();
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         this.onMouseOver.dispatch();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.onMouseOut.dispatch();
      }
   }
}
