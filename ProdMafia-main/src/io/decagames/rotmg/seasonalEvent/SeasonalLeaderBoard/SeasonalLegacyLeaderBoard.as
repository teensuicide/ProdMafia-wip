package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import com.company.assembleegameclient.ui.dropdown.DropDown;
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
   
   public class SeasonalLegacyLeaderBoard extends UIPopup {
      
      public static const TOP_20_TAB_LABEL:String = "Top 20";
      
      public static const PLAYER_TAB_LABEL:String = "Your Position";
      
      public static const SCROLL_Y_OFFSET:int = 175;
      
      public static const SCROLL_HEIGHT:int = 390;
      
      public static const WIDTH:int = 600;
       
      
      private var _tabContent:Sprite;
      
      private var _spinnersContainer:Sprite;
      
      private var _contentInset:SliceScalingBitmap;
      
      private var _contentTabs:SliceScalingBitmap;
      
      private var _top20Grid:UIGrid;
      
      private var _yourPositionGrid:UIGrid;
      
      private var _error:UILabel;
      
      private var _seasons:Vector.<String>;
      
      private var _tabs:UITabs;
      
      private var _spinner:Spinner;
      
      private var _dropDown:DropDown;
      
      public function SeasonalLegacyLeaderBoard() {
         super(600,600);
         this.init();
      }
      
      public function get tabs() : UITabs {
         return this._tabs;
      }
      
      public function get spinner() : Spinner {
         return this._spinner;
      }
      
      public function get dropDown() : DropDown {
         return this._dropDown;
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
      
      public function setDropDownData(param1:Vector.<String>) : void {
         this._seasons = param1;
         this.createDropDown();
      }
      
      private function init() : void {
         this.createGrids();
         this.createContentInset();
         this.createContentTabs();
         this.addTabs();
         this.createSpinner();
         this.createError();
      }
      
      private function createDropDown() : void {
         this._dropDown = new DropDown(this._seasons,200,20);
         this._dropDown.x = this._contentInset.x + (this._contentInset.width - this._dropDown.width) / 2;
         this._dropDown.y = 112;
         addChild(this._dropDown);
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
      
      private function createSpinner() : void {
         this._spinnersContainer = new Sprite();
         addChild(this._spinnersContainer);
         this._spinner = new Spinner(180);
         this._spinner.scaleY = 0.1;
         this._spinner.scaleX = 0.1;
         this._spinner.pause();
         this._spinner.x = this._contentInset.x + this._contentInset.width / 2;
         this._spinner.y = this._contentInset.y + this._contentInset.height / 2;
         this._spinner.visible = false;
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
         this._contentTabs.y = 175 - this._contentTabs.height + 6;
         addChild(this._contentTabs);
      }
      
      private function createContentInset() : void {
         this._contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",580);
         this._contentInset.height = 390;
         this._contentInset.x = 10;
         this._contentInset.y = 175;
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
         var _loc5_:int = 0;
         var _loc6_:UITab = new UITab(param1,true);
         this._tabContent = new Sprite();
         param2.x = this._contentInset.x;
         this._tabContent.addChild(param2);
         param2.y = 16;
         param2.addChild(param3);
         _loc5_ = 370;
         var _loc4_:UIScrollbar = new UIScrollbar(_loc5_);
         _loc4_.mouseRollSpeedFactor = 1;
         _loc4_.scrollObject = _loc6_;
         _loc4_.content = param2;
         _loc4_.x = 554;
         _loc4_.y = 16;
         this._tabContent.addChild(_loc4_);
         var _loc7_:Sprite = new Sprite();
         _loc7_.graphics.beginFill(0);
         _loc7_.graphics.drawRect(0,0,600,_loc5_);
         _loc7_.x = param2.x;
         _loc7_.y = param2.y;
         param2.mask = _loc7_;
         this._tabContent.addChild(_loc7_);
         _loc6_.addContent(this._tabContent);
         return _loc6_;
      }
   }
}
