package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.ui.panels.GuildChroniclePanel;
   import com.company.assembleegameclient.ui.panels.Panel;
   
   public class GuildChronicle extends GameObject implements IInteractiveObject {
       
      
      public function GuildChronicle(param1:XML) {
         super(param1);
         isInteractive_ = true;
      }
      
      public function getPanel(param1:GameSprite) : Panel {
         return new GuildChroniclePanel(param1);
      }
   }
}
