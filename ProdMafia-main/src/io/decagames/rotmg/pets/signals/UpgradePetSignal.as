package io.decagames.rotmg.pets.signals {
   import io.decagames.rotmg.pets.data.vo.requests.IUpgradePetRequestVO;
   import org.osflash.signals.Signal;
   
   public class UpgradePetSignal extends Signal {
       
      
      public function UpgradePetSignal() {
         super(IUpgradePetRequestVO);
      }
   }
}
