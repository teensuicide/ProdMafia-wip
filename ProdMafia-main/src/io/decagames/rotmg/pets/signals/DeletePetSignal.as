package io.decagames.rotmg.pets.signals {
   import org.osflash.signals.Signal;
   
   public class DeletePetSignal extends Signal {
       
      
      public var petID:int;
      
      public function DeletePetSignal() {
         super(int);
      }
   }
}
