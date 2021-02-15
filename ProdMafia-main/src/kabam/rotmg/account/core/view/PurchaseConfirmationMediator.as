package kabam.rotmg.account.core.view {
   import flash.events.Event;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PurchaseConfirmationMediator extends Mediator {
       
      
      [Inject]
      public var view:PurchaseConfirmationDialog;
      
      [Inject]
      public var close:CloseDialogsSignal;
      
      public function PurchaseConfirmationMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.addEventListener("dialogLeftButton",this.onYesClickHandler);
         this.view.addEventListener("dialogRightButton",this.onNoClickHandler);
      }
      
      override public function destroy() : void {
         this.view.removeEventListener("dialogLeftButton",this.onYesClickHandler);
         this.view.removeEventListener("dialogRightButton",this.onNoClickHandler);
      }
      
      private function onYesClickHandler(param1:Event) : void {
         this.close.dispatch();
         this.view.confirmedHandler();
      }
      
      private function onNoClickHandler(param1:Event) : void {
         this.close.dispatch();
      }
   }
}
