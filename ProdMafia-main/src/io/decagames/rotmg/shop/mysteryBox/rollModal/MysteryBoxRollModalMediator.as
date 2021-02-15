package io.decagames.rotmg.shop.mysteryBox.rollModal {
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.shop.genericBox.BoxUtils;
   import io.decagames.rotmg.supportCampaign.data.SupporterCampaignModel;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.dictionary.DictionaryUtils;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.mysterybox.services.GetMysteryBoxesTask;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class MysteryBoxRollModalMediator extends Mediator {
       
      
      [Inject]
      public var view:MysteryBoxRollModal;
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var getMysteryBoxesTask:GetMysteryBoxesTask;
      
      [Inject]
      public var supportCampaignModel:SupporterCampaignModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var boxConfig:Array;
      
      private var swapImageTimer:Timer;
      
      private var totalRollDelay:int = 2000;
      
      private var nextRollDelay:int = 550;
      
      private var quantity:int = 1;
      
      private var requestComplete:Boolean;
      
      private var timerComplete:Boolean;
      
      private var rollNumber:int = 0;
      
      private var timeout:uint;
      
      private var rewardsList:Array;
      
      private var totalRewards:int = 0;
      
      private var closeButton:SliceScalingButton;
      
      private var totalRolls:int = 1;
      
      public function MysteryBoxRollModalMediator() {
         swapImageTimer = new Timer(80);
         rewardsList = [];
         super();
      }
      
      override public function initialize() : void {
         this.configureRoll();
         this.swapImageTimer.addEventListener("timer",this.swapItems);
         this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
         this.closeButton.clickSignal.addOnce(this.onClose);
         this.view.header.addButton(this.closeButton,"right_button");
         this.boxConfig = this.parseBoxContents();
         this.quantity = this.view.quantity;
         this.playRollAnimation();
         this.sendRollRequest();
      }
      
      override public function destroy() : void {
         this.closeButton.clickSignal.remove(this.onClose);
         this.closeButton.dispose();
         this.swapImageTimer.removeEventListener("timer",this.swapItems);
         this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
         this.view.buyButton.clickSignal.remove(this.buyMore);
         this.view.finishedShowingResult.remove(this.onAnimationFinished);
      }
      
      private function sendRollRequest() : void {
         this.view.spinner.valueWasChanged.remove(this.changeAmountHandler);
         this.view.buyButton.clickSignal.remove(this.buyMore);
         this.closeButton.clickSignal.remove(this.onClose);
         this.requestComplete = false;
         this.timerComplete = false;
         var _loc1_:Object = this.account.getCredentials();
         _loc1_.boxId = this.view.info.id;
         if(this.view.info.isOnSale()) {
            _loc1_.quantity = this.quantity;
            _loc1_.price = this.view.info.saleAmount;
            _loc1_.currency = this.view.info.saleCurrency;
         } else {
            _loc1_.quantity = this.quantity;
            _loc1_.price = this.view.info.priceAmount;
            _loc1_.currency = this.view.info.priceCurrency;
         }
         this.client.sendRequest("/account/purchaseMysteryBox",_loc1_);
         this.client.complete.addOnce(this.onRollRequestComplete);
         this.timeout = setTimeout(this.showRewards,this.totalRollDelay);
      }
      
      private function showRewards() : void {
         var _loc1_:* = null;
         this.timerComplete = true;
         clearTimeout(this.timeout);
         if(this.requestComplete) {
            this.view.finishedShowingResult.add(this.onAnimationFinished);
            this.view.bigSpinner.pause();
            this.view.littleSpinner.pause();
            this.swapImageTimer.stop();
            _loc1_ = this.rewardsList[this.rollNumber];
            if(this.rollNumber == 0) {
               this.view.prepareResultGrid(this.totalRewards);
            }
            this.view.displayResult([_loc1_]);
         }
      }
      
      private function onRollRequestComplete(param1:Boolean, param2:*) : void {
         var _loc6_:int = 0;
         var _loc12_:* = undefined;
         var _loc11_:* = null;
         var _loc14_:* = null;
         var _loc15_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc10_:int = 0;
         var _loc13_:* = null;
         var _loc4_:int = 0;
         var _loc9_:* = null;
         this.requestComplete = true;
         if(param1) {
            _loc11_ = new XML(param2);
            this.rewardsList = [];
            if(_loc11_.hasOwnProperty("CampaignProgress")) {
               this.supportCampaignModel.parseUpdateData(_loc11_.CampaignProgress);
            }
            _loc6_ = 0;
            _loc12_ = _loc11_.elements("Awards");
            var _loc17_:int = 0;
            var _loc16_:* = _loc11_.elements("Awards");
            for each(_loc14_ in _loc11_.elements("Awards")) {
               _loc5_ = _loc14_.toString().split(",");
               _loc8_ = this.convertItemsToAmountDictionary(_loc5_);
               this.totalRewards = this.totalRewards + DictionaryUtils.countKeys(_loc8_);
               this.rewardsList.push(_loc8_);
            }
            if(_loc11_.hasOwnProperty("Left") && this.view.info.unitsLeft != -1) {
               this.view.info.unitsLeft = _loc11_.Left;
               if(this.view.info.unitsLeft == 0) {
                  this.view.buyButton.soldOut = true;
               }
            }
            _loc15_ = this.gameModel.player;
            if(_loc15_ != null) {
               if(_loc11_.hasOwnProperty("Gold")) {
                  _loc15_.setCredits(_loc11_.Gold);
               } else if(_loc11_.hasOwnProperty("Fame")) {
                  _loc15_.setFame(_loc11_.Fame);
               }
            } else if(this.playerModel != null) {
               if(_loc11_.hasOwnProperty("Gold")) {
                  this.playerModel.setCredits(_loc11_.Gold);
               } else if(_loc11_.hasOwnProperty("Fame")) {
                  this.playerModel.setFame(_loc11_.Fame);
               }
            }
            if(_loc11_.hasOwnProperty("PurchaseLeft") && this.view.info.purchaseLeft != -1) {
               this.view.info.purchaseLeft = _loc11_.PurchaseLeft;
               if(this.view.info.purchaseLeft <= 0) {
                  this.view.buyButton.soldOut = true;
               }
            }
            if(this.timerComplete) {
               this.showRewards();
            }
         } else {
            clearTimeout(this.timeout);
            _loc3_ = "MysteryBoxRollModal.pleaseTryAgainString";
            if(LineBuilder.getLocalizedStringFromKey(param2) != "") {
               _loc3_ = param2;
            }
            if(param2.indexOf("MysteryBoxError.soldOut") >= 0) {
               _loc7_ = param2.split("|");
               if(_loc7_.length == 2) {
                  _loc10_ = _loc7_[1];
                  this.view.info.unitsLeft = _loc10_;
                  if(_loc10_ == 0) {
                     _loc3_ = "MysteryBoxError.soldOutAll";
                  } else {
                     _loc3_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft",{
                        "left":this.view.info.unitsLeft,
                        "box":(this.view.info.unitsLeft == 1?LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box"):LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                     });
                  }
               }
            }
            if(param2.indexOf("MysteryBoxError.maxPurchase") >= 0) {
               _loc13_ = param2.split("|");
               if(_loc13_.length == 2) {
                  _loc4_ = _loc13_[1];
                  if(_loc4_ == 0) {
                     _loc3_ = "MysteryBoxError.maxPurchase";
                  } else {
                     _loc3_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft",{"left":_loc4_});
                  }
               }
            }
            if(param2.indexOf("blockedForUser") >= 0) {
               _loc9_ = param2.split("|");
               if(_loc9_.length == 2) {
                  _loc3_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser",{"date":_loc9_[1]});
               }
            }
            this.showErrorMessage(_loc3_);
         }
      }
      
      private function showErrorMessage(param1:String) : void {
         this.closePopupSignal.dispatch(this.view);
         this.showPopupSignal.dispatch(new ErrorModal(300,LineBuilder.getLocalizedStringFromKey("MysteryBoxRollModal.purchaseFailedString",{}),LineBuilder.getLocalizedStringFromKey(param1,{})));
         this.getMysteryBoxesTask.start();
      }
      
      private function configureRoll() : void {
         if(this.view.info.quantity > 1) {
            this.totalRollDelay = 1000;
         }
      }
      
      private function convertItemsToAmountDictionary(param1:Array) : Dictionary {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc5_:* = undefined;
         var _loc3_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         var _loc6_:* = param1;
         var _loc10_:int = 0;
         var _loc9_:* = param1;
         for each(_loc3_ in param1) {
            if(_loc2_[_loc3_]) {
               _loc7_ = _loc2_;
               _loc8_ = _loc3_;
               _loc5_ = Number(_loc7_[_loc8_]) + 1;
               _loc7_[_loc8_] = _loc5_;
            } else {
               _loc2_[_loc3_] = 1;
            }
         }
         return _loc2_;
      }
      
      private function parseBoxContents() : Array {
         var _loc7_:int = 0;
         var _loc6_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc11_:* = null;
         var _loc10_:* = null;
         var _loc8_:Array = this.view.info.contents.split("|");
         var _loc1_:* = [];
         var _loc2_:* = _loc8_;
         var _loc15_:int = 0;
         var _loc14_:* = _loc8_;
         for each(_loc3_ in _loc8_) {
            _loc9_ = [];
            _loc11_ = _loc3_.split(";");
            _loc7_ = 0;
            _loc6_ = _loc11_;
            var _loc13_:int = 0;
            var _loc12_:* = _loc11_;
            for each(_loc10_ in _loc11_) {
               _loc9_.push(this.convertItemsToAmountDictionary(_loc10_.split(",")));
            }
            _loc1_[_loc4_] = _loc9_;
            _loc4_++;
         }
         this.totalRolls = _loc4_;
         return _loc1_;
      }
      
      private function onAnimationFinished() : void {
         this.rollNumber++;
         if(this.rollNumber < this.view.quantity) {
            this.playRollAnimation();
            this.timeout = setTimeout(this.showRewards,this.view.totalAnimationTime(this.totalRolls) + this.nextRollDelay);
         } else {
            this.closeButton.clickSignal.addOnce(this.onClose);
            this.view.spinner.valueWasChanged.add(this.changeAmountHandler);
            this.view.spinner.value = this.view.quantity;
            this.view.showBuyButton();
            this.view.buyButton.clickSignal.add(this.buyMore);
         }
      }
      
      private function changeAmountHandler(param1:int) : void {
         if(this.view.info.isOnSale()) {
            this.view.buyButton.price = param1 * this.view.info.saleAmount;
         } else {
            this.view.buyButton.price = param1 * this.view.info.priceAmount;
         }
      }
      
      private function buyMore(param1:BaseButton) : void {
         var _loc2_:Boolean = BoxUtils.moneyCheckPass(this.view.info,this.view.spinner.value,this.gameModel,this.playerModel,this.showPopupSignal);
         if(_loc2_) {
            this.rollNumber = 0;
            this.totalRewards = 0;
            this.view.buyMore(this.view.spinner.value);
            this.configureRoll();
            this.quantity = this.view.quantity;
            this.playRollAnimation();
            this.sendRollRequest();
         }
      }
      
      private function playRollAnimation() : void {
         this.view.bigSpinner.resume();
         this.view.littleSpinner.resume();
         this.swapImageTimer.start();
         this.swapItems(null);
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      private function swapItems(param1:TimerEvent) : void {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = [];
         var _loc6_:* = this.boxConfig;
         var _loc8_:int = 0;
         var _loc7_:* = this.boxConfig;
         for each(_loc5_ in this.boxConfig) {
            _loc3_ = Math.floor(Math.random() * _loc5_.length);
            _loc2_.push(_loc5_[_loc3_]);
         }
         this.view.displayItems(_loc2_);
      }
   }
}
