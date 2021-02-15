package io.decagames.rotmg.seasonalEvent.tasks {
   import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalItemDataFactory;
   import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.legends.model.LegendFactory;
   
   public class GetLegacyChallengerListTask extends BaseTask {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var factory:LegendFactory;
      
      [Inject]
      public var seasonalItemDataFactory:SeasonalItemDataFactory;
      
      [Inject]
      public var seasonId:String;
      
      [Inject]
      public var isTop20:Boolean;
      
      [Inject]
      public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
      
      public var charId:int;
      
      public function GetLegacyChallengerListTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         if(this.seasonId != "" && this.seasonId != null) {
            if(this.isTop20) {
               this.client.sendRequest("/fame/challengerLeaderboard?season=" + this.seasonId,this.makeRequestObject());
            } else {
               this.client.sendRequest("/fame/challengerAccountLeaderboard?season=" + this.seasonId + "&account=" + this.account.getUserName(),this.makeRequestObject());
            }
         }
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.updateFameListData(param2);
         } else {
            this.onFameListError(param2);
         }
      }
      
      private function onFameListError(param1:String) : void {
         this.seasonalLeaderBoardErrorSignal.dispatch(param1);
         completeTask(true);
      }
      
      private function updateFameListData(param1:String) : void {
         var _loc2_:XML = XML(param1);
         var _loc3_:Vector.<SeasonalLeaderBoardItemData> = this.seasonalItemDataFactory.createSeasonalLeaderBoardItemDatas(XML(param1));
         if(this.isTop20) {
            this.seasonalEventModel.leaderboardLegacyTop20ItemDatas = _loc3_;
         } else {
            _loc3_.sort(this.fameSort);
            this.seasonalEventModel.leaderboardLegacyPlayerItemDatas = _loc3_;
         }
         completeTask(true);
      }
      
      private function fameSort(param1:SeasonalLeaderBoardItemData, param2:SeasonalLeaderBoardItemData) : int {
         if(param1.totalFame > param2.totalFame) {
            return -1;
         }
         if(param1.totalFame < param2.totalFame) {
            return 1;
         }
         return 0;
      }
      
      private function makeRequestObject() : Object {
         var _loc1_:* = {};
         _loc1_.accountId = this.player.getAccountId();
         _loc1_.charId = this.charId;
         return _loc1_;
      }
   }
}
