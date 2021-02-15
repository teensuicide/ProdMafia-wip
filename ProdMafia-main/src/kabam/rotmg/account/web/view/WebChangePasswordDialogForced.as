package kabam.rotmg.account.web.view {
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.assembleegameclient.account.ui.TextInputField;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class WebChangePasswordDialogForced extends Frame {
       
      
      public var cancel:Signal;
      
      public var change:Signal;
      
      public var password_:TextInputField;
      
      public var newPassword_:TextInputField;
      
      public var retypeNewPassword_:TextInputField;
      
      public function WebChangePasswordDialogForced() {
         super("WebChangePasswordDialog.title","","WebChangePasswordDialog.rightButton","/changePassword");
         this.password_ = new TextInputField("WebChangePasswordDialog.password",true);
         addTextInputField(this.password_);
         this.newPassword_ = new TextInputField("WebChangePasswordDialog.newPassword",true);
         addTextInputField(this.newPassword_);
         this.retypeNewPassword_ = new TextInputField("WebChangePasswordDialog.retypePassword",true);
         addTextInputField(this.retypeNewPassword_);
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
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = this.newPassword_.text().length >= 10;
         if(!_loc2_) {
            this.newPassword_.setError("LinkWebAccountDialog.shortError");
         } else {
            _loc1_ = this.newPassword_.text();
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length - 2) {
               if(_loc1_.charAt(_loc3_) == _loc1_.charAt(_loc3_ + 1) && _loc1_.charAt(_loc3_ + 1) == _loc1_.charAt(_loc3_ + 2)) {
                  this.newPassword_.setError("LinkWebAccountDialog.shortError");
                  _loc2_ = false;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function isNewPasswordVerified() : Boolean {
         var _loc1_:* = this.newPassword_.text() == this.retypeNewPassword_.text();
         if(!_loc1_) {
            this.retypeNewPassword_.setError("LinkWebAccountDialog.matchError");
         }
         return _loc1_;
      }
   }
}
