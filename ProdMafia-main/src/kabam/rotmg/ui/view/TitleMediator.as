package kabam.rotmg.ui.view {
   import flash.system.Capabilities;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.signals.OpenAccountInfoSignal;
   import kabam.rotmg.account.core.signals.OpenVerifyEmailSignal;
   import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsModel;
   import kabam.rotmg.account.securityQuestions.view.SecurityQuestionsInfoDialog;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.application.api.ApplicationSetup;
   import kabam.rotmg.build.api.BuildData;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   import kabam.rotmg.core.view.Layers;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.legends.view.LegendsView;
   import kabam.rotmg.ui.model.EnvironmentData;
   import kabam.rotmg.ui.signals.EnterGameSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   import robotlegs.bender.framework.api.ILogger;
   
   public class TitleMediator extends Mediator {
      
      private static var supportCalledBefore:Boolean = false;
       
      
      [Inject]
      public var view:TitleView;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var enterGame:EnterGameSignal;
      
      [Inject]
      public var openAccountInfo:OpenAccountInfoSignal;
      
      [Inject]
      public var openVerifyEmailSignal:OpenVerifyEmailSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var setup:ApplicationSetup;
      
      [Inject]
      public var layers:Layers;
      
      [Inject]
      public var securityQuestionsModel:SecurityQuestionsModel;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var buildData:BuildData;
      
      public function TitleMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.initialize(this.makeEnvironmentData());
         this.view.playClicked.add(this.handleIntentionToPlay);
         this.view.accountClicked.add(this.handleIntentionToReviewAccount);
         this.view.legendsClicked.add(this.showLegendsScreen);
         if(this.securityQuestionsModel.showSecurityQuestionsOnStartup) {
            this.openDialog.dispatch(new SecurityQuestionsInfoDialog());
         }
      }
      
      override public function destroy() : void {
         this.view.playClicked.remove(this.handleIntentionToPlay);
         this.view.accountClicked.remove(this.handleIntentionToReviewAccount);
         this.view.legendsClicked.remove(this.showLegendsScreen);
      }
      
      private function makeEnvironmentData() : EnvironmentData {
         var _loc1_:EnvironmentData = new EnvironmentData();
         _loc1_.isDesktop = Capabilities.playerType == "Desktop";
         _loc1_.canMapEdit = this.playerModel.isAdmin() || this.playerModel.mapEditor();
         _loc1_.buildLabel = this.setup.getBuildLabel();
         return _loc1_;
      }
      
      private function handleIntentionToPlay() : void {
         if(this.account.isRegistered()) {
            this.enterGame.dispatch();
         } else {
            this.openAccountInfo.dispatch(false);
         }
      }
      
      private function handleIntentionToReviewAccount() : void {
         this.openAccountInfo.dispatch(false);
      }
      
      private function showLegendsScreen() : void {
         this.setScreen.dispatch(new LegendsView());
      }
   }
}
