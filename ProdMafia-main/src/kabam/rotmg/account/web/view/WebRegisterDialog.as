package kabam.rotmg.account.web.view {
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.util.EmailValidator;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.account.ui.components.DateField;
   import kabam.rotmg.account.web.model.AccountData;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class WebRegisterDialog extends Frame {
       
      
      private const errors:Array = [];
      
      public var register:Signal;
      
      public var signIn:Signal;
      
      public var cancel:Signal;
      
      private var emailInput:LabeledField;
      
      private var passwordInput:LabeledField;
      
      private var retypePasswordInput:LabeledField;
      
      private var playerNameInput:LabeledField;
      
      private var ageVerificationInput:DateField;
      
      private var signInText:TextFieldDisplayConcrete;
      
      private var tosText:TextFieldDisplayConcrete;
      
      private var endLink:String = "</a></font>";
      
      public function WebRegisterDialog() {
         super("Register an account to play Realm of the Mad God","RegisterWebAccountDialog.leftButton","RegisterWebAccountDialog.rightButton","/registerAccount",326);
         this.makeUIElements();
         this.makeSignals();
      }
      
      public function makeSignInText() : void {
         this.signInText = new TextFieldDisplayConcrete();
         this.signInText.setStringBuilder(new LineBuilder().setParams("WebRegister.sign_in_text",{
            "signIn":"<font color=\"#7777EE\"><a href=\"event:flash.events.TextEvent\">",
            "_signIn":this.endLink
         }));
         this.signInText.addEventListener("link",this.linkEvent);
         this.configureTextAndAdd(this.signInText);
      }
      
      public function makeTosText() : void {
         this.tosText = new TextFieldDisplayConcrete();
         this.tosText.setStringBuilder(new LineBuilder().setParams("WebRegister.tos_text",{
            "tou":"<font color=\"#7777EE\"><a href=\"http://legal.decagames.com/tos/\" target=\"_blank\">",
            "_tou":this.endLink,
            "policy":"<font color=\"#7777EE\"><a href=\"http://legal.decagames.com/privacy/\" target=\"_blank\">",
            "_policy":this.endLink
         }));
         this.configureTextAndAdd(this.tosText);
      }
      
      public function configureTextAndAdd(param1:TextFieldDisplayConcrete) : void {
         param1.setSize(12).setColor(11776947).setBold(true);
         param1.setTextWidth(275);
         param1.setMultiLine(true).setWordWrap(true).setHTML(true);
         param1.filters = [new DropShadowFilter(0,0,0)];
         addChild(param1);
         positionText(param1);
      }
      
      public function displayErrors() : void {
         if(this.errors.length == 0) {
            this.clearErrors();
         } else {
            this.displayErrorText(this.errors.length == 1?this.errors[0]:"WebRegister.multiple_errors_message");
         }
      }
      
      public function displayServerError(param1:String) : void {
         this.displayErrorText(param1);
      }
      
      private function makeUIElements() : void {
         this.playerNameInput = new LabeledField("Player Name",false,275);
         this.playerNameInput.inputText_.maxChars = 10;
         this.playerNameInput.inputText_.restrict = "A-Za-z";
         this.emailInput = new LabeledField("RegisterWebAccountDialog.email",false,275);
         this.passwordInput = new LabeledField("RegisterWebAccountDialog.password",true,275);
         this.retypePasswordInput = new LabeledField("Confirm Password",true,275);
         this.ageVerificationInput = new DateField();
         this.ageVerificationInput.setTitle("WebRegister.birthday");
         addLabeledField(this.playerNameInput);
         addLabeledField(this.emailInput);
         addLabeledField(this.passwordInput);
         addLabeledField(this.retypePasswordInput);
         addComponent(this.ageVerificationInput,17);
         addSpace(35);
         addSpace(17);
         this.makeTosText();
         addSpace(34);
         this.makeSignInText();
      }
      
      private function makeSignals() : void {
         this.cancel = new NativeMappedSignal(leftButton_,"click");
         rightButton_.addEventListener("click",this.onRegister);
         this.register = new Signal(AccountData);
         this.signIn = new Signal();
      }
      
      private function areInputsValid() : Boolean {
         this.errors.length = 0;
         var _loc1_:Boolean = true;
         _loc1_ = this.isEmailValid() && _loc1_;
         _loc1_ = this.isPasswordValid() && _loc1_;
         _loc1_ = this.isPasswordVerified() && _loc1_;
         _loc1_ = this.isPlayerNameValid() && _loc1_;
         _loc1_ = this.isAgeVerified() && _loc1_;
         return this.isAgeValid() && _loc1_;
      }
      
      private function isAgeVerified() : Boolean {
         var _loc2_:uint = DateFieldValidator.getPlayerAge(this.ageVerificationInput);
         var _loc1_:* = _loc2_ >= 16;
         this.ageVerificationInput.setErrorHighlight(!_loc1_);
         if(!_loc1_) {
            this.errors.push("WebRegister.ineligible_age");
         }
         return _loc1_;
      }
      
      private function isAgeValid() : Boolean {
         var _loc1_:Boolean = this.ageVerificationInput.isValidDate();
         this.ageVerificationInput.setErrorHighlight(!_loc1_);
         if(!_loc1_) {
            this.errors.push("WebRegister.invalid_birthdate");
         }
         return _loc1_;
      }
      
      private function isEmailValid() : Boolean {
         var _loc1_:Boolean = EmailValidator.isValidEmail(this.emailInput.text());
         this.emailInput.setErrorHighlight(!_loc1_);
         if(!_loc1_) {
            this.errors.push("WebRegister.invalid_email_address");
         }
         return _loc1_;
      }
      
      private function isPasswordValid() : Boolean {
         var _loc1_:* = this.passwordInput.text().length >= 5;
         this.passwordInput.setErrorHighlight(!_loc1_);
         if(!_loc1_) {
            this.errors.push("WebRegister.password_too_short");
         }
         return _loc1_;
      }
      
      private function isPasswordVerified() : Boolean {
         var _loc1_:* = this.passwordInput.text() == this.retypePasswordInput.text();
         this.retypePasswordInput.setErrorHighlight(!_loc1_);
         if(!_loc1_) {
            this.errors.push("WebRegister.passwords_dont_match");
         }
         return _loc1_;
      }
      
      private function isPlayerNameValid() : Boolean {
         var _loc1_:Boolean = this.playerNameInput.text() != "" && this.playerNameInput.text().length <= 10;
         this.playerNameInput.setErrorHighlight(!_loc1_);
         if(!_loc1_) {
            this.errors.push("Invalid Player Name");
         }
         return _loc1_;
      }
      
      private function clearErrors() : void {
         titleText_.setStringBuilder(new LineBuilder().setParams("Register an account to play Realm of the Mad God"));
         titleText_.setColor(11776947);
      }
      
      private function displayErrorText(param1:String) : void {
         titleText_.setStringBuilder(new LineBuilder().setParams(param1));
         titleText_.setColor(16549442);
      }
      
      private function sendData() : void {
         var _loc1_:AccountData = new AccountData();
         _loc1_.username = this.emailInput.text();
         _loc1_.password = this.passwordInput.text();
         _loc1_.name = this.playerNameInput.text();
         this.register.dispatch(_loc1_);
      }
      
      private function linkEvent(param1:TextEvent) : void {
         this.signIn.dispatch();
      }
      
      private function onRegister(param1:MouseEvent) : void {
         var _loc2_:Boolean = this.areInputsValid();
         this.displayErrors();
         if(_loc2_) {
            this.sendData();
         }
      }
   }
}
