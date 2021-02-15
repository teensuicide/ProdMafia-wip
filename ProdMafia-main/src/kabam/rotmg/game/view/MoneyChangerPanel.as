package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.panels.ButtonPanel;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import org.osflash.signals.Signal;
   
   public class MoneyChangerPanel extends ButtonPanel {
       
      
      public var triggered:Signal;
      
      public function MoneyChangerPanel(param1:GameSprite) {
         super(param1,"MoneyChangerPanel.title","MoneyChangerPanel.button");
         this.triggered = new Signal();
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      override protected function onButtonClick(param1:MouseEvent) : void {
         this.triggered.dispatch();
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("keyDown",this.onKeyDown);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            this.triggered.dispatch();
         }
      }
   }
}
