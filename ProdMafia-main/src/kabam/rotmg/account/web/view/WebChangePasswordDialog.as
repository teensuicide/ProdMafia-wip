package kabam.rotmg.account.web.view {
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.assembleegameclient.account.ui.TextInputField;
   import flash.events.MouseEvent;
   import kabam.rotmg.account.web.model.ChangePasswordData;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class WebChangePasswordDialog extends Frame {
       
      
      public var cancel:Signal;
      
      public var change:Signal;
      
      public var password_:TextInputField;
      
      public var newPassword_:TextInputField;
      
      public var retypeNewPassword_:TextInputField;
      
      public function WebChangePasswordDialog() {
         super("WebChangePasswordDialog.title","WebChangePasswordDialog.leftButton","WebChangePasswordDialog.rightButton","/changePassword");
         this.password_ = new TextInputField("WebChangePasswordDialog.password",true);
         addTextInputField(this.password_);
         this.newPassword_ = new TextInputField("WebChangePasswordDialog.newPassword",true);
         addTextInputField(this.newPassword_);
         this.retypeNewPassword_ = new TextInputField("Confirm New Password",true);
         addTextInputField(this.retypeNewPassword_);
         this.cancel = new NativeMappedSignal(leftButton_,"click");
         this.change = new NativeMappedSignal(rightButton_,"click");
      }
      
      public function setError(param1:String) : void {
         this.password_.setError(param1);
      }
      
      public function clearError() : void {
         this.password_.clearError();
         this.retypeNewPassword_.clearError();
         this.newPassword_.clearError();
      }
      
      private function isCurrentPasswordValid() : Boolean {
         var _loc1_:* = this.password_.text().length >= 5;
         if(!_loc1_) {
            this.password_.setError("WebChangePasswordDialog.Incorrect");
         }
         return _loc1_;
      }
      
      private function isNewPasswordValid() : Boolean {
         var _loc1_:* = this.newPassword_.text().length >= 5;
         if(!_loc1_) {
            this.newPassword_.setError("LinkWebAccountDialog.shortError");
         }
         return _loc1_;
      }
      
      private function isNewPasswordVerified() : Boolean {
         var _loc1_:* = this.newPassword_.text() == this.retypeNewPassword_.text();
         if(!_loc1_) {
            this.retypeNewPassword_.setError("LinkWebAccountDialog.matchError");
         }
         return _loc1_;
      }
      
      private function onChange(param1:MouseEvent) : void {
         var _loc2_:* = null;
         if(this.isCurrentPasswordValid() && this.isNewPasswordValid() && this.isNewPasswordVerified()) {
            disable();
            _loc2_ = new ChangePasswordData();
            _loc2_.currentPassword = this.password_.text();
            _loc2_.newPassword = this.newPassword_.text();
            this.change.dispatch(_loc2_);
         }
      }
   }
}
