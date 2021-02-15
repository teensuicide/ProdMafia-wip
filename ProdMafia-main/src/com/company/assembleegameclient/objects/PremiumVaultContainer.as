package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.ui.panels.PremiumVaultPanel;
   
   public class PremiumVaultContainer extends SellableObject implements IInteractiveObject {
       
      
      public function PremiumVaultContainer(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }
      
      override public function getPanel(param1:GameSprite) : Panel {
         return new PremiumVaultPanel(param1,this);
      }
   }
}
