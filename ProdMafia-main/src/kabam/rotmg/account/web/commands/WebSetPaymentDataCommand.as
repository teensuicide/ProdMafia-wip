package kabam.rotmg.account.web.commands {
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.web.WebAccount;
   
   public class WebSetPaymentDataCommand {
       
      
      [Inject]
      public var characterListData:XML;
      
      [Inject]
      public var account:Account;
      
      public function WebSetPaymentDataCommand() {
         super();
      }
      
      public function execute() : void {
         var _loc1_:* = null;
         var _loc2_:WebAccount = this.account as WebAccount;
         if("KabamPaymentInfo" in this.characterListData) {
            _loc1_ = XML(this.characterListData.KabamPaymentInfo);
            _loc2_.signedRequest = _loc1_.signedRequest;
            _loc2_.kabamId = _loc1_.naid;
         }
      }
   }
}
