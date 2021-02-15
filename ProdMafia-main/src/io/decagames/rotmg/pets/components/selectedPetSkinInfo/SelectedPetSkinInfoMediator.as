package io.decagames.rotmg.pets.components.selectedPetSkinInfo {
   import com.company.assembleegameclient.objects.Player;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.signals.ChangePetSkinSignal;
   import io.decagames.rotmg.pets.signals.SelectPetSignal;
   import io.decagames.rotmg.pets.signals.SelectPetSkinSignal;
   import io.decagames.rotmg.shop.NotEnoughResources;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class SelectedPetSkinInfoMediator extends Mediator {
       
      
      [Inject]
      public var view:SelectedPetSkinInfo;
      
      [Inject]
      public var selectPetSkinSignal:SelectPetSkinSignal;
      
      [Inject]
      public var model:PetsModel;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var selectPetSignal:SelectPetSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var changePetSkinSignal:ChangePetSkinSignal;
      
      private var selectedSkin:IPetVO;
      
      private var selectedPet:PetVO;
      
      public function SelectedPetSkinInfoMediator() {
         super();
      }
      
      private function get currentPet() : PetVO {
         return !!this.selectedPet?this.selectedPet:this.model.getActivePet();
      }
      
      private function get currentGold() : int {
         var _loc1_:Player = this.gameModel.player;
         if(_loc1_ != null) {
            return _loc1_.credits_;
         }
         if(this.playerModel != null) {
            return this.playerModel.getCredits();
         }
         return 0;
      }
      
      private function get currentFame() : int {
         var _loc1_:Player = this.gameModel.player;
         if(_loc1_ != null) {
            return _loc1_.fame_;
         }
         if(this.playerModel != null) {
            return this.playerModel.getFame();
         }
         return 0;
      }
      
      override public function initialize() : void {
         this.selectPetSkinSignal.add(this.onSkinSelected);
         this.selectPetSignal.add(this.onPetSelected);
         if(this.currentPet) {
            this.currentPet.updated.add(this.currentPetUpdate);
         }
      }
      
      override public function destroy() : void {
         this.selectPetSkinSignal.remove(this.onSkinSelected);
         if(this.currentPet) {
            this.currentPet.updated.remove(this.currentPetUpdate);
         }
         this.selectPetSignal.remove(this.onPetSelected);
      }
      
      private function currentPetUpdate() : void {
         this.onSkinSelected(this.selectedSkin);
      }
      
      private function onSkinSelected(param1:IPetVO) : void {
         this.selectedSkin = param1;
         this.view.showPetInfo(param1);
         if(this.currentPet == null || param1 == null) {
            this.setAction(1,param1);
         } else if(param1.family != this.currentPet.skinVO.family) {
            this.setAction(3,param1);
         } else if(param1.skinType != this.currentPet.skinVO.skinType) {
            this.setAction(2,param1);
         } else {
            this.setAction(1,param1);
         }
      }
      
      private function onPetSelected(param1:PetVO) : void {
         this.selectedPet = param1;
         this.onSkinSelected(this.selectedSkin);
      }
      
      private function setAction(param1:int, param2:IPetVO) : void {
         if(this.view.goldActionButton) {
            this.view.goldActionButton.clickSignal.remove(this.onActionButtonClickHandler);
         }
         if(this.view.fameActionButton) {
            this.view.fameActionButton.clickSignal.remove(this.onActionButtonClickHandler);
         }
         this.view.actionButtonType = param1;
         if(this.view.goldActionButton) {
            this.view.goldActionButton.clickSignal.add(this.onActionButtonClickHandler);
         }
         if(this.view.fameActionButton) {
            this.view.fameActionButton.clickSignal.add(this.onActionButtonClickHandler);
         }
      }
      
      private function onActionButtonClickHandler(param1:BaseButton) : void {
         var _loc2_:ShopBuyButton = ShopBuyButton(param1);
         var _loc3_:* = int(this.view.actionButtonType) - 2;
         switch(_loc3_) {
            case 0:
               if(_loc2_.currency == 0 && this.currentGold < _loc2_.price || _loc2_.currency == 1 && this.currentFame < _loc2_.price) {
                  this.showPopupSignal.dispatch(new NotEnoughResources(300,_loc2_.currency));
                  return;
               }
               break;
            case 1:
         }
         this.hudModel.gameSprite.gsc_.changePetSkin(this.currentPet.getID(),this.selectedSkin.skinType,_loc2_.currency);
         this.onSkinSelected(null);
      }
   }
}
