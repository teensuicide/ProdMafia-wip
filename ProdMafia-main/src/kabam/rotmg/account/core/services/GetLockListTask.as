package kabam.rotmg.account.core.services {
   import com.company.util.MoreObjectUtil;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.model.PlayerModel;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GetLockListTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var logger:ILogger;
      
      private var requestData:Object;
      
      public function GetLockListTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.logger.info("GetLockListTask start");
         this.requestData = this.makeRequestData();
         sendRequest();
      }
      
      public function makeRequestData() : Object {
         var _loc1_:Object = {};
         _loc1_.game_net_user_id = this.account.gameNetworkUserId();
         _loc1_.game_net = this.account.gameNetwork();
         _loc1_.play_platform = this.account.playPlatform();
         _loc1_.type = 0;
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         return _loc1_;
      }
      
      private function sendRequest() : void {
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/account/list",this.requestData);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onListComplete(param2);
         } else {
            model.lockList = new Vector.<String>(0);
         }
         completeTask(true);
      }
      
      private function onListComplete(param1:String) : void {
         var _loc2_:* = null;
         var _loc4_:* = undefined;
         var _loc3_:XML = new XML(param1);
         if("StarredAccounts" in _loc3_) {
            _loc2_ = _loc3_.StarredAccounts[0];
            _loc4_ = Vector.<String>(_loc2_.split(","));
            model.lockList = _loc4_;
         } else {
            model.lockList = new Vector.<String>(0);
         }
      }
   }
}
