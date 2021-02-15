package io.decagames.rotmg.pets.components.petSkinSlot {
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.components.tooltip.PetTooltip;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.utils.colors.GreyScale;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.tooltips.TooltipAble;
   import org.osflash.signals.Signal;
   
   public class PetSkinSlot extends UIGridElement implements TooltipAble {
      
      public static const SLOT_SIZE:int = 40;
       
      
      public var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public var updatedVOSignal:Signal;
      
      private var skinBitmap:Bitmap;
      
      private var newLabel:Sprite;
      
      private var _skinVO:IPetVO;
      
      private var _isSkinSelectableSlot:Boolean;
      
      private var _selected:Boolean;
      
      private var _manualUpdate:Boolean;
      
      public function PetSkinSlot(param1:IPetVO, param2:Boolean) {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         updatedVOSignal = new Signal();
         super();
         this._skinVO = param1;
         this._isSkinSelectableSlot = param2;
         this.renderSlotBackground();
         this.updateTooltip();
      }
      
      public function get skinVO() : IPetVO {
         return this._skinVO;
      }
      
      public function set skinVO(param1:IPetVO) : void {
         this._skinVO = param1;
         this.updateTooltip();
         this.updatedVOSignal.dispatch();
      }
      
      public function get isSkinSelectableSlot() : Boolean {
         return this._isSkinSelectableSlot;
      }
      
      public function set selected(param1:Boolean) : void {
         this._selected = param1;
         this.renderSlotBackground();
      }
      
      public function get manualUpdate() : Boolean {
         return this._manualUpdate;
      }
      
      public function set manualUpdate(param1:Boolean) : void {
         this._manualUpdate = param1;
      }
      
      override public function dispose() : void {
         this.clearSkinBitmap();
         super.dispose();
      }
      
      public function addSkin(param1:BitmapData) : void {
         this.clearSkinBitmap();
         if(param1 == null) {
            this.graphics.clear();
            return;
         }
         this.renderSlotBackground();
         this.clearNewLabel();
         if(this._isSkinSelectableSlot && !this._skinVO.isOwned) {
            param1 = GreyScale.setGreyScale(param1);
         }
         this.skinBitmap = new Bitmap(param1);
         this.skinBitmap.x = Math.round((40 - param1.width) / 2);
         this.skinBitmap.y = Math.round((40 - param1.height) / 2);
         addChild(this.skinBitmap);
         if(this._skinVO.isNew) {
            this.newLabel = this.createNewLabel(24);
            addChild(this.newLabel);
         }
      }
      
      public function clearNewLabel() : void {
         if(this.newLabel && this.newLabel.parent) {
            removeChild(this.newLabel);
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
      
      private function updateTooltip() : void {
         if(this._skinVO) {
            if(!this.hoverTooltipDelegate.getDisplayObject()) {
               this.hoverTooltipDelegate.setDisplayObject(this);
            }
            this.hoverTooltipDelegate.tooltip = new PetTooltip(this._skinVO);
         }
      }
      
      private function renderSlotBackground() : void {
         this.graphics.clear();
         this.graphics.beginFill(!this._selected?this._isSkinSelectableSlot && this._skinVO.isOwned?this._skinVO.rarity.backgroundColor:1907997:15306295);
         this.graphics.drawRect(-1,-1,42,42);
      }
      
      private function createNewLabel(param1:int) : Sprite {
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(16777215);
         _loc2_.graphics.drawRect(0,0,param1,9);
         _loc2_.graphics.endFill();
         var _loc3_:UILabel = new UILabel();
         DefaultLabelFormat.newSkinLabel(_loc3_);
         _loc3_.width = param1;
         _loc3_.wordWrap = true;
         _loc3_.text = "NEW";
         _loc3_.y = -1;
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      private function clearSkinBitmap() : void {
         if(this.skinBitmap && this.skinBitmap.bitmapData) {
            this.skinBitmap.bitmapData.dispose();
         }
      }
   }
}
