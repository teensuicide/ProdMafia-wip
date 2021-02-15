package kabam.rotmg.core.service {
   import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.ui.view.NotEnoughGoldDialog;
   
   public class PurchaseCharacterErrorTask extends BaseTask {
       
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      public var parentTask:PurchaseCharacterClassTask;
      
      public function PurchaseCharacterErrorTask() {
         super();
      }
      
      override protected function startTask() : void {
         if(this.parentTask.error == "Not enough Gold.") {
            this.showPopupSignal.dispatch(new NotEnoughGoldDialog());
         } else {
            this.openDialog.dispatch(new ErrorDialog(this.parentTask.error));
         }
      }
   }
}
