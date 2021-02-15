package kabam.rotmg.mysterybox.components {
   import com.company.assembleegameclient.map.ParticleModalMap;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.gskinner.motion.GTween;
   import com.gskinner.motion.easing.Sine;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.utils.Timer;
   import io.decagames.rotmg.pets.utils.PetsViewAssetFactory;
   import io.decagames.rotmg.shop.ShopPopupView;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.assets.EmbeddedAssets;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
   import kabam.rotmg.pets.view.components.DialogCloseButton;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.view.NotEnoughGoldDialog;
   import kabam.rotmg.ui.view.components.Spinner;
   import kabam.rotmg.util.components.ItemWithTooltip;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import kabam.rotmg.util.components.UIAssetsHelper;
   import org.swiftsuspenders.Injector;
   
   public class MysteryBoxRollModal extends Sprite {
      
      public static const WIDTH:int = 415;
      
      public static const HEIGHT:int = 400;
      
      public static const TEXT_MARGIN:int = 20;
      
      public static var open:Boolean;
       
      
      private const ROLL_STATE:int = 1;
      
      private const IDLE_STATE:int = 0;
      
      private const iconSize:Number = 160;
      
      private const playAgainString:String = "MysteryBoxRollModal.playAgainString";
      
      private const playAgainXTimesString:String = "MysteryBoxRollModal.playAgainXTimesString";
      
      private const youWonString:String = "MysteryBoxRollModal.youWonString";
      
      private const rewardsInVaultString:String = "MysteryBoxRollModal.rewardsInVaultString";
      
      public var client:AppEngineClient;
      
      public var account:Account;
      
      public var parentSelectModal:MysteryBoxSelectModal;
      
      private var state:int;
      
      private var isShowReward:Boolean = false;
      
      private var rollCount:int = 0;
      
      private var rollTarget:int = 0;
      
      private var quantity_:int = 0;
      
      private var mbi:MysteryBoxInfo;
      
      private var spinners:Sprite;
      
      private var itemBitmaps:Vector.<Bitmap>;
      
      private var rewardsArray:Vector.<ItemWithTooltip>;
      
      private var closeButton:DialogCloseButton;
      
      private var particleModalMap:ParticleModalMap;
      
      private var minusNavSprite:Sprite;
      
      private var plusNavSprite:Sprite;
      
      private var boxButton:LegacyBuyButton;
      
      private var titleText:TextFieldDisplayConcrete;
      
      private var infoText:TextFieldDisplayConcrete;
      
      private var descTexts:Vector.<TextFieldDisplayConcrete>;
      
      private var swapImageTimer:Timer;
      
      private var totalRollTimer:Timer;
      
      private var nextRollTimer:Timer;
      
      private var indexInRolls:Vector.<int>;
      
      private var lastReward:String = "";
      
      private var requestComplete:Boolean = false;
      
      private var timerComplete:Boolean = false;
      
      private var goldBackground:DisplayObject;
      
      private var goldBackgroundMask:DisplayObject;
      
      private var rewardsList:Array;
      
      public function MysteryBoxRollModal(param1:MysteryBoxInfo, param2:int) {
         var _loc3_:int = 0;
         spinners = new Sprite();
         itemBitmaps = new Vector.<Bitmap>();
         rewardsArray = new Vector.<ItemWithTooltip>();
         closeButton = PetsViewAssetFactory.returnCloseButton(415);
         boxButton = new LegacyBuyButton("MysteryBoxRollModal.playAgainString",16,0,-1);
         descTexts = new Vector.<TextFieldDisplayConcrete>();
         swapImageTimer = new Timer(50);
         totalRollTimer = new Timer(2000);
         nextRollTimer = new Timer(800);
         indexInRolls = new Vector.<int>();
         goldBackground = new EmbeddedAssets.EvolveBackground();
         goldBackgroundMask = new EmbeddedAssets.EvolveBackground();
         super();
         this.mbi = param1;
         this.closeButton.disableLegacyCloseBehavior();
         this.closeButton.addEventListener("click",this.onCloseClick);
         addEventListener("removedFromStage",this.onRemovedFromStage);
         this.infoText = this.getText("MysteryBoxRollModal.rewardsInVaultString",20,220).setSize(20).setColor(0);
         this.infoText.y = 40;
         this.infoText.filters = [];
         this.addComponemts();
         open = true;
         this.boxButton.x = this.boxButton.x + 107.5;
         this.boxButton.y = this.boxButton.y + 357;
         this.boxButton._width = 200;
         this.boxButton.addEventListener("click",this.onRollClick);
         this.minusNavSprite = UIAssetsHelper.createLeftNevigatorIcon("left",3);
         this.minusNavSprite.addEventListener("click",this.onNavClick);
         this.minusNavSprite.filters = [new GlowFilter(0,1,2,2,10,1)];
         this.minusNavSprite.x = 317.5;
         this.minusNavSprite.y = 365;
         this.minusNavSprite.alpha = 0;
         addChild(this.minusNavSprite);
         this.plusNavSprite = UIAssetsHelper.createLeftNevigatorIcon("right",3);
         this.plusNavSprite.addEventListener("click",this.onNavClick);
         this.plusNavSprite.filters = [new GlowFilter(0,1,2,2,10,1)];
         this.plusNavSprite.x = 317.5;
         this.plusNavSprite.y = 350;
         this.plusNavSprite.alpha = 0;
         addChild(this.plusNavSprite);
         var _loc4_:Injector = StaticInjectorContext.getInjector();
         this.client = _loc4_.getInstance(AppEngineClient);
         this.account = _loc4_.getInstance(Account);
         while(_loc3_ < this.mbi._rollsWithContents.length) {
            this.indexInRolls.push(0);
            _loc3_++;
         }
         this.centerModal();
         this.configureRollByQuantity(param2);
         this.sendRollRequest();
      }
      
      private static function makeModalBackground(param1:int, param2:int) : PopupWindowBackground {
         var _loc3_:PopupWindowBackground = new PopupWindowBackground();
         _loc3_.draw(param1,param2,1);
         return _loc3_;
      }
      
      public function getText(param1:String, param2:int, param3:int, param4:Boolean = false) : TextFieldDisplayConcrete {
         var _loc5_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(16777215).setTextWidth(375);
         _loc5_.setBold(true);
         if(param4) {
            _loc5_.setStringBuilder(new StaticStringBuilder(param1));
         } else {
            _loc5_.setStringBuilder(new LineBuilder().setParams(param1));
         }
         _loc5_.setWordWrap(true);
         _loc5_.setMultiLine(true);
         _loc5_.setAutoSize("center");
         _loc5_.setHorizontalAlign("center");
         _loc5_.filters = [new DropShadowFilter(0,0,0)];
         _loc5_.x = param2;
         _loc5_.y = param3;
         return _loc5_;
      }
      
      public function moneyCheckPass() : Boolean {
         var _loc5_:int = 0;
         var _loc1_:int = 0;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(this.mbi.isOnSale() && this.mbi.saleAmount > 0) {
            _loc5_ = this.mbi.saleCurrency;
            _loc1_ = this.mbi.saleAmount * this.quantity_;
         } else {
            _loc5_ = this.mbi.priceCurrency;
            _loc1_ = this.mbi.priceAmount * this.quantity_;
         }
         var _loc3_:Boolean = true;
         var _loc8_:Player = StaticInjectorContext.getInjector().getInstance(GameModel).player;
         if(_loc8_ != null) {
            _loc4_ = _loc8_.credits_;
            _loc2_ = _loc8_.fame_;
         } else {
            _loc6_ = StaticInjectorContext.getInjector().getInstance(PlayerModel);
            if(_loc6_ != null) {
               _loc4_ = _loc6_.getCredits();
               _loc2_ = _loc6_.getFame();
            }
         }
         if(_loc5_ == 0 && _loc4_ < _loc1_) {
            _loc7_ = StaticInjectorContext.getInjector().getInstance(ShowPopupSignal);
            _loc7_.dispatch(new NotEnoughGoldDialog());
            _loc3_ = false;
         } else if(_loc5_ == 1 && _loc2_ < _loc1_) {
            _loc7_ = StaticInjectorContext.getInjector().getInstance(ShowPopupSignal);
            _loc7_.dispatch(new NotEnoughGoldDialog());
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private function configureRollByQuantity(param1:int) : void {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.quantity_ = param1;
         var _loc4_:* = int(param1) - 1;
         switch(_loc4_) {
            case 0:
               this.rollCount = 1;
               this.rollTarget = 1;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 2000;
               break;
            case 4:
               this.rollCount = 0;
               this.rollTarget = 4;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 1000;
               break;
            case 9:
               this.rollCount = 0;
               this.rollTarget = 9;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 1000;
               break;
            default:
               this.rollCount = 1;
               this.rollTarget = 1;
               this.swapImageTimer.delay = 50;
               this.totalRollTimer.delay = 2000;
         }
         if(this.mbi.isOnSale()) {
            _loc2_ = this.mbi.saleAmount * this.quantity_;
            _loc3_ = this.mbi.saleCurrency;
         } else {
            _loc2_ = this.mbi.priceAmount * this.quantity_;
            _loc3_ = this.mbi.priceCurrency;
         }
         if(this.quantity_ == 1) {
            this.boxButton.setPrice(_loc2_,this.mbi.priceCurrency);
         } else {
            this.boxButton.currency = _loc3_;
            this.boxButton.price = _loc2_;
            this.boxButton.setStringBuilder(new LineBuilder().setParams("MysteryBoxRollModal.playAgainXTimesString",{
               "cost":_loc2_.toString(),
               "repeat":this.quantity_.toString()
            }));
         }
      }
      
      private function addComponemts() : void {
         var _loc1_:* = 27;
         this.goldBackground.y = _loc1_;
         this.goldBackgroundMask.y = _loc1_;
         _loc1_ = 1;
         this.goldBackground.x = _loc1_;
         this.goldBackgroundMask.x = _loc1_;
         _loc1_ = 414;
         this.goldBackground.width = _loc1_;
         this.goldBackgroundMask.width = _loc1_;
         _loc1_ = 372;
         this.goldBackground.height = _loc1_;
         this.goldBackgroundMask.height = _loc1_;
         addChild(this.goldBackground);
         addChild(this.goldBackgroundMask);
         var _loc2_:Spinner = new Spinner();
         var _loc3_:Spinner = new Spinner();
         _loc2_.degreesPerSecond = 50;
         _loc3_.degreesPerSecond = _loc2_.degreesPerSecond * 1.5;
         _loc3_.width = _loc2_.width * 0.7;
         _loc3_.height = _loc2_.height * 0.7;
         _loc1_ = 0.7;
         _loc2_.alpha = _loc1_;
         _loc3_.alpha = _loc1_;
         this.spinners.addChild(_loc2_);
         this.spinners.addChild(_loc3_);
         this.spinners.mask = this.goldBackgroundMask;
         this.spinners.x = 207.5;
         this.spinners.y = 173.333333333333;
         this.spinners.alpha = 0;
         addChild(this.spinners);
         addChild(makeModalBackground(415,400));
         addChild(this.closeButton);
         this.particleModalMap = new ParticleModalMap(2);
         addChild(this.particleModalMap);
      }
      
      private function sendRollRequest() : void {
         if(!this.moneyCheckPass()) {
            return;
         }
         this.state = 1;
         this.closeButton.visible = false;
         var _loc1_:Object = this.account.getCredentials();
         _loc1_.boxId = this.mbi.id;
         if(this.mbi.isOnSale()) {
            _loc1_.quantity = this.quantity_;
            _loc1_.price = this.mbi.saleAmount;
            _loc1_.currency = this.mbi.saleCurrency;
         } else {
            _loc1_.quantity = this.quantity_;
            _loc1_.price = this.mbi.priceAmount;
            _loc1_.currency = this.mbi.priceCurrency;
         }
         this.client.sendRequest("/account/purchaseMysteryBox",_loc1_);
         this.titleText = this.getText(this.mbi.title,20,6,true).setSize(18);
         this.titleText.setColor(16768512);
         addChild(this.titleText);
         addChild(this.infoText);
         this.playRollAnimation();
         this.lastReward = "";
         this.rewardsList = [];
         this.requestComplete = false;
         this.timerComplete = false;
         this.totalRollTimer.addEventListener("timer",this.onTotalRollTimeComplete);
         this.totalRollTimer.start();
         this.client.complete.addOnce(this.onComplete);
      }
      
      private function playRollAnimation() : void {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.mbi._rollsWithContents.length) {
            _loc1_ = new Bitmap(ObjectLibrary.getRedrawnTextureFromType(this.mbi._rollsWithContentsUnique[this.indexInRolls[_loc2_]],160,true));
            this.itemBitmaps.push(_loc1_);
            _loc2_++;
         }
         this.displayItems(this.itemBitmaps);
         this.swapImageTimer.addEventListener("timer",this.swapItemImage);
         this.swapImageTimer.start();
      }
      
      private function prepareNextRoll() : void {
         this.titleText = this.getText(this.mbi.title,20,6,true).setSize(18);
         this.titleText.setColor(16768512);
         addChild(this.titleText);
         addChild(this.infoText);
         this.playRollAnimation();
         this.timerComplete = false;
         this.lastReward = this.rewardsList[0];
         this.totalRollTimer.addEventListener("timer",this.onTotalRollTimeComplete);
         this.totalRollTimer.start();
      }
      
      private function displayItems(param1:Vector.<Bitmap>) : void {
         var _loc2_:* = null;
         var _loc5_:* = int(param1.length) - 1;
         switch(_loc5_) {
            case 0:
               param1[0].x = param1[0].x + 167.5;
               param1[0].y = param1[0].y + 133.333333333333;
               break;
            case 1:
               param1[0].x = param1[0].x + 227.5;
               param1[0].y = param1[0].y + 133.333333333333;
               param1[1].x = param1[1].x + 107.5;
               param1[1].y = param1[1].y + 133.333333333333;
               break;
            case 2:
               param1[0].x = param1[0].x + 67.5;
               param1[0].y = param1[0].y + 133.333333333333;
               param1[1].x = param1[1].x + 167.5;
               param1[1].y = param1[1].y + 133.333333333333;
               param1[2].x = param1[2].x + 267.5;
               param1[2].y = param1[2].y + 133.333333333333;
         }
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(_loc2_ in param1) {
            addChild(_loc2_);
         }
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc17_:* = null;
         var _loc12_:* = null;
         var _loc10_:* = null;
         var _loc14_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc13_:int = 0;
         var _loc3_:* = null;
         var _loc18_:int = 0;
         var _loc16_:* = null;
         this.requestComplete = true;
         if(param1) {
            _loc17_ = new XML(param2);
            _loc4_ = 0;
            _loc5_ = _loc17_.elements("Awards");
            var _loc20_:int = 0;
            var _loc19_:* = _loc17_.elements("Awards");
            for each(_loc12_ in _loc17_.elements("Awards")) {
               this.rewardsList.push(_loc12_.toString());
            }
            this.lastReward = this.rewardsList[0];
            if(this.timerComplete) {
               this.showReward();
            }
            if(_loc17_.hasOwnProperty("Left") && this.mbi.unitsLeft != -1) {
               this.mbi.unitsLeft = _loc17_.Left;
            }
            _loc10_ = StaticInjectorContext.getInjector().getInstance(GameModel).player;
            if(_loc10_ != null) {
               if(_loc17_.hasOwnProperty("Gold")) {
                  _loc10_.setCredits(_loc17_.Gold);
               } else if(_loc17_.hasOwnProperty("Fame")) {
                  _loc10_.fame_ = _loc17_.Fame;
               }
            } else {
               _loc14_ = StaticInjectorContext.getInjector().getInstance(PlayerModel);
               if(_loc14_ != null) {
                  if(_loc17_.hasOwnProperty("Gold")) {
                     _loc14_.setCredits(_loc17_.Gold);
                  } else if(_loc17_.hasOwnProperty("Fame")) {
                     _loc14_.setFame(_loc17_.Fame);
                  }
               }
            }
            if(_loc17_.hasOwnProperty("PurchaseLeft") && this.mbi.purchaseLeft != -1) {
               this.mbi.purchaseLeft = _loc17_.PurchaseLeft;
            }
         } else {
            this.totalRollTimer.removeEventListener("timer",this.onTotalRollTimeComplete);
            this.totalRollTimer.stop();
            _loc8_ = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            _loc6_ = "MysteryBoxRollModal.pleaseTryAgainString";
            if(LineBuilder.getLocalizedStringFromKey(param2) != "") {
               _loc6_ = param2;
            }
            if(param2.indexOf("MysteryBoxError.soldOut") >= 0) {
               _loc7_ = param2.split("|");
               if(_loc7_.length == 2) {
                  _loc13_ = _loc7_[1];
                  if(_loc13_ == 0) {
                     _loc6_ = "MysteryBoxError.soldOutAll";
                  } else {
                     _loc6_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.soldOutLeft",{
                        "left":this.mbi.unitsLeft,
                        "box":(this.mbi.unitsLeft == 1?LineBuilder.getLocalizedStringFromKey("MysteryBoxError.box"):LineBuilder.getLocalizedStringFromKey("MysteryBoxError.boxes"))
                     });
                  }
               }
            }
            if(param2.indexOf("MysteryBoxError.maxPurchase") >= 0) {
               _loc3_ = param2.split("|");
               if(_loc3_.length == 2) {
                  _loc18_ = _loc3_[1];
                  if(_loc18_ == 0) {
                     _loc6_ = "MysteryBoxError.maxPurchase";
                  } else {
                     _loc6_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.maxPurchaseLeft",{"left":_loc18_});
                  }
               }
            }
            if(param2.indexOf("blockedForUser") >= 0) {
               _loc16_ = param2.split("|");
               if(_loc16_.length == 2) {
                  _loc6_ = LineBuilder.getLocalizedStringFromKey("MysteryBoxError.blockedForUser",{"date":_loc16_[1]});
               }
            }
            _loc11_ = new Dialog("MysteryBoxRollModal.purchaseFailedString",_loc6_,"MysteryBoxRollModal.okString",null,null);
            _loc11_.addEventListener("dialogLeftButton",this.onErrorOk);
            _loc8_.dispatch(_loc11_);
            this.close(true);
         }
      }
      
      private function close(param1:Boolean = false) : void {
         var _loc2_:* = null;
         if(this.state == 1) {
            return;
         }
         if(!param1) {
            _loc2_ = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
            if(this.parentSelectModal != null) {
               this.parentSelectModal.updateContent();
               _loc2_.dispatch(this.parentSelectModal);
            } else {
               _loc2_.dispatch(new ShopPopupView());
            }
         }
         open = false;
      }
      
      private function showReward() : void {
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         this.swapImageTimer.removeEventListener("timer",this.swapItemImage);
         this.swapImageTimer.stop();
         this.state = 0;
         if(this.rollCount < this.rollTarget) {
            this.nextRollTimer.addEventListener("timer",this.onNextRollTimerComplete);
            this.nextRollTimer.start();
         }
         this.closeButton.visible = true;
         var _loc5_:String = this.rewardsList.shift();
         var _loc1_:Array = _loc5_.split(",");
         removeChild(this.infoText);
         this.titleText.setStringBuilder(new LineBuilder().setParams("MysteryBoxRollModal.youWonString"));
         this.titleText.setColor(16768512);
         var _loc3_:int = 40;
         var _loc6_:* = _loc1_;
         var _loc10_:int = 0;
         var _loc9_:* = _loc1_;
         for each(_loc7_ in _loc1_) {
            _loc8_ = this.getText(ObjectLibrary.typeToDisplayId_[_loc7_],20,_loc3_).setSize(16).setColor(0);
            _loc8_.filters = [];
            _loc8_.setSize(18);
            _loc8_.x = 20;
            addChild(_loc8_);
            this.descTexts.push(_loc8_);
            _loc3_ = _loc3_ + 25;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length) {
            if(_loc2_ < this.itemBitmaps.length) {
               this.itemBitmaps[_loc2_].bitmapData = new Bitmap(ObjectLibrary.getRedrawnTextureFromType(_loc1_[_loc2_],160,true)).bitmapData;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < this.itemBitmaps.length) {
            this.doEaseInAnimation(this.itemBitmaps[_loc2_],{
               "scaleX":1.25,
               "scaleY":1.25
            },{
               "scaleX":1,
               "scaleY":1
            });
            _loc2_++;
         }
         this.boxButton.alpha = 0;
         addChild(this.boxButton);
         if(this.rollCount == this.rollTarget) {
            this.doEaseInAnimation(this.boxButton,{"alpha":0},{"alpha":1});
            this.doEaseInAnimation(this.minusNavSprite,{"alpha":0},{"alpha":1});
            this.doEaseInAnimation(this.plusNavSprite,{"alpha":0},{"alpha":1});
         }
         this.doEaseInAnimation(this.spinners,{"alpha":0},{"alpha":1});
         this.isShowReward = true;
      }
      
      private function doEaseInAnimation(param1:DisplayObject, param2:Object = null, param3:Object = null) : void {
         var _loc4_:GTween = new GTween(param1,0.5,param2,{"ease":Sine.easeOut});
         _loc4_.nextTween = new GTween(param1,0.5,param3,{"ease":Sine.easeIn});
         _loc4_.nextTween.paused = true;
      }
      
      private function shelveReward() : void {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:Array = this.lastReward.split(",");
         if(_loc5_.length > 0) {
            _loc1_ = new ItemWithTooltip(_loc5_[0],64);
            _loc3_ = 56;
            _loc2_ = 350;
            _loc1_.x = 5 + _loc2_ * (int(this.rollCount / 5));
            _loc1_.y = 80 + _loc3_ * (this.rollCount % 5);
            _loc4_ = 167.5 + this.itemBitmaps[0].width * 0.5;
            _loc8_ = 133.333333333333 + this.itemBitmaps[0].height * 0.5;
            _loc7_ = _loc1_.x + _loc1_.height * 0.5;
            _loc6_ = 100 + _loc3_ * (this.rollCount % 5) + 23.3333333333333;
            this.particleModalMap.doLightning(_loc4_,_loc8_,_loc7_,_loc6_,115,15787660,0.2);
            addChild(_loc1_);
            this.rewardsArray.push(_loc1_);
         }
      }
      
      private function clearReward() : void {
         var _loc3_:* = null;
         var _loc1_:* = null;
         this.spinners.alpha = 0;
         this.minusNavSprite.alpha = 0;
         this.plusNavSprite.alpha = 0;
         removeChild(this.titleText);
         var _loc2_:* = this.descTexts;
         var _loc8_:int = 0;
         var _loc7_:* = this.descTexts;
         for each(_loc3_ in this.descTexts) {
            removeChild(_loc3_);
         }
         while(this.descTexts.length > 0) {
            this.descTexts.pop();
         }
         removeChild(this.boxButton);
         var _loc6_:* = this.itemBitmaps;
         var _loc10_:int = 0;
         var _loc9_:* = this.itemBitmaps;
         for each(_loc1_ in this.itemBitmaps) {
            removeChild(_loc1_);
         }
         while(this.itemBitmaps.length > 0) {
            this.itemBitmaps.pop();
         }
      }
      
      private function clearShelveReward() : void {
         var _loc3_:* = null;
         var _loc1_:* = this.rewardsArray;
         var _loc5_:int = 0;
         var _loc4_:* = this.rewardsArray;
         for each(_loc3_ in this.rewardsArray) {
            removeChild(_loc3_);
         }
         while(this.rewardsArray.length > 0) {
            this.rewardsArray.pop();
         }
      }
      
      private function centerModal() : void {
         x = Main.STAGE.stageWidth / 2 - 207.5;
         y = Main.STAGE.stageHeight / 2 - 200;
      }
      
      public function onCloseClick(param1:MouseEvent) : void {
         this.close();
      }
      
      private function onTotalRollTimeComplete(param1:TimerEvent) : void {
         this.totalRollTimer.stop();
         this.timerComplete = true;
         if(this.requestComplete) {
            this.showReward();
         }
         this.totalRollTimer.removeEventListener("timer",this.onTotalRollTimeComplete);
      }
      
      private function onNextRollTimerComplete(param1:TimerEvent) : void {
         this.nextRollTimer.stop();
         this.nextRollTimer.removeEventListener("timer",this.onNextRollTimerComplete);
         this.shelveReward();
         this.clearReward();
         this.rollCount++;
         this.prepareNextRoll();
      }
      
      private function swapItemImage(param1:TimerEvent) : void {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:int = 0;
         this.swapImageTimer.stop();
         while(_loc2_ < this.indexInRolls.length) {
            if(this.indexInRolls[_loc2_] < this.mbi._rollsWithContentsUnique.length - 1) {
               _loc3_ = this.indexInRolls;
               _loc4_ = _loc2_;
               _loc5_ = Number(_loc3_[_loc4_]) + 1;
               _loc3_[_loc4_] = _loc5_;
            } else {
               this.indexInRolls[_loc2_] = 0;
            }
            this.itemBitmaps[_loc2_].bitmapData = new Bitmap(ObjectLibrary.getRedrawnTextureFromType(this.mbi._rollsWithContentsUnique[this.indexInRolls[_loc2_]],160,true)).bitmapData;
            _loc2_++;
         }
         this.swapImageTimer.start();
      }
      
      private function onErrorOk(param1:Event) : void {
         var _loc2_:* = null;
         _loc2_ = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
         _loc2_.dispatch(new MysteryBoxSelectModal());
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         open = false;
      }
      
      private function onNavClick(param1:MouseEvent) : void {
         if(param1.currentTarget == this.minusNavSprite) {
            var _loc2_:* = int(this.quantity_) - 5;
            switch(_loc2_) {
               case 0:
                  this.configureRollByQuantity(1);
                  break;
               case 5:
                  this.configureRollByQuantity(5);
            }
         } else if(param1.currentTarget == this.plusNavSprite) {
            _loc2_ = int(this.quantity_) - 1;
            switch(_loc2_) {
               case 0:
                  this.configureRollByQuantity(5);
                  return;
               default:
               case 4:
                  this.configureRollByQuantity(10);
            }
         }
      }
      
      private function onRollClick(param1:MouseEvent) : void {
         this.configureRollByQuantity(this.quantity_);
         this.clearReward();
         this.clearShelveReward();
         this.sendRollRequest();
      }
   }
}
