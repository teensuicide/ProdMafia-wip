package com.company.assembleegameclient.appengine {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import flash.events.Event;
   import flash.system.System;
   import io.decagames.rotmg.tos.popups.ToSPopup;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.promotions.model.BeginnersPackageModel;
   import kabam.rotmg.servers.api.LatLong;
   import org.swiftsuspenders.Injector;
   
   public class SavedCharactersList extends Event {
      
      public static const SAVED_CHARS_LIST:String = "SAVED_CHARS_LIST";
      
      public static const AVAILABLE:String = "available";
      
      public static const UNAVAILABLE:String = "unavailable";
      
      public static const UNRESTRICTED:String = "unrestricted";
      
      private static const DEFAULT_LATLONG:LatLong = new LatLong(37.4436,-122.412);
      
      private static const DEFAULT_SALESFORCE:String = "unavailable";
       
      
      public var accountId_:String;
      
      public var nextCharId_:int;
      
      public var maxNumChars_:int;
      
      public var numChars_:int = 0;
      
      public var savedChars_:Vector.<SavedCharacter>;
      
      public var charStats_:Object;
      
      public var totalFame_:int = 0;
      
      public var bestCharFame_:int = 0;
      
      public var fame_:int = 0;
      
      public var credits_:int = 0;
      
      public var forgefire:int = 0;
      
      public var numStars_:int = 0;
      
      public var nextCharSlotPrice_:int;
      
      public var guildName_:String;
      
      public var guildRank_:int;
      
      public var name_:String = null;
      
      public var nameChosen_:Boolean;
      
      public var converted_:Boolean;
      
      public var isAdmin_:Boolean;
      
      public var canMapEdit_:Boolean;
      
      public var news_:Vector.<SavedNewsItem>;
      
      public var myPos_:LatLong;
      
      public var salesForceData_:String = "unavailable";
      
      public var hasPlayerDied:Boolean = false;
      
      public var classAvailability:Object;
      
      public var isAgeVerified:Boolean;
      
      public var vaultItems:Vector.<Vector.<int>>;
      
      private var origData_:String;
      
      private var charsXML_:XML;
      
      private var account:Account;
      
      public function SavedCharactersList(param1:String) {
         var _loc7_:* = undefined;
         var _loc6_:* = null;
         savedChars_ = new Vector.<SavedCharacter>();
         charStats_ = {};
         news_ = new Vector.<SavedNewsItem>();
         super("SAVED_CHARS_LIST");
         this.origData_ = param1;
         this.charsXML_ = new XML(this.origData_);
         var _loc3_:XML = XML(this.charsXML_.Account);
         this.parseUserData(_loc3_);
         this.parseBeginnersPackageData(_loc3_);
         this.parseGuildData(_loc3_);
         this.parseCharacterData();
         this.parseCharacterStatsData();
         this.parseNewsData();
         this.parseGeoPositioningData();
         this.parseSalesForceData();
         this.reportUnlocked();
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         if(_loc2_) {
            _loc6_ = _loc2_.getInstance(Account);
            _loc6_.reportIntStat("BestLevel",this.bestOverallLevel());
            _loc6_.reportIntStat("BestFame",this.bestOverallFame());
            _loc6_.reportIntStat("NumStars",this.numStars_);
            _loc6_.verify("VerifiedEmail" in _loc3_);
         }
         this.classAvailability = {};
         var _loc4_:* = this.charsXML_.ClassAvailabilityList.ClassAvailability;
         var _loc9_:int = 0;
         var _loc8_:* = this.charsXML_.ClassAvailabilityList.ClassAvailability;
         for each(_loc7_ in this.charsXML_.ClassAvailabilityList.ClassAvailability) {
            this.classAvailability[_loc7_.@id.toString()] = _loc7_.toString();
         }
      }
      
      override public function clone() : Event {
         return new SavedCharactersList(this.origData_);
      }
      
      override public function toString() : String {
         return "[ numChars: " + this.numChars_ + " maxNumChars: " + this.maxNumChars_ + " ]";
      }
      
      public function dispose() : void {
         System.disposeXML(this.charsXML_);
      }
      
      public function getCharById(param1:int) : SavedCharacter {
         var _loc2_:* = null;
         var _loc3_:* = this.savedChars_;
         var _loc6_:int = 0;
         var _loc5_:* = this.savedChars_;
         for each(_loc2_ in this.savedChars_) {
            if(_loc2_.charId() == param1) {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isFirstTimeLogin() : Boolean {
         return false in this.charsXML_;
      }
      
      public function bestLevel(param1:int) : int {
         var _loc2_:CharacterStats = this.charStats_[param1];
         return _loc2_ == null?0:_loc2_.bestLevel();
      }
      
      public function bestOverallLevel() : int {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = this.charStats_;
         var _loc6_:int = 0;
         var _loc5_:* = this.charStats_;
         for each(_loc1_ in this.charStats_) {
            if(_loc1_.bestLevel() > _loc3_) {
               _loc3_ = _loc1_.bestLevel();
            }
         }
         return _loc3_;
      }
      
      public function bestFame(param1:int) : int {
         var _loc2_:CharacterStats = this.charStats_[param1];
         return _loc2_ == null?0:_loc2_.bestFame();
      }
      
      public function bestOverallFame() : int {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = this.charStats_;
         var _loc6_:int = 0;
         var _loc5_:* = this.charStats_;
         for each(_loc1_ in this.charStats_) {
            if(_loc1_.bestFame() > _loc3_) {
               _loc3_ = _loc1_.bestFame();
            }
         }
         return _loc3_;
      }
      
      public function levelRequirementsMet(param1:int) : Boolean {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc2_:XML = ObjectLibrary.xmlLibrary_[param1];
         var _loc6_:* = _loc2_.UnlockLevel;
         var _loc8_:int = 0;
         var _loc7_:* = _loc2_.UnlockLevel;
         for each(_loc5_ in _loc2_.UnlockLevel) {
            _loc3_ = ObjectLibrary.idToType_[_loc5_.toString()];
            if(this.bestLevel(_loc3_) < int(_loc5_.@level)) {
               return false;
            }
         }
         return true;
      }
      
      public function availableCharSlots() : int {
         return this.maxNumChars_ - this.numChars_;
      }
      
      public function hasAvailableCharSlot() : Boolean {
         return this.numChars_ < this.maxNumChars_;
      }
      
      public function newUnlocks(param1:int, param2:int) : Array {
         var _loc11_:int = 0;
         var _loc12_:* = undefined;
         var _loc10_:* = null;
         var _loc7_:int = 0;
         var _loc6_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc3_:* = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc4_:* = [];
         while(_loc13_ < ObjectLibrary.playerChars_.length) {
            _loc10_ = ObjectLibrary.playerChars_[_loc13_];
            _loc7_ = _loc10_.@type;
            if(!this.levelRequirementsMet(_loc7_)) {
               _loc6_ = true;
               _loc5_ = false;
               _loc11_ = 0;
               _loc12_ = _loc10_.UnlockLevel;
               var _loc15_:int = 0;
               var _loc14_:* = _loc10_.UnlockLevel;
               for each(_loc3_ in _loc10_.UnlockLevel) {
                  _loc8_ = ObjectLibrary.idToType_[_loc3_.toString()];
                  _loc9_ = _loc3_.@level;
                  if(this.bestLevel(_loc8_) < _loc9_) {
                     if(_loc8_ != param1 || _loc9_ != param2) {
                        _loc6_ = false;
                        break;
                     }
                     _loc5_ = true;
                  }
               }
               if(_loc6_ && _loc5_) {
                  _loc4_.push(_loc7_);
               }
            }
            _loc13_++;
         }
         return _loc4_;
      }
      
      private function parseUserData(param1:XML) : void {
         this.accountId_ = param1.AccountId;
         this.name_ = param1.Name;
         this.nameChosen_ = "NameChosen" in param1;
         this.converted_ = "Converted" in param1;
         this.isAdmin_ = "Admin" in param1;
         Player.isAdmin = this.isAdmin_;
         Player.isMod = "Mod" in param1;
         this.canMapEdit_ = "MapEditor" in param1;
         this.totalFame_ = param1.Stats.TotalFame;
         this.bestCharFame_ = param1.Stats.BestCharFame;
         this.fame_ = param1.Stats.Fame;
         this.credits_ = param1.Credits;
         this.forgefire = param1.ForgeFireEnergy;
         this.nextCharSlotPrice_ = param1.NextCharSlotPrice;
         this.isAgeVerified = this.accountId_ != "" && param1.IsAgeVerified == 1;
         this.hasPlayerDied = true;
      }
      
      private function parseBeginnersPackageData(param1:XML) : void {
         var _loc3_:int = 0;
         var _loc2_:BeginnersPackageModel = this.getBeginnerModel();
         if(param1.hasOwnProperty("BeginnerPackageStatus")) {
            _loc3_ = param1.BeginnerPackageStatus;
            _loc2_.status = _loc3_;
         } else {
            _loc2_.status = 0;
         }
      }
      
      private function getBeginnerModel() : BeginnersPackageModel {
         var _loc1_:Injector = StaticInjectorContext.getInjector();
         return _loc1_.getInstance(BeginnersPackageModel);
      }
      
      private function parseGuildData(param1:XML) : void {
         var _loc2_:* = null;
         if("Guild" in param1) {
            _loc2_ = XML(param1.Guild);
            this.guildName_ = _loc2_.Name;
            this.guildRank_ = _loc2_.Rank;
         }
      }
      
      private function parseCharacterData() : void {
         var _loc3_:* = null;
         this.nextCharId_ = int(this.charsXML_.@nextCharId);
         this.maxNumChars_ = int(this.charsXML_.@maxNumChars);
         var _loc1_:* = this.charsXML_.Char;
         var _loc5_:int = 0;
         var _loc4_:* = this.charsXML_.Char;
         for each(_loc3_ in this.charsXML_.Char) {
            this.savedChars_.push(new SavedCharacter(_loc3_,this.name_));
            this.numChars_++;
         }
         this.savedChars_.sort(SavedCharacter.compare);
      }
      
      private function parseCharacterStatsData() : void {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc5_:XML = XML(this.charsXML_.Account.Stats);
         var _loc6_:* = _loc5_.ClassStats;
         var _loc8_:int = 0;
         var _loc7_:* = _loc5_.ClassStats;
         for each(_loc1_ in _loc5_.ClassStats) {
            _loc3_ = _loc1_.@objectType;
            _loc2_ = new CharacterStats(_loc1_);
            this.numStars_ = this.numStars_ + _loc2_.numStars();
            this.charStats_[_loc3_] = _loc2_;
         }
      }
      
      private function parseNewsData() : void {
         var _loc1_:* = null;
         var _loc3_:XML = XML(this.charsXML_.News);
         var _loc2_:* = _loc3_.Item;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_.Item;
         for each(_loc1_ in _loc3_.Item) {
            this.news_.push(new SavedNewsItem(_loc1_.Icon,_loc1_.Title,_loc1_.TagLine,_loc1_.Link,_loc1_.Date));
         }
      }
      
      private function parseGeoPositioningData() : void {
         if("Lat" in this.charsXML_ && "Long" in this.charsXML_) {
            this.myPos_ = new LatLong(this.charsXML_.Lat,this.charsXML_.Long);
         } else {
            this.myPos_ = DEFAULT_LATLONG;
         }
      }
      
      private function parseSalesForceData() : void {
         if("SalesForce" in this.charsXML_ && "SalesForce" in this.charsXML_) {
            this.salesForceData_ = this.charsXML_.SalesForce;
         }
      }
      
      private function parseTOSPopup() : void {
         if("TOSPopup" in this.charsXML_) {
            StaticInjectorContext.getInjector().getInstance(ShowPopupSignal).dispatch(new ToSPopup());
         }
      }
      
      private function reportUnlocked() : void {
         var _loc1_:Injector = StaticInjectorContext.getInjector();
         if(_loc1_) {
            this.account = _loc1_.getInstance(Account);
            this.account && this.updateAccount();
         }
      }
      
      private function updateAccount() : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < ObjectLibrary.playerChars_.length) {
            _loc3_ = ObjectLibrary.playerChars_[_loc1_];
            _loc2_ = _loc3_.@type;
            if(this.levelRequirementsMet(_loc2_)) {
               this.account.reportIntStat(_loc3_.@id + "Unlocked",1);
               _loc4_++;
            }
            _loc1_++;
         }
         this.account.reportIntStat("ClassesUnlocked",_loc4_);
      }
   }
}
