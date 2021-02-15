package io.decagames.rotmg.pets.components.petPortrait {
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
   import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.popup.choosePet.ChoosePetPopup;
   import io.decagames.rotmg.pets.popup.releasePet.ReleasePetDialog;
   import io.decagames.rotmg.pets.signals.ReleasePetSignal;
   import io.decagames.rotmg.pets.signals.SelectPetSignal;
   import io.decagames.rotmg.pets.signals.SimulateFeedSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PetPortraitMediator extends Mediator {
       
      
      [Inject]
      public var view:PetPortrait;
      
      [Inject]
      public var petIconFactory:PetIconFactory;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var selectPetSignal:SelectPetSignal;
      
      [Inject]
      public var releasePetSignal:ReleasePetSignal;
      
      [Inject]
      public var simulateFeedSignal:SimulateFeedSignal;
      
      public function PetPortraitMediator() {
         super();
      }
      
      override public function initialize() : void {
         if(this.view.switchable) {
            this.view.petSkin.addEventListener("click",this.onSwitchPetHandler);
         }
         if(this.view.showCurrentPet) {
            this.selectPetSignal.add(this.onPetSelected);
         }
         if(this.view.petVO && this.view.petVO.updated) {
            this.view.petVO.updated.add(this.VOUpdated);
         }
         this.view.releaseSignal.add(this.releasePetHandler);
         this.releasePetSignal.add(this.onRelease);
         this.simulateFeedSignal.add(this.simulateFeed);
      }
      
      override public function destroy() : void {
         this.view.petSkin.removeEventListener("click",this.onSwitchPetHandler);
         this.selectPetSignal.remove(this.onPetSelected);
         if(this.view.petVO && this.view.petVO.updated) {
            this.view.petVO.updated.remove(this.VOUpdated);
         }
         this.view.releaseSignal.remove(this.releasePetHandler);
         this.view.dispose();
         this.releasePetSignal.remove(this.onRelease);
         this.simulateFeedSignal.remove(this.simulateFeed);
      }
      
      private function simulateFeed(param1:int) : void {
         var _loc2_:* = null;
         if(this.view.petVO) {
            _loc2_ = AbilitiesUtil.simulateAbilityUpgrade(this.view.petVO,param1);
            this.view.simulateFeed(_loc2_,param1);
         }
      }
      
      private function onRelease(param1:int) : void {
         this.view.petVO = null;
      }
      
      private function releasePetHandler() : void {
         this.showPopupSignal.dispatch(new ReleasePetDialog(this.view.petVO.getID()));
      }
      
      private function onPetSelected(param1:PetVO) : void {
         var _loc2_:Boolean = false;
         if(this.view.petVO && this.view.petVO.updated) {
            this.view.petVO.updated.remove(this.VOUpdated);
         }
         if(this.view.enableAnimation) {
            _loc2_ = true;
            this.view.enableAnimation = false;
         }
         this.view.petVO = param1;
         this.view.enableAnimation = _loc2_;
         if(this.view.petVO && this.view.petVO.updated) {
            this.view.petVO.updated.add(this.VOUpdated);
         }
      }
      
      private function VOUpdated() : void {
         this.view.petVO = this.view.petVO;
      }
      
      private function onSwitchPetHandler(param1:MouseEvent) : void {
         this.showPopupSignal.dispatch(new ChoosePetPopup());
      }
   }
}
