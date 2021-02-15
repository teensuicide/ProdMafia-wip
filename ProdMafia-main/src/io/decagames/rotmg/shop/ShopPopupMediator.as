package io.decagames.rotmg.shop {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.greensock.TweenMax;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import io.decagames.rotmg.shop.genericBox.GenericBoxTile;
   import io.decagames.rotmg.shop.genericBox.data.GenericBoxInfo;
   import io.decagames.rotmg.shop.mysteryBox.MysteryBoxTile;
   import io.decagames.rotmg.shop.packages.PackageBoxTile;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import io.decagames.rotmg.supportCampaign.tab.SupporterShopTabView;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.tabs.TabButton;
   import io.decagames.rotmg.ui.tabs.UITab;
   import io.decagames.rotmg.ui.tabs.UITabs;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
   import kabam.rotmg.application.DynamicSettings;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
   import kabam.rotmg.mysterybox.services.MysteryBoxModel;
   import kabam.rotmg.packages.model.PackageInfo;
   import kabam.rotmg.packages.services.PackageModel;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ShopPopupMediator extends Mediator {
       
      
      [Inject]
      public var view:ShopPopupView;
      
      [Inject]
      public var mysteryBoxModel:MysteryBoxModel;
      
      [Inject]
      public var packageBoxModel:PackageModel;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var openMoneyWindow:OpenMoneyWindowSignal;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipSignal:HideTooltipsSignal;
      
      [Inject]
      public var supporterModel:SupporterCampaignModel;
      
      private var closeButton:SliceScalingButton;
      
      private var addButton:SliceScalingButton;
      
      private var mysteryBoxesGrid:UIGrid;
      
      private var packageBoxesGrid:UIGrid;
      
      private var toolTip:TextToolTip = null;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      private var tabs:UITabs;
      
      private var packageTab:TabButton;
      
      private var updateLabel:UILabel;
      
      private var updateTimer:Timer;
      
      public function ShopPopupMediator() {
         super();
      }
      
      private function get updateInterval() : int {
         if(DynamicSettings.settingExists("MysteryBoxRefresh")) {
            return DynamicSettings.getSettingValue("MysteryBoxRefresh") * 1000;
         }
         return 180000;
      }
      
      override public function initialize() : void {
         var _loc2_:* = null;
         var _loc3_:Boolean = false;
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.addButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","add_button"));
         this.tabs = new UITabs(590);
         if(this.supporterModel.hasValidData) {
            this.tabs.addTab(new SupporterShopTabView(this.supporterModel.campaignTitle,this.supporterModel.campaignDescription),true);
         }
         this.tabs.addTab(this.createMysteryBoxTab(),!this.supporterModel.hasValidData);
         this.tabs.addTab(this.createPackageBoxTab());
         this.tabs.y = 115;
         this.tabs.x = 3;
         this.view.header.setTitle("Shop",319,DefaultLabelFormat.defaultPopupTitle);
         this.view.header.showCoins(132).coinsAmount = this.gameModel.player.credits_;
         this.view.header.showFame(132).fameAmount = this.gameModel.player.fame_;
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.addButton.clickSignal.add(this.onAdd);
         this.view.header.addButton(this.addButton,"left_button");
         this.view.addChild(this.tabs);
         this.updateLabel = new UILabel();
         this.updateLabel.defaultTextFormat = DefaultLabelFormat.createTextFormat(12,16773120,"left",true);
         this.updateLabel.text = "Updating shop...";
         this.updateLabel.x = 15;
         this.updateLabel.y = 582;
         this.updateLabel.alpha = 0;
         this.view.addChild(this.updateLabel);
         var _loc5_:Vector.<PackageInfo> = this.packageBoxModel.getTargetingBoxesForGrid().concat(this.packageBoxModel.getBoxesForGrid());
         var _loc1_:Date = new Date();
         _loc1_.setTime(Parameters.data["packages_indicator"]);
         var _loc6_:* = _loc5_;
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for each(_loc2_ in _loc5_) {
            if(_loc2_ != null && (!_loc2_.endTime || _loc2_.getSecondsToEnd() > 0)) {
               if(_loc2_.isNew() && (_loc2_.startTime.getTime() > _loc1_.getTime() || !Parameters.data["packages_indicator"])) {
                  _loc3_ = true;
               }
            }
         }
         this.packageTab = this.tabs.getTabButtonByLabel("Packages");
         if(this.packageTab) {
            this.packageTab.showIndicator = _loc3_;
            this.packageTab.clickSignal.add(this.onPackageClick);
         }
         this.gameModel.player.creditsWereChanged.add(this.refreshCoins);
         this.gameModel.player.fameWasChanged.add(this.refreshFame);
         this.toolTip = new TextToolTip(3552822,10197915,"Buy Gold","Click to buy more Realm Gold!",200);
         this.hoverTooltipDelegate = new HoverTooltipDelegate();
         this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
         this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
         this.hoverTooltipDelegate.setDisplayObject(this.addButton);
         this.hoverTooltipDelegate.tooltip = this.toolTip;
         this.updateTimer = new Timer(this.updateInterval);
         this.updateTimer.addEventListener("timer",this.updateShop);
         this.tabs.tabSelectedSignal.add(this.onTabChange);
         if(!this.supporterModel.hasValidData) {
            this.updateShop(null);
         }
      }
      
      override public function destroy() : void {
         this.updateTimer.stop();
         this.updateTimer.removeEventListener("timer",this.tryUpdateMysteryBoxes);
         this.mysteryBoxModel.updateSignal.remove(this.onBoxUpdate);
         this.packageBoxModel.updateSignal.remove(this.onPackageUpdate);
         this.view.dispose();
         this.closeButton.dispose();
         this.addButton.dispose();
         this.gameModel.player.creditsWereChanged.remove(this.refreshCoins);
         this.gameModel.player.fameWasChanged.remove(this.refreshFame);
         this.tabs.dispose();
         this.mysteryBoxesGrid.dispose();
         this.packageBoxesGrid.dispose();
         this.toolTip = null;
         this.hoverTooltipDelegate.removeDisplayObject();
         this.hoverTooltipDelegate = null;
         if(this.packageTab) {
            this.packageTab.clickSignal.remove(this.onPackageClick);
         }
      }
      
      private function createPackageBoxTab() : UITab {
         var _loc1_:* = null;
         _loc1_ = new UITab("Packages");
         this.packageBoxesGrid = new UIGrid(550,2,6,384,3,_loc1_);
         this.packageBoxesGrid.x = 10;
         this.packageBoxesGrid.decorBitmap = "tabs_tile_decor";
         this.updatePackages();
         _loc1_.addContent(this.packageBoxesGrid);
         return _loc1_;
      }
      
      private function createMysteryBoxTab() : UITab {
         var _loc1_:UITab = new UITab("Mystery Boxes",true);
         this.mysteryBoxesGrid = new UIGrid(550,3,6,384,3,_loc1_);
         this.mysteryBoxesGrid.decorBitmap = "tabs_tile_decor";
         this.mysteryBoxesGrid.x = 10;
         this.updateMysteryBoxes();
         _loc1_.addContent(this.mysteryBoxesGrid);
         return _loc1_;
      }
      
      private function updateMysteryBoxes() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         this.mysteryBoxesGrid.clearGrid();
         var _loc2_:Vector.<MysteryBoxInfo> = this.mysteryBoxModel.getBoxesForGrid();
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            if(_loc1_ != null && (!_loc1_.endTime || _loc1_.getSecondsToEnd() > 0)) {
               _loc3_ = this.createBoxTile(_loc1_,MysteryBoxTile);
               _loc3_.selfRemoveSignal.add(this.updateMysteryBoxes);
               this.mysteryBoxesGrid.addGridElement(_loc3_);
            }
         }
      }
      
      private function updatePackages() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         this.packageBoxesGrid.clearGrid();
         var _loc2_:Vector.<PackageInfo> = this.packageBoxModel.getTargetingBoxesForGrid().concat(this.packageBoxModel.getBoxesForGrid());
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            if(_loc1_ != null && (!_loc1_.endTime || _loc1_.getSecondsToEnd() > 0)) {
               _loc3_ = this.createBoxTile(_loc1_,PackageBoxTile);
               _loc3_.selfRemoveSignal.add(this.updatePackages);
               this.packageBoxesGrid.addGridElement(_loc3_);
            }
         }
      }
      
      private function createBoxTile(param1:GenericBoxInfo, param2:Class) : GenericBoxTile {
         return new param2(param1);
      }
      
      private function onTabChange(param1:String) : void {
         if(this.updateTimer) {
            this.updateTimer.reset();
         }
         if(param1 != "Campaign") {
            this.updateShop(null);
         } else {
            TweenMax.killTweensOf(this.updateLabel);
            this.updateLabel.alpha = 0;
         }
      }
      
      private function tryUpdateMysteryBoxes() : void {
         TweenMax.killTweensOf(this.updateLabel);
         this.updateLabel.alpha = 1;
         this.mysteryBoxModel.updateSignal.add(this.onBoxUpdate);
         TweenMax.to(this.updateLabel,0.6,{
            "alpha":0,
            "yoyo":true,
            "repeat":-1
         });
      }
      
      private function tryUpdatePackages() : void {
         TweenMax.killTweensOf(this.updateLabel);
         this.updateLabel.alpha = 1;
         this.packageBoxModel.updateSignal.add(this.onPackageUpdate);
         TweenMax.to(this.updateLabel,0.6,{
            "alpha":0,
            "yoyo":true,
            "repeat":-1
         });
      }
      
      private function onBoxUpdate() : void {
         this.mysteryBoxModel.updateSignal.remove(this.onBoxUpdate);
         this.updateMysteryBoxes();
         TweenMax.killTweensOf(this.updateLabel);
         this.updateLabel.alpha = 0;
      }
      
      private function onPackageUpdate() : void {
         this.packageBoxModel.updateSignal.remove(this.onPackageUpdate);
         this.updatePackages();
         TweenMax.killTweensOf(this.updateLabel);
         this.updateLabel.alpha = 0;
      }
      
      private function onPackageClick(param1:BaseButton) : void {
         if(TabButton(param1).hasIndicator) {
            Parameters.data["packages_indicator"] = new Date().getTime();
            TabButton(param1).showIndicator = false;
         }
      }
      
      private function refreshCoins() : void {
         this.view.header.showCoins(132).coinsAmount = this.gameModel.player.credits_;
      }
      
      private function refreshFame() : void {
         this.view.header.showFame(132).fameAmount = this.gameModel.player.fame_;
      }
      
      private function onAdd(param1:BaseButton) : void {
         this.openMoneyWindow.dispatch();
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function updateShop(param1:TimerEvent) : void {
         var _loc2_:* = this.tabs.currentTabLabel;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "Mystery Boxes":
               this.tryUpdateMysteryBoxes();
               return;
            case "Packages":
               this.tryUpdatePackages();
               return;
            default:
               return;
         }
      }
   }
}
