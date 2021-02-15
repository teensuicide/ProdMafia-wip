package io.decagames.rotmg.pets.windows.yard.list {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.components.petItem.PetItem;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.popup.upgradeYard.PetYardUpgradeDialog;
   import io.decagames.rotmg.pets.signals.ActivatePet;
   import io.decagames.rotmg.pets.signals.EvolvePetSignal;
   import io.decagames.rotmg.pets.signals.NewAbilitySignal;
   import io.decagames.rotmg.pets.signals.ReleasePetSignal;
   import io.decagames.rotmg.pets.signals.SelectPetSignal;
   import io.decagames.rotmg.pets.utils.PetItemFactory;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.popups.SeasonalEventErrorPopup;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.messaging.impl.EvolvePetInfo;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PetYardListMediator extends Mediator {
       
      
      [Inject]
      public var view:PetYardList;
      
      [Inject]
      public var selectPetSignal:SelectPetSignal;
      
      [Inject]
      public var activatePet:ActivatePet;
      
      [Inject]
      public var petIconFactory:PetItemFactory;
      
      [Inject]
      public var model:PetsModel;
      
      [Inject]
      public var newAbilityUnlocked:NewAbilitySignal;
      
      [Inject]
      public var evolvePetSignal:EvolvePetSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var showDialog:ShowPopupSignal;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var release:ReleasePetSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var toolTip:TextToolTip = null;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      private var petsList:Vector.<PetItem>;
      
      private var seasonalEventErrorPopUp:SeasonalEventErrorPopup;
      
      public function PetYardListMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.model.activeUIVO = null;
         this.refreshPetsList();
         this.selectPetVO(this.model.getActivePet());
         this.newAbilityUnlocked.add(this.abilityUnlocked);
         this.evolvePetSignal.add(this.evolvePetHandler);
         var _loc2_:PetRarityEnum = PetRarityEnum.selectByOrdinal(this.model.getPetYardType() - 1);
         var _loc1_:PetRarityEnum = PetRarityEnum.selectByOrdinal(this.model.getPetYardType());
         this.view.showPetYardRarity(_loc2_.rarityName,_loc2_.ordinal < PetRarityEnum.DIVINE.ordinal && this.account.isRegistered());
         if(this.view.upgradeButton) {
            this.view.upgradeButton.clickSignal.add(this.upgradeYard);
            this.toolTip = new TextToolTip(3552822,10197915,"Upgrade Pet Yard","Upgrading your yard allows you to fuse pets up to " + _loc1_.rarityName,180);
            this.hoverTooltipDelegate = new HoverTooltipDelegate();
            this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
            this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
            this.hoverTooltipDelegate.setDisplayObject(this.view.upgradeButton);
            this.hoverTooltipDelegate.tooltip = this.toolTip;
         }
         this.release.add(this.onRelease);
      }
      
      override public function destroy() : void {
         this.clearList();
         this.newAbilityUnlocked.remove(this.abilityUnlocked);
         this.evolvePetSignal.remove(this.evolvePetHandler);
         if(this.view.upgradeButton) {
            this.view.upgradeButton.clickSignal.add(this.upgradeYard);
         }
         this.release.remove(this.onRelease);
      }
      
      private function upgradeYard(param1:BaseButton) : void {
            this.showDialog.dispatch(new PetYardUpgradeDialog(PetRarityEnum.selectByOrdinal(this.model.getPetYardType()),this.model.getPetYardUpgradeGoldPrice(),this.model.getPetYardUpgradeFamePrice()));
      }
      
      private function showSeasonalErrorPopUp(param1:String) : void {
         this.seasonalEventErrorPopUp = new SeasonalEventErrorPopup(param1);
         this.seasonalEventErrorPopUp.okButton.addEventListener("click",this.onSeasonalErrorPopUpClose);
         this.showPopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
      
      private function selectPetVO(param1:PetVO) : void {
         var _loc2_:* = null;
         this.model.activeUIVO = param1;
         var _loc3_:* = this.petsList;
         var _loc6_:int = 0;
         var _loc5_:* = this.petsList;
         for each(_loc2_ in this.petsList) {
            _loc2_.selected = _loc2_.getPetVO() == param1;
         }
      }
      
      private function clearList() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.petsList;
         var _loc5_:int = 0;
         var _loc4_:* = this.petsList;
         for each(_loc3_ in this.petsList) {
            _loc3_.removeEventListener("click",this.onPetSelected);
         }
         this.petsList = new Vector.<PetItem>();
      }
      
      private function refreshPetsList() : void {
         var _loc1_:PetVO = null;
         var _loc3_:* = null;
         this.clearList();
         this.view.clearPetsList();
         this.petsList = new Vector.<PetItem>();
         var _loc2_:Vector.<PetVO> = this.model.getAllPets();
         _loc2_ = _loc2_.sort(this.sortByFamily);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            _loc3_ = this.petIconFactory.create(_loc1_,40,5526612,1);
            _loc3_.addEventListener("click",this.onPetSelected);
            this.petsList.push(_loc3_);
            this.view.addPet(_loc3_);
         }
      }
      
      private function sortByPower(param1:PetVO, param2:PetVO) : int {
         if(param1.totalAbilitiesLevel() < param2.totalAbilitiesLevel()) {
            return 1;
         }
         return -1;
      }
      
      private function sortByFamily(param1:PetVO, param2:PetVO) : int {
         if(param1.family == param2.family) {
            return this.sortByPower(param1,param2);
         }
         if(param1.family > param2.family) {
            return 1;
         }
         return -1;
      }
      
      private function abilityUnlocked(param1:int) : void {
         this.refreshPetsList();
         this.selectPetVO(!this.model.activeUIVO?this.model.getActivePet():this.model.activeUIVO);
      }
      
      private function evolvePetHandler(param1:EvolvePetInfo) : void {
         this.refreshPetsList();
         this.selectPetVO(!this.model.activeUIVO?this.model.getActivePet():this.model.activeUIVO);
      }
      
      private function onRelease(param1:int) : void {
         this.model.deletePet(param1);
         this.refreshPetsList();
      }
      
      private function onSeasonalErrorPopUpClose(param1:MouseEvent) : void {
         this.seasonalEventErrorPopUp.okButton.removeEventListener("click",this.onSeasonalErrorPopUpClose);
         this.closePopupSignal.dispatch(this.seasonalEventErrorPopUp);
      }
      
      private function onPetSelected(param1:MouseEvent) : void {
         var _loc2_:PetItem = PetItem(param1.currentTarget);
         this.selectPetSignal.dispatch(_loc2_.getPetVO());
         this.selectPetVO(_loc2_.getPetVO());
      }
   }
}
