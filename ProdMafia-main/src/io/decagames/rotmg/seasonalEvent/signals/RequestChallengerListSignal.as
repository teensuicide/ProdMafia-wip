package io.decagames.rotmg.seasonalEvent.signals {
   import kabam.rotmg.legends.model.Timespan;
   import org.osflash.signals.Signal;
   
   public class RequestChallengerListSignal extends Signal {
       
      
      public function RequestChallengerListSignal() {
         super(Timespan,String);
      }
   }
}
