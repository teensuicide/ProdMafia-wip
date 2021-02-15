package kabam.rotmg.account.securityQuestions.data {
   public class SecurityQuestionsModel {
       
      
      public var securityQuestionsAnswers:Array;
      
      private var _showSecurityQuestionsOnStartup:Boolean;
      
      private var _securityQuestionsList:Array;
      
      public function SecurityQuestionsModel() {
         securityQuestionsAnswers = [];
         _securityQuestionsList = [];
         super();
      }
      
      public function get showSecurityQuestionsOnStartup() : Boolean {
         return this._showSecurityQuestionsOnStartup;
      }
      
      public function set showSecurityQuestionsOnStartup(param1:Boolean) : void {
         this._showSecurityQuestionsOnStartup = param1;
      }
      
      public function get securityQuestionsList() : Array {
         return this._securityQuestionsList;
      }
      
      public function clearQuestionsList() : void {
         this._securityQuestionsList = [];
      }
      
      public function addSecurityQuestion(param1:String) : void {
         this._securityQuestionsList.push(param1);
      }
   }
}
