package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import flash.display.Sprite;
   import io.decagames.rotmg.shop.mysteryBox.rollModal.elements.Spinner;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.gird.UIGridElement;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.UIPopup;
   import io.decagames.rotmg.ui.scroll.UIScrollbar;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.tabs.UITab;
   import io.decagames.rotmg.ui.tabs.UITabs;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class SeasonalLeaderBoard extends UIPopup {
      
      public static const TOP_20_TAB_LABEL:String = "Top 20";
      
      public static const PLAYER_TAB_LABEL:String = "Your Position";
      
      public static const SCROLL_Y_OFFSET:int = 155;
      
      public static const SCROLL_HEIGHT:int = 410;
      
      public static const WIDTH:int = 600;
       
      
      private var _tabContent:Sprite;
      
      private var _spinnersContainer:Sprite;
      
      private var _contentInset:SliceScalingBitmap;
      
      private var _contentTabs:SliceScalingBitmap;
      
      private var _top20Grid:UIGrid;
      
      private var _yourPositionGrid:UIGrid;
      
      private var _error:UILabel;
      
      private var _tabs:UITabs;
      
      private var _spinner:Spinner;
      
      private var _refreshTime:UILabel;
      
      private var _lastUpdatedTime:UILabel;
      
      public function SeasonalLeaderBoard() {
         super(600,600);
         this.init();
      }
      
      public function get tabs() : UITabs {
         return this._tabs;
      }
      
      public function get spinner() : Spinner {
         return this._spinner;
      }
      
      public function get refreshTime() : UILabel {
         return this._refreshTime;
      }
      
      public function get lastUpdatedTime() : UILabel {
         return this._lastUpdatedTime;
      }
      
      public function addTop20Item(param1:SeasonalLeaderBoardItemData) : void {
         var _loc2_:SeasonalLeaderBoardItem = new SeasonalLeaderBoardItem(param1);
         var _loc3_:UIGridElement = new UIGridElement();
         _loc3_.addChild(_loc2_);
         this._top20Grid.addGridElement(_loc3_);
      }
      
      public function addPlayerListItem(param1:SeasonalLeaderBoardItemData) : void {
         var _loc2_:SeasonalLeaderBoardItem = new SeasonalLeaderBoardItem(param1);
         var _loc3_:UIGridElement = new UIGridElement();
         _loc3_.addChild(_loc2_);
         this._yourPositionGrid.addGridElement(_loc3_);
      }
      
      public function clearLeaderBoard() : void {
         this._error.visible = false;
         if(this._top20Grid) {
            this._top20Grid.clearGrid();
         }
         if(this._yourPositionGrid) {
            this._yourPositionGrid.clearGrid();
         }
      }
      
      public function setErrorMessage(param1:String) : void {
         this._error.text = param1;
         this._error.y = (this.height - this._error.height) / 2;
         this._error.visible = true;
      }
      
      private function init() : void {
         this.createGrids();
         this.createContentInset();
         this.createContentTabs();
         this.addTabs();
         this.createRefreshTime();
         this.createLastUpdatedTime();
         this.createSpinner();
         this.createError();
      }
      
      private function createError() : void {
         this._error = new UILabel();
         DefaultLabelFormat.createLabelFormat(this._error,14,16711680,"center",true);
         this._error.autoSize = "none";
         this._error.width = 600;
         this._error.multiline = true;
         this._error.wordWrap = true;
         this._error.visible = false;
         addChild(this._error);
      }
      
      private function createRefreshTime() : void {
         this._refreshTime = new UILabel();
         DefaultLabelFormat.createLabelFormat(this._refreshTime,12,16777215,"center",true);
         this._refreshTime.autoSize = "none";
         this._refreshTime.width = 300;
         this._refreshTime.x = 300;
         this._refreshTime.y = this.height - 18;
      }
      
      private function createLastUpdatedTime() : void {
         this._lastUpdatedTime = new UILabel();
         DefaultLabelFormat.createLabelFormat(this._lastUpdatedTime,12,16777215,"center",true);
         this._lastUpdatedTime.autoSize = "none";
         this._lastUpdatedTime.width = 600;
         this._lastUpdatedTime.y = this.height - 18;
         addChild(this._lastUpdatedTime);
      }
      
      private function createSpinner() : void {
         this._spinnersContainer = new Sprite();
         addChild(this._spinnersContainer);
         this._spinner = new Spinner(180);
         this._spinner.scaleY = 0.1;
         this._spinner.scaleX = 0.1;
         this._spinner.pause();
         this._spinner.x = this._contentInset.x + this._contentInset.width / 2;
         this._spinner.y = this._contentInset.y + this._contentInset.height / 2;
         this._spinnersContainer.addChild(this._spinner);
      }
      
      private function createGrids() : void {
         this._top20Grid = new UIGrid(580,1,3);
         this._yourPositionGrid = new UIGrid(580,1,3);
      }
      
      private function createContentTabs() : void {
         this._contentTabs = TextureParser.instance.getSliceScalingBitmap("UI","tab_inset_content_background",568);
         this._contentTabs.height = 45;
         this._contentTabs.x = 16;
         this._contentTabs.y = 155 - this._contentTabs.height + 6;
         addChild(this._contentTabs);
      }
      
      private function createContentInset() : void {
         this._contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",580);
         this._contentInset.height = 410;
         this._contentInset.x = 10;
         this._contentInset.y = 155;
         addChild(this._contentInset);
      }
      
      private function addTabs() : void {
         this._tabs = new UITabs(570,true);
         this._tabs.addTab(this.createTab("Top 20",new Sprite(),this._top20Grid),true);
         this._tabs.addTab(this.createTab("Your Position",new Sprite(),this._yourPositionGrid),false);
         this._tabs.x = 16;
         this._tabs.y = this._contentTabs.y;
         addChild(this._tabs);
      }
      
      private function createTab(param1:String, param2:Sprite, param3:UIGrid) : UITab {
         var _loc5_:* = null;
         _loc5_ = new UITab(param1,true);
         this._tabContent = new Sprite();
         param2.x = this._contentInset.x;
         this._tabContent.addChild(param2);
         param2.y = 16;
         param2.addChild(param3);
         var _loc4_:UIScrollbar = new UIScrollbar(384);
         _loc4_.mouseRollSpeedFactor = 1;
         _loc4_.scrollObject = _loc5_;
         _loc4_.content = param2;
         _loc4_.x = 554;
         _loc4_.y = 16;
         this._tabContent.addChild(_loc4_);
         var _loc6_:Sprite = new Sprite();
         _loc6_.graphics.beginFill(0);
         _loc6_.graphics.drawRect(0,0,600,384);
         _loc6_.x = param2.x;
         _loc6_.y = param2.y;
         param2.mask = _loc6_;
         this._tabContent.addChild(_loc6_);
         _loc5_.addContent(this._tabContent);
         return _loc5_;
      }
   }
}
