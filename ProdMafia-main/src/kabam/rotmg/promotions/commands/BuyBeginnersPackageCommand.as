package kabam.rotmg.promotions.commands {
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.PaymentData;
   import kabam.rotmg.account.core.signals.OpenAccountPaymentSignal;
   import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
   import kabam.rotmg.account.core.view.RegisterPromptDialog;
   import kabam.rotmg.account.web.WebAccount;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.promotions.model.BeginnersPackageModel;
   import kabam.rotmg.promotions.signals.MakeBeginnersPackagePaymentSignal;
   
   public class BuyBeginnersPackageCommand {
      
      private static const REGISTER_DIALOG_TEXT:String = "BuyBeginnersPackageCommand.registerDialog";
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var model:BeginnersPackageModel;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var openAccountPayment:OpenAccountPaymentSignal;
      
      [Inject]
      public var makePayment:MakeBeginnersPackagePaymentSignal;
      
      [Inject]
      public var openMoneyWindow:OpenMoneyWindowSignal;
      
      public function BuyBeginnersPackageCommand() {
         super();
      }
      
      public function execute() : void {
         if(this.account.isRegistered()) {
            this.openAccountSpecificPaymentScreen();
         } else {
            this.promptUserToRegisterAndAbort();
         }
      }
      
      private function openAccountSpecificPaymentScreen() : void {
         if(this.account is WebAccount) {
            this.openMoneyWindow.dispatch();
         } else {
            this.makePaymentImmediately();
         }
      }
      
      private function makePaymentImmediately() : void {
         var _loc1_:PaymentData = new PaymentData();
         _loc1_.offer = this.model.getOffer();
         this.makePayment.dispatch(_loc1_);
      }
      
      private function promptUserToRegisterAndAbort() : void {
         this.openDialog.dispatch(new RegisterPromptDialog("BuyBeginnersPackageCommand.registerDialog"));
      }
   }
}
