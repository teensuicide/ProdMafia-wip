package io.decagames.rotmg.pets.signals {
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import org.osflash.signals.Signal;
   
   public class SelectPetSignal extends Signal {
       
      
      public function SelectPetSignal() {
         super(PetVO);
      }
   }
}
