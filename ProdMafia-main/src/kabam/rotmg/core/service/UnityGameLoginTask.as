package kabam.rotmg.core.service {
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   
   public class UnityGameLoginTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      public function UnityGameLoginTask() {
         super();
      }
      
      override protected function startTask() : void {
         var _loc1_:Object = {
            "game_net":"Unity",
            "play_platform":"Unity",
            "game_net_user_id":""
         };
         this.client.complete.addOnce(this.onComplete);
         _loc1_.guid = this.account.getUserId();
         if(this.account.getSecret() == "" || this.account.getSecret() == null) {
            _loc1_.password = this.account.getPassword();
         } else {
            _loc1_.secret = this.account.getSecret();
         }
         this.client.sendRequest("/account/verify",_loc1_);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         completeTask(true,param2);
      }
   }
}
