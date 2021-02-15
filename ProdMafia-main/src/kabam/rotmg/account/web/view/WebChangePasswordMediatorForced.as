package kabam.rotmg.account.web.view {
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.web.signals.WebChangePasswordSignal;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.signals.TaskErrorSignal;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class WebChangePasswordMediatorForced extends Mediator {
       
      
      [Inject]
      public var view:WebChangePasswordDialogForced;
      
      [Inject]
      public var change:WebChangePasswordSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      [Inject]
      public var loginError:TaskErrorSignal;
      
      [Inject]
      public var account:Account;
      
      private var newPassword:String;
      
      public function WebChangePasswordMediatorForced() {
         super();
      }
      
      override public function initialize() : void {
         this.view.change.add(this.onChange);
         this.loginError.add(this.onError);
      }
      
      override public function destroy() : void {
         this.view.change.remove(this.onChange);
         this.loginError.remove(this.onError);
      }
      
      private function onChange() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(this.isCurrentPasswordValid() && this.isNewPasswordValid() && this.isNewPasswordVerified()) {
            this.view.clearError();
            this.view.disable();
            _loc2_ = StaticInjectorContext.getInjector().getInstance(AppEngineClient);
            _loc1_ = {};
            _loc1_.password = this.view.password_.text();
            this.newPassword = this.view.newPassword_.text();
            _loc1_.newPassword = this.view.newPassword_.text();
            _loc1_.guid = this.account.getUserId();
            _loc2_.sendRequest("/account/changePassword",_loc1_);
            _loc2_.complete.addOnce(this.onComplete);
         }
      }
      
      private function isCurrentPasswordValid() : Boolean {
         var _loc1_:* = this.view.password_.text().length >= 5;
         if(!_loc1_) {
            this.view.password_.setError("WebChangePasswordDialog.Incorrect");
         }
         return _loc1_;
      }
      
      private function isNewPasswordValid() : Boolean {
         var _loc1_:* = this.view.newPassword_.text().length >= 10;
         if(!_loc1_) {
            this.view.newPassword_.setError("RegisterWebAccountDialog.shortError");
         }
         return _loc1_;
      }
      
      private function isNewPasswordVerified() : Boolean {
         var _loc1_:* = this.view.newPassword_.text() == this.view.retypeNewPassword_.text();
         if(!_loc1_) {
            this.view.retypeNewPassword_.setError("RegisterWebAccountDialog.matchError");
         }
         return _loc1_;
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(!param1) {
            this.onError(param2);
         } else {
            this.account.updateUser(this.account.getUserId(),this.newPassword,this.account.getToken(),this.account.getSecret());
            this.closeDialogs.dispatch();
         }
      }
      
      private function onError(param1:String) : void {
         this.view.newPassword_.setError(param1);
         this.view.enable();
      }
   }
}
