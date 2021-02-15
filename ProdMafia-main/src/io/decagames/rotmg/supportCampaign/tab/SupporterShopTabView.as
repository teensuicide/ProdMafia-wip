package io.decagames.rotmg.supportCampaign.tab {
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import io.decagames.rotmg.shop.ShopBuyButton;
   import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
   import io.decagames.rotmg.supportCampaign.tab.donate.DonatePanel;
   import io.decagames.rotmg.supportCampaign.tab.tiers.preview.TiersPreview;
   import io.decagames.rotmg.supportCampaign.tab.tiers.progressBar.TiersProgressBar;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.tabs.UITab;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.date.TimeSpan;
   
   public class SupporterShopTabView extends UITab {
       
      
      private var backgroundWidth:int = 561;
      
      private var background:SliceScalingBitmap;
      
      private var _countdown:UILabel;
      
      private var _campaignTimer:UILabel;
      
      private var unlockScreenContainer:Sprite;
      
      private var pointsInfo:UILabel;
      
      private var supportIcon:SliceScalingBitmap;
      
      private var fieldBackground:SliceScalingBitmap;
      
      private var endDateInfo:UILabel;
      
      private var tiersPreview:TiersPreview;
      
      private var progressBar:TiersProgressBar;
      
      private var pName:String;
      
      private var _campaignTitle:String;
      
      private var _campaignDescription:String;
      
      private var _unlockButton:ShopBuyButton;
      
      private var _infoButton:SliceScalingButton;
      
      public function SupporterShopTabView(param1:String, param2:String) {
         super(param1);
         this._campaignTitle = param1;
         this._campaignDescription = param2;
         this._countdown = new UILabel();
         this._campaignTimer = new UILabel();
      }
      
      public function get unlockButton() : ShopBuyButton {
         return this._unlockButton;
      }
      
      public function get infoButton() : SliceScalingButton {
         return this._infoButton;
      }
      
      public function show(param1:String, param2:Boolean, param3:Boolean, param4:int, param5:int, param6:Boolean, param7:DisplayObject) : void {
         this.pName = param1;
         this.drawBackground(param2);
         if(param2) {
            if(this.unlockScreenContainer != null) {
               removeChild(this.unlockScreenContainer);
               this.unlockScreenContainer = null;
            }
            this.drawDonatePanel(param5,param6);
         } else {
            this.showUnlockScreen(param3,param4,param5,param6,param7);
         }
      }
      
      public function updateStartCountdown(param1:String) : void {
         this._countdown.text = param1;
         if(param1 == "") {
            this._campaignTimer.text = "";
         }
      }
      
      public function updatePoints(param1:int, param2:int) : void {
         if(!this.pointsInfo) {
            this.fieldBackground = TextureParser.instance.getSliceScalingBitmap("UI","bordered_field",150);
            addChild(this.fieldBackground);
            this.pointsInfo = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.pointsInfo,18,15585539,"center",true);
            addChild(this.pointsInfo);
            this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI","campaign_Points");
            addChild(this.supportIcon);
            this._infoButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","tier_info"));
            addChild(this._infoButton);
         }
         this.pointsInfo.text = !param1?"0":param1.toString();
         this.pointsInfo.x = this.background.width / 2 - this.pointsInfo.width / 2 + 8;
         this.pointsInfo.y = this.background.y - 8;
         this.fieldBackground.y = this.pointsInfo.y - 5;
         this.fieldBackground.x = this.background.width / 2 - this.fieldBackground.width / 2 + 13;
         this.supportIcon.y = this.pointsInfo.y + 1;
         this.supportIcon.x = this.pointsInfo.x + this.pointsInfo.width;
         this._infoButton.y = this.fieldBackground.y + 1;
         this._infoButton.x = this.fieldBackground.x + 3;
      }
      
      public function updateTime(param1:Number) : void {
         var _loc2_:TimeSpan = new TimeSpan(param1);
         var _loc3_:String = "Campaign will end in: ";
         if(_loc2_.totalMilliseconds <= 0) {
            _loc3_ = "Campaign has ended!";
         } else if(_loc2_.totalDays == 0) {
            _loc3_ = _loc3_ + ((_loc2_.hours > 9?_loc2_.hours.toString():"0" + _loc2_.hours.toString()) + "h " + (_loc2_.minutes > 9?_loc2_.minutes.toString():"0" + _loc2_.minutes.toString()) + "m");
         } else {
            _loc3_ = _loc3_ + ((_loc2_.days > 9?_loc2_.days.toString():"0" + _loc2_.days.toString()) + "d " + (_loc2_.hours > 9?_loc2_.hours.toString():"0" + _loc2_.hours.toString()) + "h");
         }
         if(!this.endDateInfo) {
            this.endDateInfo = new UILabel();
            DefaultLabelFormat.createLabelFormat(this.endDateInfo,14,16684800,"center",false);
            addChild(this.endDateInfo);
         }
         this.endDateInfo.text = _loc3_;
         this.endDateInfo.wordWrap = true;
         this.endDateInfo.width = this.background.width - 13;
         this.endDateInfo.x = this.background.x + 13;
         this.endDateInfo.y = this.background.y + this.background.height - 115;
      }
      
      public function showTier(param1:int, param2:Array, param3:int, param4:int, param5:DisplayObject) : void {
         if(!this.tiersPreview) {
            this.tiersPreview = new TiersPreview(param2,530);
            this.tiersPreview.x = this.background.x + 15;
            this.tiersPreview.y = this.background.y + 20;
            addChild(this.tiersPreview);
         }
         this.tiersPreview.showTier(param1,param3,param4,param5);
      }
      
      public function drawProgress(param1:int, param2:Vector.<RankVO>, param3:int, param4:int) : void {
         if(!this.progressBar) {
            this.progressBar = new TiersProgressBar(param2,530);
            this.progressBar.x = this.background.x + 15;
            this.progressBar.y = 285;
            addChild(this.progressBar);
         }
         this.progressBar.show(param1,param3,param4);
      }
      
      public function updateTimerPosition() : void {
      }
      
      private function showUnlockScreen(param1:Boolean, param2:int, param3:int, param4:Boolean, param5:DisplayObject) : void {
         this.unlockScreenContainer = new Sprite();
         this.unlockScreenContainer.x = 30;
         this.unlockScreenContainer.y = 10;
         this.unlockScreenContainer.addChild(param5);
         var _loc8_:UILabel = new UILabel();
         _loc8_.text = "Welcome to the " + this._campaignTitle + ", " + this.pName + "!";
         DefaultLabelFormat.createLabelFormat(_loc8_,18,15395562,"left",true);
         _loc8_.wordWrap = true;
         _loc8_.width = param5.width - 20;
         _loc8_.x = 10;
         _loc8_.y = param5.height + 10;
         this.unlockScreenContainer.addChild(_loc8_);
         var _loc7_:UILabel = new UILabel();
         _loc7_.text = this._campaignDescription;
         DefaultLabelFormat.createLabelFormat(_loc7_,14,15395562,"justify",false);
         _loc7_.wordWrap = true;
         _loc7_.width = param5.width - 20;
         _loc7_.x = 10;
         _loc7_.y = _loc8_.y + _loc8_.height;
         this.unlockScreenContainer.addChild(_loc7_);
         var _loc6_:SliceScalingBitmap = new TextureParser().getSliceScalingBitmap("UI","main_button_decoration_dark",150);
         this.unlockScreenContainer.addChild(_loc6_);
         this._unlockButton = new ShopBuyButton(param2);
         this._unlockButton.width = _loc6_.width - 48;
         this._unlockButton.disabled = !param1 || param4;
         this.unlockScreenContainer.addChild(this._unlockButton);
         _loc6_.x = Math.round((param5.width - _loc6_.width) / 2);
         _loc6_.y = _loc7_.y + _loc7_.height;
         this._unlockButton.x = _loc6_.x + 24;
         this._unlockButton.y = _loc6_.y + 6;
         if(!param1) {
            this._campaignTimer.text = "The " + this._campaignTitle + " will start in:";
            DefaultLabelFormat.createLabelFormat(this._countdown,18,16684800,"center",true);
            this._countdown.text = "";
            this._countdown.wordWrap = true;
            this._countdown.width = param5.width;
            this._countdown.y = _loc8_.y - 20;
            this.unlockScreenContainer.addChild(this._countdown);
         } else if(param4) {
            this._campaignTimer.text = "The " + this._campaignTitle + " has ended!";
            DefaultLabelFormat.createLabelFormat(this._countdown,18,16684800,"center",true);
            this._countdown.text = "";
            this._countdown.wordWrap = true;
            this._countdown.width = param5.width;
            this._countdown.y = 197;
            this.unlockScreenContainer.addChild(this._countdown);
         }
         DefaultLabelFormat.createLabelFormat(this._campaignTimer,14,16684800,"center",false);
         this._campaignTimer.wordWrap = true;
         this._campaignTimer.width = param5.width;
         var _loc9_:* = _loc8_.y - 20;
         this._countdown.y = _loc9_;
         this._campaignTimer.y = _loc9_;
         this.unlockScreenContainer.addChild(this._campaignTimer);
         addChild(this.unlockScreenContainer);
      }
      
      private function drawBackground(param1:Boolean) : void {
         this.background = TextureParser.instance.getSliceScalingBitmap("UI","shop_box_background",this.backgroundWidth);
         addChild(this.background);
         this.background.height = 375;
         this.background.x = 14;
         this.background.y = 0;
      }
      
      private function drawDonatePanel(param1:int, param2:Boolean) : void {
         var _loc3_:DonatePanel = new DonatePanel(param1,param2);
         addChild(_loc3_);
         _loc3_.x = this.background.x + Math.round((this.backgroundWidth - _loc3_.width) / 2);
         _loc3_.y = this.background.height - 55;
      }
   }
}
