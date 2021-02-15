package kabam.rotmg.account.web.view {
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.assembleegameclient.account.ui.TextInputField;
   import com.company.assembleegameclient.ui.DeprecatedClickableText;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.account.web.model.AccountData;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class WebLoginDialogForced extends Frame {
       
      
      public var signInForced:Signal;
      
      public var forgot:Signal;
      
      public var register:Signal;
      
      public var email:TextInputField;
      
      private var password:TextInputField;
      
      private var forgotText:DeprecatedClickableText;
      
      private var registerText:DeprecatedClickableText;
      
      public function WebLoginDialogForced(param1:Boolean = false) {
         super("WebLoginDialog.title","","WebLoginDialog.rightButton","/signIn");
         this.makeUI();
         if(param1) {
            addChild(this.getText("Attention!",-165,-85).setColor(16711680));
            addChild(this.getText("A new password was sent to your Sign In Email Address.",-165,-65));
            addChild(this.getText("Please use the new password to Sign In.",-165,-45));
         }
         this.forgot = new NativeMappedSignal(this.forgotText,"click");
         this.register = new NativeMappedSignal(this.registerText,"click");
         this.signInForced = new Signal(AccountData);
      }
      
      public function setError(param1:String) : void {
         this.password.setError(param1);
      }
      
      public function getText(param1:String, param2:int, param3:int) : TextFieldDisplayConcrete {
         var _loc4_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(600);
         _loc4_.setBold(true);
         _loc4_.setStringBuilder(new StaticStringBuilder(param1));
         _loc4_.setSize(16).setColor(16777215);
         _loc4_.setWordWrap(true);
         _loc4_.setMultiLine(true);
         _loc4_.setAutoSize("center");
         _loc4_.setHorizontalAlign("center");
         _loc4_.filters = [new DropShadowFilter(0,0,0)];
         _loc4_.x = param2;
         _loc4_.y = param3;
         return _loc4_;
      }
      
      private function makeUI() : void {
         this.email = new TextInputField("WebLoginDialog.email",false);
         addTextInputField(this.email);
         this.password = new TextInputField("WebLoginDialog.password",true);
         addTextInputField(this.password);
         this.forgotText = new DeprecatedClickableText(12,false,"WebLoginDialog.forgot");
         addNavigationText(this.forgotText);
         this.registerText = new DeprecatedClickableText(12,false,"WebLoginDialog.register");
         addNavigationText(this.registerText);
         rightButton_.addEventListener("click",this.onSignIn);
         addEventListener("keyDown",this.onKeyDown);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function onSignInSub() : void {
         var _loc1_:* = null;
         if(this.isEmailValid() && this.isPasswordValid()) {
            _loc1_ = new AccountData();
            _loc1_.username = this.email.text();
            _loc1_.password = this.password.text();
            this.signInForced.dispatch(_loc1_);
         }
      }
      
      private function isPasswordValid() : Boolean {
         var _loc1_:* = this.password.text() != "";
         if(!_loc1_) {
            this.password.setError("WebLoginDialog.passwordError");
         }
         return _loc1_;
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
