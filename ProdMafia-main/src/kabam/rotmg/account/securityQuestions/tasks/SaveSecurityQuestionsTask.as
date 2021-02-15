package kabam.rotmg.account.securityQuestions.tasks {
   import com.company.util.MoreObjectUtil;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.securityQuestions.data.SecurityQuestionsData;
   import kabam.rotmg.appengine.api.AppEngineClient;
   
   public class SaveSecurityQuestionsTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var data:SecurityQuestionsData;
      
      [Inject]
      public var client:AppEngineClient;
      
      public function SaveSecurityQuestionsTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/saveSecurityQuestions",this.makeDataPacket());
      }
      
      private function makeDataPacket() : Object {
         var _loc1_:* = {};
         _loc1_.answers = this.data.answers.join("|");
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         return _loc1_;
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         param1 = param1 || param2 == "<Success/>";
         completeTask(param1,param2);
      }
   }
}
