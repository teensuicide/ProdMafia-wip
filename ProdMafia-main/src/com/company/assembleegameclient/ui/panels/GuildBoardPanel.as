package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.board.GuildBoardWindow;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class GuildBoardPanel extends ButtonPanel {
       
      
      public function GuildBoardPanel(param1:GameSprite) {
         super(param1,"GuildBoardPanel.title","Panel.viewButton");
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function openWindow() : void {
         var _loc1_:Player = gs_.map.player_;
         if(_loc1_ == null) {
            return;
         }
         gs_.addChild(new GuildBoardWindow(_loc1_.guildRank_ >= 20));
      }
      
      override protected function onButtonClick(param1:MouseEvent) : void {
         this.openWindow();
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("keyDown",this.onKeyDown);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            this.openWindow();
         }
      }
   }
}
