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
   import kabam.rotmg.legends.model.LegendsModel;
   import kabam.rotmg.legends.model.Timespan;
   
   public class GetChallengerListTask extends BaseTask {
      
      public static const REFRESH_INTERVAL_IN_MILLISECONDS:Number = 300000;
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var model:LegendsModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var factory:LegendFactory;
      
      [Inject]
      public var seasonalItemDataFactory:SeasonalItemDataFactory;
      
      [Inject]
      public var timespan:Timespan;
      
      [Inject]
      public var listType:String;
      
      [Inject]
      public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
      
      public var charId:int;
      
      public function GetChallengerListTask() {
         super();
      }
      
      override protected function startTask() : void {
         this.client.complete.addOnce(this.onComplete);
         if(this.listType == "Top 20") {
            this.client.sendRequest("/fame/challengerLeaderboard",this.makeRequestObject());
         } else if(this.listType == "Your Position") {
            this.client.sendRequest("/fame/challengerAccountLeaderboard?account=" + this.account.getUserName(),this.makeRequestObject());
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
         var _loc4_:Date = new Date(_loc2_.GeneratedOn * 1000);
         var _loc5_:Number = _loc4_.getTimezoneOffset() * 60 * 1000;
         _loc4_.setTime(_loc4_.getTime() - _loc5_);
         var _loc3_:Date = new Date();
         _loc3_.setTime(_loc3_.getTime() + 300000);
         var _loc6_:Vector.<SeasonalLeaderBoardItemData> = this.seasonalItemDataFactory.createSeasonalLeaderBoardItemDatas(XML(param1));
         if(this.listType == "Top 20") {
            this.seasonalEventModel.leaderboardTop20ItemDatas = _loc6_;
            this.seasonalEventModel.leaderboardTop20RefreshTime = _loc3_;
            this.seasonalEventModel.leaderboardTop20CreateTime = _loc4_;
         } else if(this.listType == "Your Position") {
            _loc6_.sort(this.fameSort);
            this.seasonalEventModel.leaderboardPlayerItemDatas = _loc6_;
            this.seasonalEventModel.leaderboardPlayerRefreshTime = _loc3_;
            this.seasonalEventModel.leaderboardPlayerCreateTime = _loc4_;
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
         _loc1_.timespan = this.timespan.getId();
         _loc1_.accountId = this.player.getAccountId();
         _loc1_.charId = this.charId;
         return _loc1_;
      }
   }
}
