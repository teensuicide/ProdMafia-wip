package kabam.rotmg.core.service {
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.application.DynamicSettings;
   import kabam.rotmg.core.signals.AppInitDataReceivedSignal;
   import robotlegs.bender.framework.api.ILogger;
   
   public class RequestAppInitTaskUnity extends BaseTask {
       
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var appInitConfigData:AppInitDataReceivedSignal;
      
      public function RequestAppInitTaskUnity() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.setMaxRetries(2);
         this.client.complete.addOnce(this.onComplete);
         var _loc1_:Object = {
            "guid":"",
            "game_net":"Unity",
            "play_platform":"Unity",
            "game_net_user_id":""
         };
         if(this.account.getSecret() == "" || this.account.getSecret() == null) {
            _loc1_.password = "";
         } else {
            _loc1_.secret = "";
         }
         this.client.sendRequest("/app/init",_loc1_);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         var _loc3_:XML = XML(param2);
         param1 && this.appInitConfigData.dispatch(_loc3_);
         this.initDynamicSettingsClass(_loc3_);
         completeTask(param1,param2);
      }
      
      private function initDynamicSettingsClass(param1:XML) : void {
         if(param1 != null) {
            DynamicSettings.xml = param1;
         }
      }
   }
}
