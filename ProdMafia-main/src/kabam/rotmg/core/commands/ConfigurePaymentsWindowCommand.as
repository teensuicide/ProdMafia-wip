package kabam.rotmg.core.commands {
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.commands.ExternalOpenMoneyWindowCommand;
   import kabam.rotmg.account.core.commands.InternalOpenMoneyWindowCommand;
   import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
   import kabam.rotmg.account.web.WebAccount;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   
   public class ConfigurePaymentsWindowCommand {
       
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var data:XML;
      
      public function ConfigurePaymentsWindowCommand() {
         super();
      }
      
      public function execute() : void {
         this.commandMap.map(OpenMoneyWindowSignal).toCommand(this.getPaymentsCommandClass());
      }
      
      private function getPaymentsCommandClass() : Class {
         return !!this.useExternalPaymentsWindow()?ExternalOpenMoneyWindowCommand:InternalOpenMoneyWindowCommand;
      }
      
      private function useExternalPaymentsWindow() : Boolean {
         return this.account is WebAccount;
      }
   }
}
