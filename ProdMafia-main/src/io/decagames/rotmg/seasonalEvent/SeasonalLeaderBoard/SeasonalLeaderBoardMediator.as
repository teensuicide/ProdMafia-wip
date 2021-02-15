package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.seasonalEvent.signals.RequestChallengerListSignal;
   import io.decagames.rotmg.seasonalEvent.signals.SeasonalLeaderBoardErrorSignal;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.legends.control.FameListUpdateSignal;
   import kabam.rotmg.legends.model.LegendsModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class SeasonalLeaderBoardMediator extends Mediator {
      
      public static const REFRESH_TIME:String = " The list will be refreshed in: ";
      
      public static const REFRESH_INTERVAL_IN_MILLISECONDS:Number = 300000;
       
      
      [Inject]
      public var view:SeasonalLeaderBoard;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var legendsModel:LegendsModel;
      
      [Inject]
      public var requestChallengerListSignal:RequestChallengerListSignal;
      
      [Inject]
      public var updateBoardSignal:FameListUpdateSignal;
      
      [Inject]
      public var seasonalLeaderBoardErrorSignal:SeasonalLeaderBoardErrorSignal;
      
      private var closeButton:SliceScalingButton;
      
      private var _refreshTimer:Timer;
      
      public function SeasonalLeaderBoardMediator() {
         super();
      }
      
      override public function initialize() : void {
         this._refreshTimer = new Timer(1000);
         this._refreshTimer.addEventListener("timer",this.onTime);
         this.updateBoardSignal.add(this.updateLeaderBoard);
         this.seasonalLeaderBoardErrorSignal.add(this.onLeaderBoardError);
         this.view.header.setTitle("RIFTS Leaderboard",480,DefaultLabelFormat.defaultMediumPopupTitle);
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
      }
      
      override public function destroy() : void {
         this.view.dispose();
         this.closeButton.dispose();
         this._refreshTimer.stop();
         this._refreshTimer.removeEventListener("timer",this.onTime);
         this._refreshTimer = null;
         this.seasonalLeaderBoardErrorSignal.remove(this.onLeaderBoardError);
         this.updateBoardSignal.remove(this.updateLeaderBoard);
      }
      
      private function setGeneratedTime() : void {
         var _loc1_:Date = this.view.tabs.currentTabLabel == "Top 20"?this.seasonalEventModel.leaderboardTop20CreateTime:this.seasonalEventModel.leaderboardPlayerCreateTime;
         this.view.lastUpdatedTime.text = "Last updated at: " + this.getTimeFormat(_loc1_.time);
      }
      
      private function onLeaderBoardError(param1:String) : void {
         this.view.clearLeaderBoard();
         this.view.spinner.visible = false;
         this.view.spinner.pause();
         this.view.setErrorMessage(param1);
      }
      
      private function updateRefreshTime() : void {
         var _loc1_:String = this.getTimeFormat(this.timeToRefresh());
         this.view.refreshTime.text = " The list will be refreshed in: " + _loc1_;
      }
      
      private function getTimeFormat(param1:Number) : String {
         var _loc2_:Date = new Date(param1);
         var _loc5_:String = _loc2_.getUTCHours() > 9?_loc2_.getUTCHours().toString():"0" + _loc2_.getUTCHours();
         var _loc4_:String = _loc2_.getUTCMinutes() > 9?_loc2_.getUTCMinutes().toString():"0" + _loc2_.getUTCMinutes();
         var _loc3_:String = _loc2_.getUTCSeconds() > 9?_loc2_.getUTCSeconds().toString():"0" + _loc2_.getUTCSeconds();
         return _loc5_ + ":" + _loc4_ + ":" + _loc3_;
      }
      
      private function onTabSelected(param1:String) : void {
         this.view.refreshTime.visible = false;
         this.view.lastUpdatedTime.visible = false;
         this._refreshTimer.stop();
         this.showSpinner();
         if(this.timeToRefresh() <= 0) {
            this.requestChallengerListSignal.dispatch(this.legendsModel.getTimespan(),param1);
         } else if(param1 == "Top 20") {
            this.upDateTop20();
         } else if(param1 == "Your Position") {
            this.upDatePlayerPosition();
         }
      }
      
      private function timeToRefresh() : Number {
         var _loc1_:* = null;
         var _loc2_:Date = this.view.tabs.currentTabLabel == "Top 20"?this.seasonalEventModel.leaderboardTop20RefreshTime:this.seasonalEventModel.leaderboardPlayerRefreshTime;
         if(_loc2_) {
            _loc1_ = new Date();
            return _loc2_.time - _loc1_.time;
         }
         return 0;
      }
      
      private function showSpinner() : void {
         this.view.spinner.resume();
         this.view.spinner.visible = true;
      }
      
      private function updateLeaderBoard() : void {
         if(this.view.tabs.currentTabLabel == "Top 20") {
            if(this.seasonalEventModel.leaderboardTop20ItemDatas) {
               this.upDateTop20();
            }
         } else if(this.view.tabs.currentTabLabel == "Your Position") {
            if(this.seasonalEventModel.leaderboardPlayerItemDatas) {
               this.upDatePlayerPosition();
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
         var _loc3_:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardTop20ItemDatas;
         var _loc2_:* = _loc3_;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc1_ in _loc3_) {
            this.view.addTop20Item(_loc1_);
         }
         this.view.refreshTime.visible = true;
         this.setGeneratedTime();
         this.view.lastUpdatedTime.visible = true;
         this._refreshTimer.start();
      }
      
      private function upDatePlayerPosition() : void {
         var _loc1_:* = null;
         this.view.clearLeaderBoard();
         this.view.spinner.visible = false;
         this.view.spinner.pause();
         var _loc3_:Vector.<SeasonalLeaderBoardItemData> = this.seasonalEventModel.leaderboardPlayerItemDatas;
         var _loc2_:* = _loc3_;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_;
         for each(_loc1_ in _loc3_) {
            this.view.addPlayerListItem(_loc1_);
         }
         this.view.refreshTime.visible = true;
         this.setGeneratedTime();
         this.view.lastUpdatedTime.visible = true;
         this._refreshTimer.start();
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function onTime(param1:TimerEvent) : void {
         if(this.timeToRefresh() <= 0) {
            this.onTabSelected(this.view.tabs.currentTabLabel);
         } else {
            this.updateRefreshTime();
         }
      }
   }
}
