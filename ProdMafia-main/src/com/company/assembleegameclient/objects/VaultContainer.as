package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.ui.panels.VaultPanel;
   
   public class VaultContainer extends SellableObject implements IInteractiveObject {
       
      
      public function VaultContainer(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }
      
      override public function getPanel(param1:GameSprite) : Panel {
         return new VaultPanel(param1,this);
      }
   }
}
