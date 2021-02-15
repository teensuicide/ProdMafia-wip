package io.decagames.rotmg.seasonalEvent.signals {
   import org.osflash.signals.Signal;
   
   public class RequestLegacySeasonSignal extends Signal {
       
      
      public function RequestLegacySeasonSignal() {
         super(String,Boolean);
      }
   }
}
