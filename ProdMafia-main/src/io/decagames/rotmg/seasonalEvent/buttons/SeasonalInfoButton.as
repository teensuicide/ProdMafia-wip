package io.decagames.rotmg.seasonalEvent.buttons {
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.buttons.InfoButton;
   
   public class SeasonalInfoButton extends Sprite {
       
      
      private var _infoButton:InfoButton;
      
      public function SeasonalInfoButton() {
         super();
         this.init();
      }
      
      public function get infoButton() : InfoButton {
         return this._infoButton;
      }
      
      private function init() : void {
         this.createInfoButton();
      }
      
      private function createInfoButton() : void {
         this._infoButton = new InfoButton(10);
         addChild(this._infoButton);
      }
   }
}
