package io.decagames.rotmg.seasonalEvent.data {
   import com.company.assembleegameclient.screens.LeagueData;
   import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardItemData;
   import io.decagames.rotmg.seasonalEvent.config.SeasonalConfig;
   import robotlegs.bender.framework.api.IContext;
   
   public class SeasonalEventModel {
       
      
      [Inject]
      public var context:IContext;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      private var _isSeasonalMode:Boolean;
      
      private var _leagueDatas:Vector.<LeagueData>;
      
      private var _seasonTitle:String;
      
      private var _isChallenger:int = 0;
      
      private var _rulesAndDescription:String;
      
      private var _scheduledSeasonalEvent:Date;
      
      private var _accountCreatedBefore:Date;
      
      private var _maxCharacters:int;
      
      private var _maxPetYardLevel:int;
      
      private var _remainingCharacters:int;
      
      private var _leaderboardTop20RefreshTime:Date;
      
      private var _leaderboardTop20CreateTime:Date;
      
      private var _leaderboardPlayerRefreshTime:Date;
      
      private var _leaderboardPlayerCreateTime:Date;
      
      private var _leaderboardTop20ItemDatas:Vector.<SeasonalLeaderBoardItemData>;
      
      private var _leaderboardLegacyTop20ItemDatas:Vector.<SeasonalLeaderBoardItemData>;
      
      private var _leaderboardPlayerItemDatas:Vector.<SeasonalLeaderBoardItemData>;
      
      private var _leaderboardLegacyPlayerItemDatas:Vector.<SeasonalLeaderBoardItemData>;
      
      private var _legacySeasons:Vector.<LegacySeasonData>;
      
      public function SeasonalEventModel() {
         super();
      }
      
      public function get isSeasonalMode() : Boolean {
         return this._isSeasonalMode;
      }
      
      public function set isSeasonalMode(param1:Boolean) : void {
         this._isSeasonalMode = param1;
      }
      
      public function get leagueDatas() : Vector.<LeagueData> {
         return this._leagueDatas;
      }
      
      public function get seasonTitle() : String {
         return this._seasonTitle;
      }
      
      public function get isChallenger() : int {
         return this._isChallenger;
      }
      
      public function set isChallenger(param1:int) : void {
         this._isChallenger = param1;
      }
      
      public function get rulesAndDescription() : String {
         return this._rulesAndDescription;
      }
      
      public function get scheduledSeasonalEvent() : Date {
         return this._scheduledSeasonalEvent;
      }
      
      public function get accountCreatedBefore() : Date {
         return this._accountCreatedBefore;
      }
      
      public function get maxCharacters() : int {
         return this._maxCharacters;
      }
      
      public function get maxPetYardLevel() : int {
         return this._maxPetYardLevel;
      }
      
      public function get remainingCharacters() : int {
         return this._remainingCharacters;
      }
      
      public function set remainingCharacters(param1:int) : void {
         this._remainingCharacters = param1;
      }
      
      public function get leaderboardTop20RefreshTime() : Date {
         return this._leaderboardTop20RefreshTime;
      }
      
      public function set leaderboardTop20RefreshTime(param1:Date) : void {
         this._leaderboardTop20RefreshTime = param1;
      }
      
      public function get leaderboardTop20CreateTime() : Date {
         return this._leaderboardTop20CreateTime;
      }
      
      public function set leaderboardTop20CreateTime(param1:Date) : void {
         this._leaderboardTop20CreateTime = param1;
      }
      
      public function get leaderboardPlayerRefreshTime() : Date {
         return this._leaderboardPlayerRefreshTime;
      }
      
      public function set leaderboardPlayerRefreshTime(param1:Date) : void {
         this._leaderboardPlayerRefreshTime = param1;
      }
      
      public function get leaderboardPlayerCreateTime() : Date {
         return this._leaderboardPlayerCreateTime;
      }
      
      public function set leaderboardPlayerCreateTime(param1:Date) : void {
         this._leaderboardPlayerCreateTime = param1;
      }
      
      public function get leaderboardTop20ItemDatas() : Vector.<SeasonalLeaderBoardItemData> {
         return this._leaderboardTop20ItemDatas;
      }
      
      public function set leaderboardTop20ItemDatas(param1:Vector.<SeasonalLeaderBoardItemData>) : void {
         this._leaderboardTop20ItemDatas = param1;
      }
      
      public function get leaderboardLegacyTop20ItemDatas() : Vector.<SeasonalLeaderBoardItemData> {
         return this._leaderboardLegacyTop20ItemDatas;
      }
      
      public function set leaderboardLegacyTop20ItemDatas(param1:Vector.<SeasonalLeaderBoardItemData>) : void {
         this._leaderboardLegacyTop20ItemDatas = param1;
      }
      
      public function get leaderboardPlayerItemDatas() : Vector.<SeasonalLeaderBoardItemData> {
         return this._leaderboardPlayerItemDatas;
      }
      
      public function set leaderboardPlayerItemDatas(param1:Vector.<SeasonalLeaderBoardItemData>) : void {
         this._leaderboardPlayerItemDatas = param1;
      }
      
      public function get leaderboardLegacyPlayerItemDatas() : Vector.<SeasonalLeaderBoardItemData> {
         return this._leaderboardLegacyPlayerItemDatas;
      }
      
      public function set leaderboardLegacyPlayerItemDatas(param1:Vector.<SeasonalLeaderBoardItemData>) : void {
         this._leaderboardLegacyPlayerItemDatas = param1;
      }
      
      public function get legacySeasons() : Vector.<LegacySeasonData> {
         return this._legacySeasons;
      }
      
      public function parseConfigData(param1:XML) : void {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         var _loc2_:XMLList = param1.Season;
         if(_loc2_.length() > 0) {
            this._leagueDatas = new Vector.<LeagueData>(0);
            _loc5_ = 0;
            _loc4_ = _loc2_;
            var _loc9_:int = 0;
            var _loc8_:* = _loc2_;
            for each(_loc7_ in _loc2_) {
               this._startTime = new Date(_loc7_.Start * 1000);
               this._endTime = new Date(_loc7_.End * 1000);
               this._maxCharacters = _loc7_.MaxLives;
               this._maxPetYardLevel = _loc7_.MaxPetYardLevel;
               this._accountCreatedBefore = new Date(_loc7_.AccountCreatedBefore * 1000);
               if(this.getSecondsToStart(this._startTime) <= 0 && !this.hasSeasonEnded(this._endTime)) {
                  this._rulesAndDescription = _loc7_.Information;
                  _loc6_ = new LeagueData();
                  _loc6_.maxCharacters = this._maxCharacters;
                  _loc6_.leagueType = 1;
                  _loc3_ = _loc7_.@title;
                  this._seasonTitle = _loc3_;
                  _loc6_.title = _loc3_;
                  _loc6_.endDate = this._endTime;
                  _loc6_.description = _loc7_.Description;
                  _loc6_.quote = "";
                  _loc6_.panelBackgroundId = "game_mode_challenger_panel";
                  _loc6_.characterId = "game_mode_challenger_character";
                  this._leagueDatas.push(_loc6_);
                  this._isSeasonalMode = true;
               } else if(this.getSecondsToStart(this._startTime) > 0) {
                  this._isSeasonalMode = false;
                  this.setScheduledStartTime(this._startTime);
               } else {
                  this._isSeasonalMode = false;
               }
            }
            if(this._leagueDatas.length > 0) {
               this._leagueDatas.unshift(this.addLegacyLeagueData());
            }
         }
         if(this._isSeasonalMode) {
            this.context.configure(SeasonalConfig);
         }
      }
      
      public function parseLegacySeasonsData(param1:XML) : void {
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:XMLList = param1.Season;
         if(_loc2_.length() > 0) {
            this._legacySeasons = new Vector.<LegacySeasonData>(0);
            _loc4_ = 0;
            _loc6_ = _loc2_;
            var _loc8_:int = 0;
            var _loc7_:* = _loc2_;
            for each(_loc5_ in _loc2_) {
               _loc3_ = new LegacySeasonData();
               _loc3_.seasonId = _loc5_.@id;
               _loc3_.title = _loc5_.Title;
               _loc3_.active = _loc5_.hasOwnProperty("Active");
               _loc3_.timeValid = _loc5_.hasOwnProperty("TimeValid");
               _loc3_.hasLeaderBoard = _loc5_.hasOwnProperty("HasLeaderboard");
               _loc3_.startTime = new Date(_loc5_.StartTime * 1000);
               _loc3_.endTime = new Date(_loc5_.EndTime * 1000);
               this._legacySeasons.push(_loc3_);
            }
         }
      }
      
      public function getSeasonIdByTitle(param1:String) : String {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc5_:int = this._legacySeasons.length;
         while(_loc4_ < _loc5_) {
            _loc3_ = this._legacySeasons[_loc4_];
            if(_loc3_.title == param1) {
               _loc2_ = _loc3_.seasonId;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function setScheduledStartTime(param1:Date) : void {
         this._scheduledSeasonalEvent = param1;
      }
      
      private function getSecondsToStart(param1:Date) : Number {
         var _loc2_:Date = new Date();
         return (param1.time - _loc2_.time) / 1000;
      }
      
      private function hasSeasonEnded(param1:Date) : Boolean {
         var _loc2_:Date = new Date();
         return (param1.time - _loc2_.time) / 1000 <= 0;
      }
      
      private function addLegacyLeagueData() : LeagueData {
         var _loc1_:LeagueData = new LeagueData();
         _loc1_.maxCharacters = -1;
         _loc1_.leagueType = 0;
         _loc1_.title = "Original";
         _loc1_.description = "The original Realm of the Mad God. This is a gathering place for every Hero in the Realm of the Mad God.";
         _loc1_.quote = "The experience you have come to know, all your previous progress and achievements.";
         _loc1_.panelBackgroundId = "game_mode_legacy_panel";
         _loc1_.characterId = "game_mode_legacy_character";
         return _loc1_;
      }
   }
}
