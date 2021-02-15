package kabam.rotmg.core.service {
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   
   public class UnityLauncherLoginTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      public function UnityLauncherLoginTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         if(this.account.getPassword() == "" || this.account.getPassword() == null) {
            this.client.sendRequest("/account/verify",{
               "guid":"",
               "password":""
            },true);
            return;
         }
         if(this.account.getSecret() != "") {
            this.client.sendRequest("/account/verify",{
               "guid":this.account.getUserId(),
               "secret":this.account.getSecret()
            },true);
         } else {
            this.client.sendRequest("/account/verify",this.account.getCredentials(),true);
         }
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         completeTask(true,param2);
      }
   }
}
