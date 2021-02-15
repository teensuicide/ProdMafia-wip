package io.decagames.rotmg.pets.windows.yard.feed {
   import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.tabs.UITab;
   
   public class FeedTab extends UITab {
       
      
      private var feedGrid:UIGrid;
      
      private var feedButtonsMargin:int = 20;
      
      private var feedLabel:UILabel;
      
      private var _feedGoldButton:ShopBuyButton;
      
      private var _feedFameButton:ShopBuyButton;
      
      public function FeedTab(param1:int) {
         var _loc2_:int = 0;
         super("Feed");
         this.feedLabel = new UILabel();
         DefaultLabelFormat.feedPetInfo(this.feedLabel);
         this.feedLabel.text = "Select Items to Feed";
         this.feedLabel.width = param1;
         this.feedLabel.wordWrap = true;
         this.feedLabel.y = 102;
         addChild(this.feedLabel);
         this.feedGrid = new UIGrid(param1 - 100,4,5);
         this.feedGrid.x = 50;
         this.feedGrid.y = 10;
         addChild(this.feedGrid);
         this._feedGoldButton = new ShopBuyButton(0,0);
         this._feedFameButton = new ShopBuyButton(0,1);
         var _loc3_:int = 100;
         this._feedFameButton.width = _loc3_;
         this._feedGoldButton.width = _loc3_;
         _loc3_ = 125;
         this._feedFameButton.y = _loc3_;
         this._feedGoldButton.y = _loc3_;
         _loc2_ = (param1 - (this._feedGoldButton.width + this._feedFameButton.width + this.feedButtonsMargin)) / 2;
         this._feedGoldButton.x = _loc2_;
         this._feedFameButton.x = this._feedGoldButton.x + this._feedGoldButton.width + _loc2_;
         addChild(this._feedGoldButton);
         addChild(this._feedFameButton);
      }
      
      public function get feedGoldButton() : ShopBuyButton {
         return this._feedGoldButton;
      }
      
      public function get feedFameButton() : ShopBuyButton {
         return this._feedFameButton;
      }
      
      public function updateFeedPower(param1:int, param2:Boolean) : void {
         if(param1 == 0 || param2) {
            this.feedLabel.text = !param2?"Select Items to Feed":"Fully Maxed";
            this._feedGoldButton.alpha = 0;
            this._feedFameButton.alpha = 0;
         } else {
            this.feedLabel.text = "Feed power: " + param1;
            this._feedGoldButton.alpha = 1;
            this._feedFameButton.alpha = 1;
         }
         this._feedGoldButton.disabled = param1 == 0;
         this._feedFameButton.disabled = param1 == 0;
      }
      
      public function clearGrid() : void {
         this.feedGrid.clearGrid();
      }
      
      public function addItem(param1:FeedItem) : void {
         this.feedGrid.addGridElement(param1);
      }
   }
}
