package io.decagames.rotmg.supportCampaign.data {
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
   import io.decagames.rotmg.supportCampaign.signals.MaxRankReachedSignal;
   import io.decagames.rotmg.supportCampaign.signals.UpdateCampaignProgress;
   import io.decagames.rotmg.utils.date.TimeLeft;
   import kabam.rotmg.core.StaticInjectorContext;
   
   public class SupporterCampaignModel {
      
      public static const DEFAULT_DONATE_AMOUNT:int = 100;
      
      public static const DEFAULT_DONATE_SPINNER_STEP:int = 100;
      
      public static const DONATE_MAX_INPUT_CHARS:int = 5;
      
      public static const SUPPORT_COLOR:Number = 13395711;
      
      public static const RANKS_NAMES:Array = ["Basic","Greater","Superior","Paramount","Exalted","Unbound"];
       
      
      private var _activeUntil:Date;
      
      private var _picUrls:Vector.<String>;
      
      private var _campaignImages:Dictionary;
      
      private var _maxRank:int;
      
      private var _unlockPrice:int;
      
      private var _points:int;
      
      private var _rank:int;
      
      private var _tempRank:int;
      
      private var _donatePointsRatio:int;
      
      private var _shopPurchasePointsRatio:int;
      
      private var _endDate:Date;
      
      private var _startDate:Date;
      
      private var _ranks:Array;
      
      private var _isUnlocked:Boolean;
      
      private var _hasValidData:Boolean;
      
      private var _claimed:int;
      
      private var _rankConfig:Vector.<RankVO>;
      
      private var _campaignTitle:String;
      
      private var _campaignDescription:String;
      
      private var _campaignBannerUrl:String;
      
      public function SupporterCampaignModel() {
         _campaignImages = new Dictionary(true);
         super();
      }
      
      public function get unlockPrice() : int {
         return this._unlockPrice;
      }
      
      public function get points() : int {
         return this._points;
      }
      
      public function get rank() : int {
         return this._rank;
      }
      
      public function get tempRank() : int {
         return this._tempRank;
      }
      
      public function set tempRank(param1:int) : void {
         this._tempRank = param1;
      }
      
      public function get donatePointsRatio() : int {
         return this._donatePointsRatio;
      }
      
      public function get shopPurchasePointsRatio() : int {
         return this._shopPurchasePointsRatio;
      }
      
      public function get endDate() : Date {
         return this._endDate;
      }
      
      public function get startDate() : Date {
         return this._startDate;
      }
      
      public function get ranks() : Array {
         return this._ranks;
      }
      
      public function get isUnlocked() : Boolean {
         return this._isUnlocked;
      }
      
      public function get hasValidData() : Boolean {
         return this._hasValidData;
      }
      
      public function get claimed() : int {
         return this._claimed;
      }
      
      public function get rankConfig() : Vector.<RankVO> {
         return this._rankConfig;
      }
      
      public function get campaignTitle() : String {
         return this._campaignTitle;
      }
      
      public function get campaignDescription() : String {
         return this._campaignDescription;
      }
      
      public function get campaignBannerUrl() : String {
         return this._campaignBannerUrl;
      }
      
      public function get isStarted() : Boolean {
         return new Date().time >= this._startDate.time;
      }
      
      public function get isEnded() : Boolean {
         return new Date().time >= this._endDate.time;
      }
      
      public function get isActive() : Boolean {
         return this.isStarted && new Date().time < this._activeUntil.time;
      }
      
      public function get nextClaimableTier() : int {
         var _loc3_:* = null;
         if(this._ranks.length == 0) {
            return 1;
         }
         var _loc1_:int = 1;
         var _loc2_:* = this._ranks;
         var _loc6_:int = 0;
         var _loc5_:* = this._ranks;
         for each(_loc3_ in this._ranks) {
            if(this._rank >= _loc1_ && this._claimed < _loc1_) {
               return _loc1_;
            }
            _loc1_++;
         }
         return this._rank;
      }
      
      public function parseConfigData(param1:XML) : void {
         this._hasValidData = param1.hasOwnProperty("CampaignConfig");
         if(this._hasValidData) {
            this.parseConfig(param1);
         }
         if(param1.hasOwnProperty("CampaignProgress")) {
            this.parseUpdateData(param1.CampaignProgress,false);
         }
      }
      
      public function updatePoints(param1:int) : void {
         this._points = param1;
         this._rank = this.getRankByPoints(this._points);
         StaticInjectorContext.getInjector().getInstance(UpdateCampaignProgress).dispatch();
      }
      
      public function getRankByPoints(param1:int) : int {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(!this.hasValidData) {
            return 0;
         }
         if(this._ranks != null && this._ranks.length > 0) {
            _loc3_ = 0;
            while(_loc3_ < this._ranks.length) {
               if(param1 >= this._ranks[_loc3_]) {
                  _loc2_ = _loc3_ + 1;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function parseUpdateData(param1:Object, param2:Boolean = true) : void {
         this._isUnlocked = int(this.getXMLData(param1,"Unlocked",false)) === 1;
         this._points = int(this.getXMLData(param1,"Points",false));
         this._rank = int(this.getXMLData(param1,"Rank",false));
         if(this._tempRank == 0) {
            this._tempRank = this._rank;
         }
         this._claimed = int(this.getXMLData(param1,"Claimed",false));
         if(param2) {
            StaticInjectorContext.getInjector().getInstance(UpdateCampaignProgress).dispatch();
         }
         if(this.hasMaxRank()) {
            StaticInjectorContext.getInjector().getInstance(MaxRankReachedSignal).dispatch();
         }
      }
      
      public function getCampaignImageByUrl(param1:String) : DisplayObject {
         return this._campaignImages[param1] as DisplayObject;
      }
      
      public function addCampaignImageByUrl(param1:String, param2:DisplayObject) : void {
         if(!this._campaignImages[param1]) {
            this._campaignImages[param1] = param2;
         }
      }
      
      public function getCampaignPictureUrlByRank(param1:int) : String {
         var _loc2_:* = "";
         if(this._picUrls && this._picUrls.length > 0 && param1 <= this._picUrls.length) {
            param1 = param1 == 0?1:param1;
            _loc2_ = this._picUrls[param1 - 1];
         }
         return _loc2_;
      }
      
      public function getStartTimeString() : String {
         var _loc1_:* = "";
         var _loc2_:Number = this.getSecondsToStart();
         if(_loc2_ <= 0) {
            return "";
         }
         if(_loc2_ > 86400) {
            _loc1_ = _loc1_ + TimeLeft.parse(_loc2_,"%dd %hh");
         } else if(_loc2_ > 3600) {
            _loc1_ = _loc1_ + TimeLeft.parse(_loc2_,"%hh %mm");
         } else if(_loc2_ > 60) {
            _loc1_ = _loc1_ + TimeLeft.parse(_loc2_,"%mm %ss");
         } else {
            _loc1_ = _loc1_ + TimeLeft.parse(_loc2_,"%ss");
         }
         return _loc1_;
      }
      
      public function hasMaxRank() : Boolean {
         return this._rank == this._maxRank;
      }
      
      private function parseConfig(param1:XML) : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         this._campaignTitle = this.getXMLData(param1.CampaignConfig,"Title",true);
         this._campaignDescription = this.getXMLData(param1.CampaignConfig,"Description",true);
         this._campaignBannerUrl = this.getXMLData(param1.CampaignConfig,"ExaltBannerUrl",true);
         this._unlockPrice = int(this.getXMLData(param1.CampaignConfig,"UnlockPrice",true));
         this._donatePointsRatio = int(this.getXMLData(param1.CampaignConfig,"DonatePointsRatio",true));
         this._endDate = new Date(int(this.getXMLData(param1.CampaignConfig,"CampaignEndDate",true)) * 1000);
         this._activeUntil = new Date(int(this.getXMLData(param1.CampaignConfig,"CampaignActiveUntil",true)) * 1000);
         this._startDate = new Date(int(this.getXMLData(param1.CampaignConfig,"CampaignStartDate",true)) * 1000);
         this._ranks = this.getXMLData(param1.CampaignConfig,"RanksList",true).split(",");
         if(this._ranks) {
            this._maxRank = this._ranks.length;
         }
         this._shopPurchasePointsRatio = int(this.getXMLData(param1.CampaignConfig,"ShopPurchasePointsRatio",true));
         this._rankConfig = new Vector.<RankVO>();
         while(_loc2_ < this._ranks.length) {
            this._rankConfig.push(new RankVO(this._ranks[_loc2_],SupporterCampaignModel.RANKS_NAMES[_loc2_]));
            _loc2_++;
         }
         this._picUrls = new Vector.<String>(0);
         var _loc5_:XMLList = XML(param1.CampaignConfig.PicUrls).children();
         var _loc6_:* = _loc5_;
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_;
         for each(_loc3_ in _loc5_) {
            this._picUrls.push(_loc3_);
         }
      }
      
      private function parseConfigStatus(param1:XML) : void {
         this._isUnlocked = int(this.getXMLData(param1.CampaignProgress,"Unlocked",false)) === 1;
         this._points = int(this.getXMLData(param1.CampaignProgress,"Points",false));
         this._rank = int(this.getXMLData(param1.CampaignProgress,"Rank",false));
         this._claimed = int(this.getXMLData(param1,"Claimed",false));
      }
      
      private function getXMLData(param1:Object, param2:String, param3:Boolean) : String {
         if(param1.hasOwnProperty(param2)) {
            return String(param1[param2]);
         }
         if(param3) {
            this._hasValidData = false;
         }
         return "";
      }
      
      private function getSecondsToStart() : Number {
         var _loc1_:Date = new Date();
         return (this._startDate.time - _loc1_.time) / 1000;
      }
   }
}
