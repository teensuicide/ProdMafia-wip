package io.decagames.rotmg.pets.popup.upgradeYard {
   import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class PetYardUpgradeDialog extends ModalPopup {
       
      
      private var upgradeButtonsMargin:int = 20;
      
      private var _upgradeGoldButton:ShopBuyButton;
      
      private var _upgradeFameButton:ShopBuyButton;
      
      public function PetYardUpgradeDialog(param1:PetRarityEnum, param2:int, param3:int) {
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         super(270,0,"Upgrade Pet Yard");
         _loc7_ = TextureParser.instance.getSliceScalingBitmap("UI","petYard_" + LineBuilder.getLocalizedStringFromKey("{" + param1.rarityKey + "}"));
         _loc7_.x = Math.round((contentWidth - _loc7_.width) / 2);
         addChild(_loc7_);
         _loc4_ = new UILabel();
         DefaultLabelFormat.petYardUpgradeInfo(_loc4_);
         _loc4_.x = 50;
         _loc4_.y = _loc7_.height + 10;
         _loc4_.width = 170;
         _loc4_.wordWrap = true;
         _loc4_.text = LineBuilder.getLocalizedStringFromKey("YardUpgraderView.info");
         addChild(_loc4_);
         _loc5_ = new UILabel();
         DefaultLabelFormat.petYardUpgradeRarityInfo(_loc5_);
         _loc5_.y = _loc4_.y + _loc4_.textHeight + 8;
         _loc5_.width = contentWidth;
         _loc5_.wordWrap = true;
         _loc5_.text = LineBuilder.getLocalizedStringFromKey("{" + param1.rarityKey + "}");
         addChild(_loc5_);
         this._upgradeGoldButton = new ShopBuyButton(param2,0);
         this._upgradeFameButton = new ShopBuyButton(param3,1);
         var _loc6_:* = 120;
         this._upgradeFameButton.width = _loc6_;
         this._upgradeGoldButton.width = _loc6_;
         _loc6_ = _loc5_.y + _loc5_.height + 15;
         this._upgradeFameButton.y = _loc6_;
         this._upgradeGoldButton.y = _loc6_;
         var _loc8_:int = (contentWidth - (this._upgradeGoldButton.width + this._upgradeFameButton.width + this.upgradeButtonsMargin)) / 2;
         this._upgradeGoldButton.x = _loc8_;
         this._upgradeFameButton.x = this._upgradeGoldButton.x + this._upgradeGoldButton.width + this.upgradeButtonsMargin;
         addChild(this._upgradeGoldButton);
         addChild(this._upgradeFameButton);
      }
      
      public function get upgradeGoldButton() : ShopBuyButton {
         return this._upgradeGoldButton;
      }
      
      public function get upgradeFameButton() : ShopBuyButton {
         return this._upgradeFameButton;
      }
   }
}
