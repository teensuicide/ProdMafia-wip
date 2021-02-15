package kabam.rotmg.account.web.view {
   import com.company.assembleegameclient.account.ui.CheckBoxField;
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.assembleegameclient.account.ui.TextInputField;
   import com.company.assembleegameclient.ui.DeprecatedClickableText;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import kabam.rotmg.account.web.model.AccountData;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class WebLoginDialog extends Frame {
       
      
      public var cancel:Signal;
      
      public var signIn:Signal;
      
      public var forgot:Signal;
      
      public var register:Signal;
      
      private var email:TextInputField;
      
      private var password:TextInputField;
      
      private var secret:TextInputField;
      
      private var forgotText:DeprecatedClickableText;
      
      private var registerText:DeprecatedClickableText;
      
      private var rememberMeCheckbox:CheckBoxField;
      
      public function WebLoginDialog() {
         super("WebLoginDialog.title","WebLoginDialog.leftButton","WebLoginDialog.rightButton","/signIn");
         this.makeUI();
         this.forgot = new NativeMappedSignal(this.forgotText,"click");
         this.register = new NativeMappedSignal(this.registerText,"click");
         this.cancel = new NativeMappedSignal(leftButton_,"click");
         this.signIn = new Signal(AccountData);
      }
      
      public function isRememberMeSelected() : Boolean {
         return true;
      }
      
      public function setError(param1:String) : void {
         this.password.setError(param1);
      }
      
      public function setEmail(param1:String) : void {
         this.email.inputText_.text = param1;
      }
      
      private function makeUI() : void {
         this.email = new TextInputField("WebLoginDialog.email",false);
         addTextInputField(this.email);
         this.password = new TextInputField("WebLoginDialog.password",true);
         addTextInputField(this.password);
         this.secret = new TextInputField("Secret (Kong/Steam)",true);
         addTextInputField(this.secret);
         this.rememberMeCheckbox = new CheckBoxField("Remember me",false);
         this.rememberMeCheckbox.text_.y = 4;
         this.forgotText = new DeprecatedClickableText(12,false,"WebLoginDialog.forgot");
         h_ = h_ + 12;
         addNavigationText(this.forgotText);
         this.registerText = new DeprecatedClickableText(12,false,"WebLoginDialog.register");
         addNavigationText(this.registerText);
         rightButton_.addEventListener("click",this.onSignIn);
         addEventListener("keyDown",this.onKeyDown);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function onSignInSub() : void {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.isEmailValid() && this.isPasswordValid()) {
            _loc1_ = new AccountData();
            _loc1_.username = this.email.text();
            _loc1_.password = this.password.text();
            _loc1_.secret = this.secret.text();
            this.signIn.dispatch(_loc1_);
         } else if(this.password.text() == "" && this.email.text().indexOf(":") != -1) {
            _loc1_ = new AccountData();
            _loc2_ = this.email.text().split(":");
            if(_loc2_.length == 2) {
               _loc1_.username = _loc2_[0];
               _loc1_.password = _loc2_[1];
               _loc1_.secret = "";
               this.signIn.dispatch(_loc1_);
            }
         }
      }
      
      private function isPasswordValid() : Boolean {
         var _loc1_:* = this.password.text() != "";
         var _loc2_:* = this.secret.text() != "";
         if(_loc1_) {
            return true;
         }
         if(_loc2_) {
            return true;
         }
         if(!_loc1_) {
            this.password.setError("WebLoginDialog.passwordError");
         }
         return false;
      }
      
      private function isEmailValid() : Boolean {
         var _loc1_:* = this.email.text() != "";
         if(!_loc1_) {
            this.email.setError("WebLoginDialog.emailError");
         }
         return _loc1_;
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("keyDown",this.onKeyDown);
         removeEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == 13) {
            this.onSignInSub();
         }
      }
      
      private function onSignIn(param1:MouseEvent) : void {
         this.onSignInSub();
      }
   }
}
