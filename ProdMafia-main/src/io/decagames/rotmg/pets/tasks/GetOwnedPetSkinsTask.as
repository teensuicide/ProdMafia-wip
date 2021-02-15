package io.decagames.rotmg.pets.tasks {
   import com.company.util.MoreObjectUtil;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GetOwnedPetSkinsTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var petModel:PetsModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      public function GetOwnedPetSkinsTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.logger.info("GetOwnedPetSkinsTask start");
         if(!this.account.isRegistered()) {
            this.logger.info("Guest account - skip skins check");
            completeTask(true,"");
         } else {
            this.client.complete.addOnce(this.onComplete);
            this.client.sendRequest("/account/getOwnedPetSkins",this.makeDataPacket());
         }
      }
      
      private function makeDataPacket() : Object {
         var _loc1_:* = {};
         _loc1_.game_net_user_id = this.account.gameNetworkUserId();
         _loc1_.game_net = this.account.gameNetwork();
         _loc1_.play_platform = this.account.playPlatform();
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         return _loc1_;
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         var _loc3_:* = param1;
         var _loc4_:* = param2;
         _loc3_ = _loc3_ || _loc4_ == "<Success/>";
         if(_loc3_) {
            try {
               this.petModel.parseOwnedSkins(XML(_loc4_));
            }
            catch(e:Error) {
               logger.error(e.message + " " + e.getStackTrace());
            }
            this.petModel.parsePetsData();
         }
         completeTask(_loc3_,_loc4_);
      }
   }
}
