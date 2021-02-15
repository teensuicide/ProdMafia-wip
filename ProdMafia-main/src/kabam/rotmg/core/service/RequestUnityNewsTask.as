package kabam.rotmg.core.service {
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import robotlegs.bender.framework.api.ILogger;
   
   public class RequestUnityNewsTask extends BaseTask {
       
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      public function RequestUnityNewsTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.setMaxRetries(2);
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/unityNews/getNews",{
            "guid":"",
            "password":""
         },true);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         completeTask(param1,param2);
      }
   }
}
