package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.guild.GuildChronicleScreen;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class GuildChroniclePanel extends ButtonPanel {
       
      
      public function GuildChroniclePanel(param1:GameSprite) {
         super(param1,"GuildChroniclePanel.title","Panel.viewButton");
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function openWindow() : void {
         gs_.mui_.clearInput();
         gs_.addChild(new GuildChronicleScreen(gs_));
      }
      
      override protected function onButtonClick(param1:MouseEvent) : void {
         this.openWindow();
      }
      
      private function onAddedToStage(param1:Event) : void {
         removeEventListener("addedToStage",this.onAddedToStage);
         stage.addEventListener("keyDown",this.onKeyDown);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemovedFromStage);
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            this.openWindow();
         }
      }
   }
}
