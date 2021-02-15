package io.decagames.rotmg.pets.components.petInfoSlot {
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.pets.signals.ChangePetSkinSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PetInfoSlotMediator extends Mediator {
       
      
      [Inject]
      public var view:PetInfoSlot;
      
      [Inject]
      public var petModel:PetsModel;
      
      [Inject]
      public var changePetSkinSignal:ChangePetSkinSignal;
      
      public function PetInfoSlotMediator() {
         super();
      }
      
      override public function initialize() : void {
         if(this.view.showCurrentPet) {
            this.view.showPetInfo(this.petModel.getActivePet());
         }
         this.changePetSkinSignal.add(this.onSkinUpdate);
      }
      
      override public function destroy() : void {
         this.changePetSkinSignal.remove(this.onSkinUpdate);
      }
      
      private function onSkinUpdate(param1:IPetVO) : void {
         this.view.showPetInfo(param1,false);
      }
   }
}
