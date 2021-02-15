package com.company.assembleegameclient.ui.vault {
   import org.osflash.signals.Signal;
   
   public class VaultUpdateSignal extends Signal {
       
      
      public function VaultUpdateSignal() {
         super(Vector.<int>,Vector.<int>,Vector.<int>);
      }
   }
}
