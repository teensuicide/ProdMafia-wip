package kabam.rotmg.account.web.commands {
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.web.view.WebVerifyEmailDialog;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.ui.signals.PollVerifyEmailSignal;
   
   public class WebOpenVerifyEmailCommand {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var pollVerifyEmailSignal:PollVerifyEmailSignal;
      
      public function WebOpenVerifyEmailCommand() {
         super();
      }
      
      public function execute() : void {
         if(!this.account.isVerified()) {
            this.openDialog.dispatch(new WebVerifyEmailDialog());
            this.pollVerifyEmailSignal.dispatch();
         }
      }
   }
}
