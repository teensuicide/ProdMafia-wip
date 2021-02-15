package io.decagames.rotmg.pets.components.selectedPetSkinInfo {
   import io.decagames.rotmg.pets.components.petInfoSlot.PetInfoSlot;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   
   public class SelectedPetSkinInfo extends PetInfoSlot {
       
      
      private var _actionLabel:UILabel;
      
      private var actionButtonMargin:int = 8;
      
      private var _goldActionButton:SliceScalingButton;
      
      private var _fameActionButton:SliceScalingButton;
      
      private var _actionButtonType:int;
      
      public function SelectedPetSkinInfo(param1:int, param2:Boolean) {
         super(param1,false,false,false,false,param2);
         this._actionLabel = new UILabel();
         this._actionLabel.y = 140;
         DefaultLabelFormat.petInfoLabel(this._actionLabel,16777215);
      }
      
      public function get goldActionButton() : SliceScalingButton {
         return this._goldActionButton;
      }
      
      public function get fameActionButton() : SliceScalingButton {
         return this._fameActionButton;
      }
      
      public function get actionButtonType() : int {
         return this._actionButtonType;
      }
      
      public function set actionButtonType(param1:int) : void {
         this._actionButtonType = param1;
         this.updateButton();
      }
      
      private function updateButton() : void {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         if(this._goldActionButton) {
            removeChild(this._goldActionButton);
            this._goldActionButton = null;
         }
         if(this._fameActionButton) {
            removeChild(this._fameActionButton);
            this._fameActionButton = null;
         }
         if(this._actionLabel.parent) {
            removeChild(this._actionLabel);
         }
         var _loc3_:* = int(this._actionButtonType) - 2;
         switch(_loc3_) {
            case 0:
               this._fameActionButton = new ShopBuyButton(200,1);
               this._goldActionButton = new ShopBuyButton(20);
               this._actionLabel.text = "Change Skin";
               break;
            case 1:
               this._actionLabel.text = "Change Family";
               this._goldActionButton = new ShopBuyButton(100);
               this._fameActionButton = new ShopBuyButton(1000,1);
         }
         if(this._actionButtonType != 1) {
            this._actionLabel.x = Math.round(slotWidth / 2 - this._actionLabel.textWidth / 2);
            this._goldActionButton.width = 90;
            this._fameActionButton.width = 90;
            _loc2_ = 155;
            this._fameActionButton.y = _loc2_;
            this._goldActionButton.y = _loc2_;
            _loc1_ = (slotWidth - (this._goldActionButton.width + this._fameActionButton.width + this.actionButtonMargin)) / 2;
            this._goldActionButton.x = _loc1_;
            this._fameActionButton.x = this._goldActionButton.x + this._goldActionButton.width + this.actionButtonMargin;
            addChild(this._goldActionButton);
            addChild(this._fameActionButton);
            addChild(this._actionLabel);
         }
      }
   }
}
