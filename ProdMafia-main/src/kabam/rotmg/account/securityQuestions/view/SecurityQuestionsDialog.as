package kabam.rotmg.account.securityQuestions.view {
   import com.company.assembleegameclient.account.ui.Frame;
   import com.company.assembleegameclient.account.ui.TextInputField;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class SecurityQuestionsDialog extends Frame {
       
      
      private const minQuestionLength:int = 3;
      
      private const maxQuestionLength:int = 50;
      
      private var errors:Array;
      
      private var fields:Array;
      
      private var questionsList:Array;
      
      public function SecurityQuestionsDialog(param1:Array, param2:Array) {
         errors = [];
         this.questionsList = param1;
         super("SecurityQuestionsDialog.title","Cancel","SecurityQuestionsDialog.save");
         this.createAssets();
         if(param1.length == param2.length) {
            this.updateAnswers(param2);
         }
      }
      
      override public function disable() : void {
         super.disable();
         titleText_.setStringBuilder(new LineBuilder().setParams("SecurityQuestionsDialog.savingInProgress"));
      }
      
      public function updateAnswers(param1:Array) : void {
         var _loc3_:* = null;
         var _loc2_:int = 1;
         var _loc4_:* = this.fields;
         var _loc7_:int = 0;
         var _loc6_:* = this.fields;
         for each(_loc3_ in this.fields) {
            _loc3_.inputText_.text = param1[_loc2_ - 1];
            _loc2_++;
         }
      }
      
      public function clearErrors() : void {
         var _loc3_:* = null;
         titleText_.setStringBuilder(new LineBuilder().setParams("SecurityQuestionsDialog.title"));
         titleText_.setColor(11776947);
         this.errors = [];
         var _loc1_:* = this.fields;
         var _loc5_:int = 0;
         var _loc4_:* = this.fields;
         for each(_loc3_ in this.fields) {
            _loc3_.setErrorHighlight(false);
         }
      }
      
      public function areQuestionsValid() : Boolean {
         var _loc3_:* = null;
         var _loc1_:* = this.fields;
         var _loc5_:int = 0;
         var _loc4_:* = this.fields;
         for each(_loc3_ in this.fields) {
            if(_loc3_.inputText_.length < 3) {
               this.errors.push("SecurityQuestionsDialog.tooShort");
               _loc3_.setErrorHighlight(true);
               return false;
            }
            if(_loc3_.inputText_.length > 50) {
               this.errors.push("SecurityQuestionsDialog.tooLong");
               _loc3_.setErrorHighlight(true);
               return false;
            }
         }
         return true;
      }
      
      public function displayErrorText() : void {
         var _loc1_:String = this.errors.length == 1?this.errors[0]:"WebRegister.multiple_errors_message";
         this.setError(_loc1_);
      }
      
      public function dispose() : void {
         this.errors = null;
         this.fields = null;
         this.questionsList = null;
      }
      
      public function getAnswers() : Array {
         var _loc1_:* = null;
         var _loc3_:* = [];
         var _loc2_:* = this.fields;
         var _loc6_:int = 0;
         var _loc5_:* = this.fields;
         for each(_loc1_ in this.fields) {
            _loc3_.push(_loc1_.inputText_.text);
         }
         return _loc3_;
      }
      
      public function setError(param1:String) : void {
         titleText_.setStringBuilder(new LineBuilder().setParams(param1,{"min":3}));
         titleText_.setColor(16549442);
      }
      
      private function createAssets() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 1;
         this.fields = [];
         var _loc4_:* = this.questionsList;
         var _loc7_:int = 0;
         var _loc6_:* = this.questionsList;
         for each(_loc1_ in this.questionsList) {
            _loc3_ = new TextInputField(_loc1_,false,240);
            _loc3_.nameText_.setTextWidth(240);
            _loc3_.nameText_.setSize(12);
            _loc3_.nameText_.setWordWrap(true);
            _loc3_.nameText_.setMultiLine(true);
            addTextInputField(_loc3_);
            _loc3_.inputText_.tabEnabled = true;
            _loc3_.inputText_.tabIndex = _loc2_;
            _loc3_.inputText_.maxChars = 50;
            _loc2_++;
            this.fields.push(_loc3_);
         }
         rightButton_.tabIndex = _loc2_ + 1;
         rightButton_.tabEnabled = true;
      }
   }
}
