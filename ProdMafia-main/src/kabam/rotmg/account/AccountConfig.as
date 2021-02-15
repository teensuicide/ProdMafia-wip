package kabam.rotmg.account {
   import com.company.assembleegameclient.account.ui.MoneyFrameMediator;
   import flash.display.DisplayObjectContainer;
   import kabam.rotmg.account.core.BuyCharacterSlotCommand;
   import kabam.rotmg.account.core.commands.PurchaseGoldCommand;
   import kabam.rotmg.account.core.commands.VerifyAgeCommand;
   import kabam.rotmg.account.core.control.IsAccountRegisteredToBuyGoldGuard;
   import kabam.rotmg.account.core.model.OfferModel;
   import kabam.rotmg.account.core.services.GetCharListTask;
   import kabam.rotmg.account.core.services.GetConCharListTask;
   import kabam.rotmg.account.core.services.GetConServersTask;
   import kabam.rotmg.account.core.services.VerifyAgeTask;
   import kabam.rotmg.account.core.signals.PurchaseGoldSignal;
   import kabam.rotmg.account.core.signals.UpdateAccountInfoSignal;
   import kabam.rotmg.account.core.signals.VerifyAgeSignal;
   import kabam.rotmg.account.core.view.MoneyFrame;
   import kabam.rotmg.account.core.view.PurchaseConfirmationDialog;
   import kabam.rotmg.account.core.view.PurchaseConfirmationMediator;
   import kabam.rotmg.account.securityQuestions.commands.SaveSecurityQuestionsCommand;
   import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
   import kabam.rotmg.account.securityQuestions.mediators.SecurityQuestionsMediator;
   import kabam.rotmg.account.securityQuestions.signals.SaveSecurityQuestionsSignal;
   import kabam.rotmg.account.securityQuestions.tasks.SaveSecurityQuestionsTask;
   import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsConfirmDialog;
   import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsDialog;
   import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
   import kabam.rotmg.account.web.WebAccountConfig;
   import kabam.rotmg.core.signals.MoneyFrameEnableCancelSignal;
   import kabam.rotmg.core.signals.TaskErrorSignal;
   import kabam.rotmg.ui.signals.BuyCharacterSlotSignal;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   import robotlegs.bender.framework.api.IConfig;
   import robotlegs.bender.framework.api.IContext;
   import robotlegs.bender.framework.api.ILogger;
   
   public class AccountConfig implements IConfig {
       
      
      [Inject]
      public var root:DisplayObjectContainer;
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      [Inject]
      public var mediatorMap:IMediatorMap;
      
      [Inject]
      public var context:IContext;
      
      [Inject]
      public var logger:ILogger;
      
      public function AccountConfig() {
         super();
      }
      
      public function configure() : void {
         this.configureCommonFunctionality();
      }
      
      private function configureCommonFunctionality() : void {
         this.injector.map(TaskErrorSignal).asSingleton();
         this.injector.map(UpdateAccountInfoSignal).asSingleton();
         this.injector.map(VerifyAgeTask);
         this.injector.map(GetCharListTask);
         this.injector.map(GetConCharListTask);
         this.injector.map(GetConServersTask);
         this.injector.map(MoneyFrameEnableCancelSignal).asSingleton();
         this.injector.map(SecurityQuestionsModel).asSingleton();
         this.injector.map(OfferModel).asSingleton();
         this.injector.map(SaveSecurityQuestionsTask);
         this.mediatorMap.map(MoneyFrame).toMediator(MoneyFrameMediator);
         this.mediatorMap.map(SecurityQuestionsDialog).toMediator(SecurityQuestionsMediator);
         this.mediatorMap.map(SecurityQuestionsInfoDialog).toMediator(SecurityQuestionsMediator);
         this.mediatorMap.map(SecurityQuestionsConfirmDialog).toMediator(SecurityQuestionsMediator);
         this.mediatorMap.map(PurchaseConfirmationDialog).toMediator(PurchaseConfirmationMediator);
         this.commandMap.map(BuyCharacterSlotSignal).toCommand(BuyCharacterSlotCommand).withGuards(IsAccountRegisteredToBuyGoldGuard);
         this.commandMap.map(PurchaseGoldSignal).toCommand(PurchaseGoldCommand);
         this.commandMap.map(VerifyAgeSignal).toCommand(VerifyAgeCommand);
         this.commandMap.map(SaveSecurityQuestionsSignal).toCommand(SaveSecurityQuestionsCommand);
         this.context.configure(WebAccountConfig);
      }
   }
}
