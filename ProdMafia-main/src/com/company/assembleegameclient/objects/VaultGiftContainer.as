package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.panels.Panel;
   import com.company.assembleegameclient.ui.panels.VaultGiftPanel;
   
   public class VaultGiftContainer extends GameObject implements IInteractiveObject {
       
      
      public function VaultGiftContainer(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }
      
      public function getPanel(param1:GameSprite) : Panel {
         return new VaultGiftPanel(param1,this);
      }
   }
}
