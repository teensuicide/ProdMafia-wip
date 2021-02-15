package io.decagames.rotmg.supportCampaign.tasks {
   import com.company.util.MoreObjectUtil;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GetCampaignStatusTask extends BaseTask {
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var model:SupporterCampaignModel;
      
      public function GetCampaignStatusTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.logger.info("GetCampaignStatus start");
         var _loc1_:Object = this.account.getCredentials();
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         _loc1_.game_net_user_id = this.account.gameNetworkUserId();
         _loc1_.game_net = this.account.gameNetwork();
         _loc1_.play_platform = this.account.playPlatform();
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest("/supportCampaign/status",_loc1_);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.onCampaignUpdate(param2);
         } else {
            this.onTextError(param2);
         }
      }
      
      private function onTextError(param1:String) : void {
         this.logger.info("GetCampaignStatus error");
         completeTask(true);
      }
      
      private function onCampaignUpdate(param1:String) : void {
         var _loc3_:* = null;
         var _loc2_:* = param1;
         try {
            _loc3_ = new XML(_loc2_);
         }
         catch(e:Error) {
            logger.error("Error parsing campaign data: " + _loc2_);
            completeTask(true);
            return;
         }
         this.logger.info("GetCampaignStatus update");
         this.logger.info(_loc3_);
         this.model.parseConfigData(_loc3_);
         completeTask(true);
      }
   }
}
