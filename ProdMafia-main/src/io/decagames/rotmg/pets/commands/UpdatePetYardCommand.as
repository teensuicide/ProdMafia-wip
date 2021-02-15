package io.decagames.rotmg.pets.commands {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.yard.PetYardEnum;
   import io.decagames.rotmg.pets.popup.leaveYard.LeavePetYardDialog;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class UpdatePetYardCommand extends Command {
       
      
      [Inject]
      public var type:int;
      
      [Inject]
      public var petModel:PetsModel;
      
      [Inject]
      public var openDialog:ShowPopupSignal;
      
      public function UpdatePetYardCommand() {
         super();
      }
      
      override public function execute() : void {
         this.petModel.setPetYardType(this.getYardTypeFromEnum());
         this.openDialog.dispatch(new LeavePetYardDialog());
      }
      
      private function getYardTypeFromEnum() : int {
         var _loc1_:String = PetYardEnum.selectByOrdinal(this.type).value;
         return ObjectLibrary.getXMLfromId(_loc1_).@type;
      }
   }
}
