package io.decagames.rotmg.pets.components.petIcon {
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.pets.view.dialogs.Disableable;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   
   public class PetIcon extends Sprite implements TooltipAble, Disableable {
      
      public static const DISABLE_COLOR:uint = 2697513;
       
      
      public var hoverTooltipDelegate:HoverTooltipDelegate;
      
      private var bitmap:Bitmap;
      
      private var enabled:Boolean = true;
      
      private var doShowTooltip:Boolean = false;
      
      private var _petVO:PetVO;
      
      public function PetIcon(param1:PetVO) {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         super();
         this._petVO = param1;
         this.hoverTooltipDelegate.setDisplayObject(this);
         this.hoverTooltipDelegate.tooltip = new PetTooltip(param1);
      }
      
      public function get petVO() : PetVO {
         return this._petVO;
      }
      
      public function disable() : void {
         var _loc1_:ColorTransform = new ColorTransform();
         _loc1_.color = 2697513;
         this.bitmap.transform.colorTransform = _loc1_;
         this.enabled = false;
      }
      
      public function isEnabled() : Boolean {
         return this.enabled;
      }
      
      public function setBitmap(param1:Bitmap) : void {
         this.bitmap = param1;
         addChild(param1);
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
      
      public function getPetVO() : PetVO {
         return this._petVO;
      }
      
      public function setTooltipEnabled(param1:Boolean) : void {
         this.doShowTooltip = param1;
         if(param1) {
         }
      }
      
      override public function dispatchEvent(param1:Event) : Boolean {
         if(this.enabled) {
            return super.dispatchEvent(param1);
         }
         return false;
      }
   }
}
