package com.company.assembleegameclient.ui.vault {
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class VaultMediator extends Mediator {
       
      
      [Inject]
      public var view:VaultView;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var hudModel:HUDModel;
      
      public function VaultMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc1_:* = this.view.header.titleLabel.text;
         switch(_loc1_) {
            case "Vault":
               this.view.init(this.hudModel.vaultContents);
               break;
            case "Gifts":
               this.view.init(this.hudModel.giftContents);
               break;
            case "Potions":
               this.view.init(this.hudModel.potContents);
         }
      }
   }
}
