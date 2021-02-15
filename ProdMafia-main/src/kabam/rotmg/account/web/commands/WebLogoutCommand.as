package kabam.rotmg.account.web.commands {
   import io.decagames.rotmg.pets.data.PetsModel;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.model.ScreenModel;
   import kabam.rotmg.core.signals.InvalidateDataSignal;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.packages.services.GetPackagesTask;
   import kabam.rotmg.ui.view.TitleView;
   
   public class WebLogoutCommand {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var invalidate:InvalidateDataSignal;
      
      [Inject]
      public var setScreenSignal:SetScreenSignal;
      
      [Inject]
      public var screenModel:ScreenModel;
      
      [Inject]
      public var getPackageTask:GetPackagesTask;
      
      [Inject]
      public var petsModel:PetsModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      public function WebLogoutCommand() {
         super();
      }
      
      public function execute() : void {
         this.account.clear();
         this.playerModel.lockList.length = 0;
         this.playerModel.ignoreList.length = 0;
         this.invalidate.dispatch();
         this.petsModel.clearPets();
         this.getPackageTask.finished.addOnce(this.onFinished);
         this.getPackageTask.start();
      }
      
      private function onFinished(param1:BaseTask, param2:Boolean, param3:String) : void {
         this.playerModel.isLogOutLogIn = true;
         this.setScreenSignal.dispatch(new TitleView());
      }
   }
}
