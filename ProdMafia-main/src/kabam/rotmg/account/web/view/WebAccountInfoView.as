package kabam.rotmg.account.web.view {
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.account.core.view.AccountInfoView;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class WebAccountInfoView extends Sprite implements AccountInfoView {
      
      private static const FONT_SIZE:int = 18;
       
      
      private var userName:String = "";
      
      private var isRegistered:Boolean;
      
      private var accountText:TextFieldDisplayConcrete;
      
      private var registerButton:TitleMenuOption;
      
      private var loginButton:TitleMenuOption;
      
      private var resetButton:TitleMenuOption;
      
      private var _login:Signal;
      
      private var _register:Signal;
      
      private var _reset:Signal;
      
      public function WebAccountInfoView() {
         super();
         this.makeUIElements();
         this.makeSignals();
      }
      
      public function get login() : Signal {
         return this._login;
      }
      
      public function get register() : Signal {
         return this._register;
      }
      
      public function get reset() : Signal {
         return this._reset;
      }
      
      public function setInfo(param1:String, param2:Boolean) : void {
         this.userName = param1;
         this.isRegistered = param2;
         this.updateUI();
      }
      
      private function makeUIElements() : void {
         this.makeAccountText();
         this.makeLoginButton();
         this.makeRegisterButton();
         this.makeResetButton();
      }
      
      private function makeSignals() : void {
         this._login = new NativeMappedSignal(this.loginButton,"click");
         this._register = new NativeMappedSignal(this.registerButton,"click");
         this._reset = new NativeMappedSignal(this.resetButton,"click");
      }
      
      private function makeAccountText() : void {
         this.accountText = this.makeTextFieldConcrete();
      }
      
      private function makeTextFieldConcrete() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete();
         _loc1_.setAutoSize("right");
         _loc1_.setSize(18).setColor(11776947);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         return _loc1_;
      }
      
      private function makeLoginButton() : void {
         this.loginButton = new TitleMenuOption("AccountInfo.log_in",18,false);
         this.loginButton.setAutoSize("right");
      }
      
      private function makeResetButton() : void {
         this.resetButton = new TitleMenuOption("reset",18,false);
         this.resetButton.setAutoSize("right");
      }
      
      private function makeRegisterButton() : void {
         this.registerButton = new TitleMenuOption("AccountInfo.register",18,false);
         this.registerButton.setAutoSize("right");
      }
      
      private function makeDividerText() : DisplayObject {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _loc1_.setColor(11776947).setAutoSize("right").setSize(18);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,4,4)];
         _loc1_.setStringBuilder(new StaticStringBuilder(" - "));
         return _loc1_;
      }
      
      private function updateUI() : void {
         this.removeUIElements();
         if(this.isRegistered) {
            this.showUIForRegisteredAccount();
         } else {
            this.showUIForGuestAccount();
         }
      }
      
      private function removeUIElements() : void {
         while(numChildren) {
            removeChildAt(0);
         }
      }
      
      private function showUIForRegisteredAccount() : void {
         this.accountText.setStringBuilder(new LineBuilder().setParams("AccountInfo.loggedIn",{"userName":this.userName}));
         this.loginButton.setTextKey("AccountInfo.log_out");
         this.addAndAlignHorizontally(this.accountText,this.loginButton);
      }
      
      private function showUIForGuestAccount() : void {
         this.loginButton.setTextKey("AccountInfo.log_in");
         this.addAndAlignHorizontally(this.registerButton,this.makeDividerText(),this.loginButton);
      }
      
      private function addAndAlignHorizontally(... rest) : void {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:* = rest;
         for each(_loc2_ in rest) {
            addChild(_loc2_);
         }
         _loc3_ = 0;
         _loc4_ = rest.length;
         while(_loc4_--) {
            _loc5_ = rest[_loc4_];
            _loc5_.x = _loc3_;
            _loc3_ = _loc3_ - _loc5_.width;
         }
      }
   }
}
