package kabam.rotmg.account.securityQuestions.view {
   import com.company.assembleegameclient.account.ui.Frame;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class SecurityQuestionsConfirmDialog extends Frame {
       
      
      private var infoText:TextFieldDisplayConcrete;
      
      private var questionsList:Array;
      
      private var answerList:Array;
      
      public function SecurityQuestionsConfirmDialog(param1:Array, param2:Array) {
         this.questionsList = param1;
         this.answerList = param2;
         super("SecurityQuestionsConfirmDialog.title","SecurityQuestionsConfirmDialog.leftButton","SecurityQuestionsConfirmDialog.rightButton");
         this.createAssets();
      }
      
      public function dispose() : void {
      }
      
      public function setInProgressMessage() : void {
         titleText_.setStringBuilder(new LineBuilder().setParams("SecurityQuestionsDialog.savingInProgress"));
         titleText_.setColor(11776947);
      }
      
      public function setError(param1:String) : void {
         titleText_.setStringBuilder(new LineBuilder().setParams(param1));
         titleText_.setColor(16549442);
      }
      
      private function createAssets() : void {
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var _loc2_:String = "";
         var _loc4_:* = this.questionsList;
         var _loc7_:int = 0;
         var _loc6_:* = this.questionsList;
         for each(_loc3_ in this.questionsList) {
            _loc2_ = _loc2_ + ("<font color=\"#7777EE\">" + LineBuilder.getLocalizedStringFromKey(_loc3_) + "</font>\n");
            _loc2_ = _loc2_ + (this.answerList[_loc1_] + "\n\n");
            _loc1_++;
         }
         _loc2_ = _loc2_ + LineBuilder.getLocalizedStringFromKey("SecurityQuestionsConfirmDialog.text");
         this.infoText = new TextFieldDisplayConcrete();
         this.infoText.setStringBuilder(new LineBuilder().setParams(_loc2_));
         this.infoText.setSize(12).setColor(11776947).setBold(true);
         this.infoText.setTextWidth(250);
         this.infoText.setMultiLine(true).setWordWrap(true).setHTML(true);
         this.infoText.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.infoText);
         this.infoText.y = 40;
         this.infoText.x = 17;
         h_ = 280;
      }
   }
}
