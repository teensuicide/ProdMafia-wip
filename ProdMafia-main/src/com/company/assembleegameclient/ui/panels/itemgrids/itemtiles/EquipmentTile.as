package com.company.assembleegameclient.ui.panels.itemgrids.itemtiles {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
   import com.company.assembleegameclient.util.EquipmentUtil;
   import com.company.assembleegameclient.util.FilterUtil;
   import com.company.util.MoreColorUtil;
   import flash.display.Bitmap;
   import flash.filters.ColorMatrixFilter;
   
   public class EquipmentTile extends InteractiveItemTile {
      
      private static const greyColorFilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.singleColorFilterMatrix(3552822));
       
      
      public var backgroundDetail:Bitmap;
      
      public var itemType:int;
      
      private var minManaUsage:int;
      
      public function EquipmentTile(param1:int, param2:ItemGrid, param3:Boolean) {
         super(param1,param2,param3);
      }
      
      override public function canHoldItem(param1:int) : Boolean {
         return param1 <= 0 || this.itemType == ObjectLibrary.getSlotTypeFromType(param1);
      }
      
      override public function setItem(param1:int) : Boolean {
         var _loc2_:Boolean = super.setItem(param1);
         if(_loc2_) {
            this.backgroundDetail.visible = itemSprite.itemId <= 0;
            this.updateMinMana();
         }
         return _loc2_;
      }
      
      override protected function beginDragCallback() : void {
         this.backgroundDetail.visible = true;
      }
      
      override protected function endDragCallback() : void {
         this.backgroundDetail.visible = itemSprite.itemId <= 0;
      }
      
      override protected function getBackgroundColor() : int {
         return 4539717;
      }
      
      public function setType(param1:int) : void {
         this.backgroundDetail = EquipmentUtil.getEquipmentBackground(param1,4);
         if(this.backgroundDetail) {
            this.backgroundDetail.x = 4;
            this.backgroundDetail.y = 4;
            this.backgroundDetail.filters = FilterUtil.getGreyColorFilter();
            addChildAt(this.backgroundDetail,0);
         }
         this.itemType = param1;
      }
      
      public function updateDim(param1:Player) : void {
         itemSprite.setDim(param1 && (param1.mp_ < this.minManaUsage || this.minManaUsage && param1.isSilenced));
      }
      
      private function updateMinMana() : void {
         var _loc1_:* = null;
         this.minManaUsage = 0;
         if(itemSprite.itemId > 0) {
            _loc1_ = ObjectLibrary.xmlLibrary_[itemSprite.itemId];
            if(_loc1_ && "Usable" in _loc1_) {
               if("MultiPhase" in _loc1_) {
                  this.minManaUsage = _loc1_.MpEndCost;
               } else {
                  this.minManaUsage = _loc1_.MpCost;
               }
            }
         }
      }
   }
}
