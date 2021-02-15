package kabam.rotmg.core.commands {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.data.yard.PetYardEnum;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class UpdatePetsModelCommand extends Command {
       
      
      [Inject]
      public var model:PetsModel;
      
      [Inject]
      public var data:XML;
      
      public function UpdatePetsModelCommand() {
         super();
      }
      
      override public function execute() : void {
         if("PetYardType" in this.data.Account) {
            this.model.setPetYardType(this.parseYardFromXML());
         }
         if("Pet" in this.data) {
            this.model.setActivePet(this.parsePetFromXML());
         }
      }
      
      private function parseYardFromXML() : int {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!(this.data.Account.PetYardType <= 5 && this.data.Account.PetYardType >= 0)) {
            _loc2_ = PetYardEnum.selectByOrdinal(1).value;
         } else {
            _loc2_ = PetYardEnum.selectByOrdinal(this.data.Account.PetYardType).value;
         }
         _loc1_ = ObjectLibrary.getXMLfromId(_loc2_);
         return _loc1_.@type;
      }
      
      private function parsePetFromXML() : PetVO {
         var _loc2_:XMLList = this.data.Pet;
         var _loc1_:PetVO = this.model.getPetVO(_loc2_.@instanceId);
         _loc1_.apply(_loc2_[0]);
         return _loc1_;
      }
   }
}
