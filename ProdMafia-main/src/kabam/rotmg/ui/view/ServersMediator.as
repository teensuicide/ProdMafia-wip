package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.screens.CharacterSelectionAndNewsScreen;
   import com.company.assembleegameclient.screens.ServersScreen;
   import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
   import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.servers.api.ServerModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ServersMediator extends Mediator {
       
      
      [Inject]
      public var view:ServersScreen;
      
      [Inject]
      public var servers:ServerModel;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var securityQuestionsModel:SecurityQuestionsModel;
      
      public function ServersMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.gotoTitle.add(this.onGotoTitle);
         this.servers.setAvailableServers();
         this.view.initialize(this.servers.getAvailableServers());
         if(this.securityQuestionsModel.showSecurityQuestionsOnStartup) {
            this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
         }
      }
      
      override public function destroy() : void {
         this.view.gotoTitle.remove(this.onGotoTitle);
      }
      
      private function onGotoTitle() : void {
         this.setScreen.dispatch(new CharacterSelectionAndNewsScreen());
      }
   }
}
