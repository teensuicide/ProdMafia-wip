package kabam.rotmg.ui.view {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.account.ui.components.DateField;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   
   public class AgeVerificationDialog extends Dialog {
      
      private static const WIDTH:int = 300;
       
      
      private const DEFAULT_FILTER_0:DropShadowFilter = new DropShadowFilter(0,0,0,1,6,6,1);
      
      private const DEFAULT_FILTER_1:DropShadowFilter = new DropShadowFilter(0,0,0,0.5,12,12);
      
      private const BIRTH_DATE_BELOW_MINIMUM_ERROR:String = "AgeVerificationDialog.tooYoung";
      
      private const BIRTH_DATE_INVALID_ERROR:String = "AgeVerificationDialog.invalidBirthDate";
      
      private const MINIMUM_AGE:uint = 16;
      
      public const response:Signal = new Signal(Boolean);
      
      private var ageVerificationField:DateField;
      
      private var errorLabel:TextFieldDisplayConcrete;
      
      public function AgeVerificationDialog() {
         super("AgeVerificationDialog.title","","AgeVerificationDialog.left","AgeVerificationDialog.right","/ageVerificationDialog");
         addEventListener("dialogLeftButton",this.onCancel);
         addEventListener("dialogRightButton",this.onVerify);
      }
      
      override protected function makeUIAndAdd() : void {
         this.makeAgeVerificationAndErrorLabel();
         this.addChildren();
      }
      
      override protected function initText(param1:String) : void {
         textText_ = new TextFieldDisplayConcrete().setSize(14).setColor(11776947);
         textText_.setTextWidth(260);
         textText_.x = 20;
         textText_.setMultiLine(true).setWordWrap(true).setHTML(true);
         textText_.setAutoSize("left");
         textText_.mouseEnabled = true;
         textText_.filters = [DEFAULT_FILTER_0];
         this.setText();
      }
      
      override protected function drawAdditionalUI() : void {
         this.ageVerificationField.y = textText_.getBounds(box_).bottom + 8;
         this.ageVerificationField.x = 20;
         this.errorLabel.y = this.ageVerificationField.y + this.ageVerificationField.height + 8;
         this.errorLabel.x = 20;
      }
      
      private function makeAgeVerificationAndErrorLabel() : void {
         this.makeAgeVerificationField();
         this.makeErrorLabel();
      }
      
      private function addChildren() : void {
         uiWaiter.pushArgs(this.ageVerificationField.getTextChanged());
         box_.addChild(this.ageVerificationField);
         box_.addChild(this.errorLabel);
      }
      
      private function setText() : void {
         textText_.setStringBuilder(new LineBuilder().setParams("AgeVerificationDialog.text",{
            "tou":"<font color=\"#7777EE\"><a href=\"http://legal.decagames.com/tos/\" target=\"_blank\">",
            "_tou":"</a></font>",
            "policy":"<font color=\"#7777EE\"><a href=\"http://legal.decagames.com/privacy/\" target=\"_blank\">",
            "_policy":"</a></font>"
         }));
      }
      
      private function makeAgeVerificationField() : void {
         this.ageVerificationField = new DateField();
         this.ageVerificationField.setTitle("WebRegister.birthday");
      }
      
      private function makeErrorLabel() : void {
         this.errorLabel = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
         this.errorLabel.setMultiLine(true);
         this.errorLabel.filters = [DEFAULT_FILTER_1];
      }
      
      private function getPlayerAge() : uint {
         var _loc2_:Date = new Date(this.getBirthDate());
         var _loc1_:Date = new Date();
         var _loc3_:uint = _loc1_.fullYear - _loc2_.fullYear;
         if(_loc2_.month > _loc1_.month || _loc2_.month == _loc1_.month && _loc2_.date > _loc1_.date) {
            _loc3_--;
         }
         return _loc3_;
      }
      
      private function getBirthDate() : Number {
         return Date.parse(this.ageVerificationField.getDate());
      }
      
      private function onCancel(param1:Event) : void {
         this.response.dispatch(false);
      }
      
      private function onVerify(param1:Event) : void {
         var _loc4_:Boolean = false;
         var _loc2_:uint = this.getPlayerAge();
         var _loc3_:String = "";
         if(!this.ageVerificationField.isValidDate()) {
            _loc3_ = "AgeVerificationDialog.invalidBirthDate";
            _loc4_ = true;
         } else if(_loc2_ < 16 && !_loc4_) {
            _loc3_ = "AgeVerificationDialog.tooYoung";
            _loc4_ = true;
         } else {
            _loc3_ = "";
            _loc4_ = false;
            this.response.dispatch(true);
         }
         this.errorLabel.setStringBuilder(new LineBuilder().setParams(_loc3_));
         this.ageVerificationField.setErrorHighlight(_loc4_);
         drawButtonsAndBackground();
      }
   }
}
