package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import flash.events.Event;
   import io.decagames.rotmg.seasonalEvent.data.LegacySeasonData;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.signals.RequestLegacySeasonSignal;
   import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.legends.control.FameListUpdateSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class SeasonalLegacyLeaderBoardMediator extends Mediator {
       
      
      [Inject]
      public var view:SeasonalLegacyLeaderBoard;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
      
      [Inject]
      public var requestLegacySeasonSignal:RequestLegacySeasonSignal;
      
      [Inject]
      public var updateBoardSignal:FameListUpdateSignal;
      
      private var closeButton:SliceScalingButton;
      
      private var _currentSeasonId:String = "";
      
      private var _isActiveSeason:Boolean;
      
      private var _legacyLeaderBoardSeasons:Vector.<LegacySeasonData>;
      
      public function SeasonalLegacyLeaderBoardMediator() {
         _legacyLeaderBoardSeasons = new Vector.<LegacySeasonData>(0);
         super();
      }
      
      override public function initialize() : void {
         this.seasonalLeaderBoardErrorSignal.add(this.onLeaderBoardError);
         this.view.header.setTitle("Seasons Leaderboard",480,DefaultLabelFormat.defaultMediumPopupTitle);
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
         this.setSeasonData();
         this.updateBoardSignal.add(this.updateLeaderBoard);
      }
      
      override public function destroy() : void {
         this.view.dispose();
         this.closeButton.dispose();
         this.seasonalLeaderBoardErrorSignal.remove(this.onLeaderBoardError);
         this.updateBoardSignal.remove(this.updateLeaderBoard);
         if(this.view.dropDown) {
            this.view.dropDown.removeEventListener("change",this.onDropDownChanged);
         }
      }
      
      private function setSeasonData() : void {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<String> = new Vector.<String>(0);
         var _loc1_:Vector.<LegacySeasonData> = this.seasonalEventModel.legacySeasons;
         var _loc3_:int = !!_loc1_?_loc1_.length:0;
         while(_loc4_ < _loc3_) {
            _loc2_ = _loc1_[_loc4_];
            if(_loc2_.hasLeaderBoard) {
               this._legacyLeaderBoardSeasons.push(_loc2_);
               _loc5_.push(_loc2_.title);
            }
            _loc4_++;
         }
         if(_loc5_.length > 0) {
            this._currentSeasonId = "";
            _loc5_.unshift("Click to choose a season!");
            this.view.setDropDownData(_loc5_);
            this.view.dropDown.addEventListener("change",this.onDropDownChanged);
         }
      }
      
      private function isSeasonActive(param1:String) : Boolean {
         var _loc2_:Boolean = false;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = this._legacyLeaderBoardSeasons.length;
         while(_loc4_ < _loc5_) {
            _loc3_ = this._legacyLeaderBoardSeasons[_loc4_];
            if(param1 == _loc3_.seasonId && _loc3_.active) {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      private function resetLeaderBoard() : void {
         this.view.clearLeaderBoard();
         this.view.spinner.visible = false;
         this.view.spinner.pause();
         this.seasonalEventModel.leaderboardLegacyTop20ItemDatas = null;
         this.seasonalEventModel.leaderboardLegacyPlayerItemDatas = null;
         this._currentSeasonId = "";
         if(this.view.tabs.currentTabLabel == "Your Position") {
            this.view.tabs.tabSelectedSignal.dispatch("Top 20");
         }
      }
      
      private function getSeasonId() : String {
         var _loc1_:String = this.view.dropDown.getValue();
         return this.seasonalEventModel.getSeasonIdByTitle(_loc1_);
      }
      
      private function onLeaderBoardError(param1:String) : void {
         this.view.clearLeaderBoard();
         this.view.spinner.visible = false;
         this.view.spinner.pause();
         this.view.setErrorMessage(param1);
      }
      
      private function getTimeFormat(param1:Number) : String {
         var _loc2_:Date = new Date(param1);
         var _loc5_:String = _loc2_.getHours() > 9?_loc2_.getHours().toString():"0" + _loc2_.getHours();
         var _loc4_:String = _loc2_.getMinutes() > 9?_loc2_.getMinutes().toString():"0" + _loc2_.getMinutes();
         var _loc3_:String = _loc2_.getSeconds() > 9?_loc2_.getSeconds().toString():"0" + _loc2_.getSeconds();
         return _loc5_ + ":" + _loc4_ + ":" + _loc3_;
      }
      
      private function onTabSelected(param1:String) : void {
         if(this._currentSeasonId != "") {
            this.showSpinner();
            this.updateLeaderBoard();
         }
      }
      
      private function showSpinner() : void {
         this.view.spinner.resume();
         this.view.spinner.visible = true;
      }
      
      private function updateLeaderBoard() : void {
         if(this.view.tabs.currentTabLabel == "Top 20") {
            if(this.seasonalEventModel.leaderboardLegacyTop20ItemDatas) {
               this.upDateTop20();
            }
         } else if(this.view.tabs.currentTabLabel == "Your Position") {
            if(this.seasonalEventModel.leaderboardLegacyPlayerItemDatas) {
               this.upDatePlayerPosition();
            } else {
               this.requestLegacySeasonSignal.dispatch(this._currentSeasonId != ""?this._currentSeasonId:this.getSeasonId(),false);
            }
         } else {
            this.onTabSelected(this.view.tabs.currentTabLabel);
         }
      }
      
      private function upDateTop20() : void {
         var _loc1_:* = null;
         this.view.clearLeaderBoard();
         this.view.spinner.visible = false;
         this.view.spinner.pause();
         var _loc3_:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardLegacyTop20ItemDatas;
         var _loc2_:* = _loc3_;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc1_ in _loc3_) {
            this.view.addTop20Item(_loc1_);
         }
      }
      
      private function upDatePlayerPosition() : void {
         var _loc1_:* = null;
         this.view.clearLeaderBoard();
         this.view.spinner.visible = false;
         this.view.spinner.pause();
         var _loc3_:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardLegacyPlayerItemDatas;
         var _loc2_:* = _loc3_;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc1_ in _loc3_) {
            this.view.addPlayerListItem(_loc1_);
         }
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function onDropDownChanged(param1:Event) : void {
         this.resetLeaderBoard();
         this.showSpinner();
         this._currentSeasonId = this.getSeasonId();
         if(this.isSeasonActive(this._currentSeasonId)) {
            this.view.tabs.getTabButtonByLabel("Your Position").visible = true;
         } else {
            this.view.tabs.getTabButtonByLabel("Your Position").visible = false;
         }
         this.requestLegacySeasonSignal.dispatch(this._currentSeasonId,true);
      }
   }
}
