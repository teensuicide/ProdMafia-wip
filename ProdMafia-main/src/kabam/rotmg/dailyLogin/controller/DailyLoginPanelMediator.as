package kabam.rotmg.dailyLogin.controller {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import kabam.rotmg.dailyLogin.model.DailyLoginModel;
   import kabam.rotmg.dailyLogin.view.DailyLoginModal;
   import kabam.rotmg.dailyLogin.view.DailyLoginPanel;
   import kabam.rotmg.dialogs.control.OpenDialogNoModalSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class DailyLoginPanelMediator extends Mediator {
       
      
      [Inject]
      public var view:DailyLoginPanel;
      
      [Inject]
      public var openNoModalDialog:OpenDialogNoModalSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var model:DailyLoginModel;
      
      public function DailyLoginPanelMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.init();
         if(this.model.initialized) {
            this.view.showCalendarButton();
            this.view.calendarButton.addEventListener("click",this.showCalendarModal);
            Main.STAGE.addEventListener("keyDown",this.onKeyDown);
         } else {
            this.view.showNoCalendarButton();
         }
      }
      
      override public function destroy() : void {
         this.view.calendarButton.removeEventListener("click",this.showCalendarModal);
         Main.STAGE.removeEventListener("keyDown",this.onKeyDown);
         super.destroy();
      }
      
      private function showCalendarModal(param1:MouseEvent) : void {
         this.openDialog.dispatch(new DailyLoginModal());
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && Main.STAGE.focus == null) {
            this.showCalendarModal(null);
         }
      }
   }
}
