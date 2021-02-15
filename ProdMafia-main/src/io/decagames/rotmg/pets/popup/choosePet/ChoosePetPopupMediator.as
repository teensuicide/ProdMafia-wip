package io.decagames.rotmg.pets.popup.choosePet {
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.components.petItem.PetItem;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.signals.ActivatePet;
   import io.decagames.rotmg.pets.signals.SelectPetSignal;
   import io.decagames.rotmg.pets.utils.PetItemFactory;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ChoosePetPopupMediator extends Mediator {
       
      
      [Inject]
      public var view:ChoosePetPopup;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var petIconFactory:PetItemFactory;
      
      [Inject]
      public var model:PetsModel;
      
      [Inject]
      public var selectPetSignal:SelectPetSignal;
      
      [Inject]
      public var activatePet:ActivatePet;
      
      private var petsList:Vector.<PetItem>;
      
      private var closeButton:SliceScalingButton;
      
      public function ChoosePetPopupMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc3_:* = null;
         var _loc1_:* = null;
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.petsList = new Vector.<PetItem>();
         var _loc2_:* = this.model.getAllPets();
         var _loc6_:int = 0;
         var _loc5_:* = this.model.getAllPets();
         for each(_loc3_ in this.model.getAllPets()) {
            _loc1_ = this.petIconFactory.create(_loc3_,40,5526612,1);
            _loc1_.addEventListener("click",this.onPetSelected);
            this.petsList.push(_loc1_);
            this.view.addPet(_loc1_);
         }
      }
      
      override public function destroy() : void {
         var _loc3_:* = null;
         this.closeButton.dispose();
         var _loc1_:* = this.petsList;
         var _loc5_:int = 0;
         var _loc4_:* = this.petsList;
         for each(_loc3_ in this.petsList) {
            _loc3_.removeEventListener("click",this.onPetSelected);
         }
         this.petsList = new Vector.<PetItem>();
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function onPetSelected(param1:MouseEvent) : void {
         var _loc2_:PetItem = PetItem(param1.currentTarget);
         this.activatePet.dispatch(_loc2_.getPetVO().getID());
         this.selectPetSignal.dispatch(_loc2_.getPetVO());
         this.closePopupSignal.dispatch(this.view);
      }
   }
}
