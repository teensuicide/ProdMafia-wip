package com.company.assembleegameclient.game {
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.objects.Character;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.IInteractiveObject;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Pet;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.Projectile;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.GuildText;
   import com.company.assembleegameclient.ui.RankText;
   import com.company.assembleegameclient.ui.StatusBar;
   import com.company.assembleegameclient.ui.menu.PlayerMenu;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.TileRedrawer;
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.company.util.CachingColorTransformer;
   import com.company.util.Hit;
   import com.company.util.MoreColorUtil;
   import com.company.util.MoreObjectUtil;
   import com.company.util.PointUtil;
import com.hurlant.crypto.Crypto;
import com.hurlant.crypto.symmetric.ICipher;

import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import flash.system.System;
   import flash.utils.ByteArray;
   import io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard.SeasonalLeaderBoardButton;
   import io.decagames.rotmg.seasonalEvent.buttons.SeasonalInfoButton;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.arena.view.ArenaTimer;
   import kabam.rotmg.arena.view.ArenaWaveCounter;
import kabam.rotmg.chat.model.ChatMessage;
import kabam.rotmg.chat.view.Chat;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.MapModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.view.Layers;
   import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
   import kabam.rotmg.dailyLogin.view.DailyLoginModal;
   import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
   import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.dialogs.model.DialogsModel;
   import kabam.rotmg.game.model.QuestModel;
import kabam.rotmg.game.signals.AddTextLineSignal;
import kabam.rotmg.game.view.CreditDisplay;
   import kabam.rotmg.game.view.GiftStatusDisplay;
   import kabam.rotmg.game.view.NewsModalButton;
   import kabam.rotmg.game.view.RealmQuestsDisplay;
   import kabam.rotmg.game.view.ShopDisplay;
   import kabam.rotmg.messaging.impl.GameServerConnectionConcrete;
import kabam.rotmg.messaging.impl.data.SlotObjectData;
import kabam.rotmg.messaging.impl.data.WorldPosData;
import kabam.rotmg.messaging.impl.incoming.MapInfo;
   import kabam.rotmg.news.model.NewsModel;
   import kabam.rotmg.news.view.NewsTicker;
   import kabam.rotmg.packages.services.PackageModel;
   import kabam.rotmg.promotions.model.BeginnersPackageModel;
   import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
   import kabam.rotmg.promotions.view.BeginnersPackageButton;
   import kabam.rotmg.promotions.view.SpecialOfferButton;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.stage3D.Renderer;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.signals.ShowHideKeyUISignal;
   import kabam.rotmg.ui.view.HUDView;
   import org.osflash.signals.Signal;
   
   public class GameSprite extends AGameSprite {

      public static const NON_COMBAT_MAPS:Vector.<String> = new <String>["Nexus","Vault","Guild Hall","Cloth Bazaar","Nexus Explanation","Daily Quest Room"];
      
      public static const DISPLAY_AREA_Y_SPACE:int = 32;
      
      protected static const PAUSED_FILTER:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);
       
      
      protected const EMPTY_FILTER:DropShadowFilter = new DropShadowFilter(0,0,0);
      
      public const monitor:Signal = new Signal(String,int);
      
      public const modelInitialized:Signal = new Signal();
      
      public const drawCharacterWindow:Signal = new Signal(Player);
      
      public const nexusFountains:Point = new Point(129.5,116.5);
      
      public const nexusRealms:Point = new Point(nexusFountains.x,nexusFountains.y - 18);
      
      public const nexusHallway:Point = new Point(nexusFountains.x,nexusFountains.y - 10);
      
      public const vaultFountain:Point = new Point(56,67.1);
      
      public var chatBox_:Chat;
      
      public var isNexus_:Boolean = false;

      public var mousePos_:Point;
      
      public var idleWatcher_:IdleWatcher;
      
      public var rankText_:RankText;
      
      public var guildText_:GuildText;
      
      public var shopDisplay:ShopDisplay;
      
      public var challengerLeaderBoard:SeasonalLeaderBoardButton;
      
      public var challengerInfoButton:SeasonalInfoButton;
      
      public var creditDisplay_:CreditDisplay;
      
      public var realmQuestsDisplay:RealmQuestsDisplay;
      
      public var giftStatusDisplay:GiftStatusDisplay;
      
      public var newsModalButton:NewsModalButton;
      
      public var newsTicker:NewsTicker;
      
      public var arenaTimer:ArenaTimer;
      
      public var arenaWaveCounter:ArenaWaveCounter;
      
      public var mapModel:MapModel;
      
      public var beginnersPackageModel:BeginnersPackageModel;
      
      public var dialogsModel:DialogsModel;
      
      public var showBeginnersPackage:ShowBeginnersPackageSignal;
      
      public var openDailyCalendarPopupSignal:ShowDailyCalendarPopupSignal;
      
      public var openDialog:OpenDialogSignal;
      
      public var showPackage:Signal;
      
      public var packageModel:PackageModel;
      
      public var addToQueueSignal:AddPopupToStartupQueueSignal;
      
      public var flushQueueSignal:FlushPopupStartupQueueSignal;
      
      public var showHideKeyUISignal:ShowHideKeyUISignal;
      
      public var chatPlayerMenu:PlayerMenu;
      
      public var packageOffer:BeginnersPackageButton;
      
      public var questBar:StatusBar;
      
      public var stats:TextFieldDisplayConcrete;
      
      public var statsStringBuilder:StaticStringBuilder;
      
      private var focus:GameObject;
      
      private var frameTimeSum_:int = 0;
      
      private var frameTimeCount_:int = 0;
      
      private var isGameStarted:Boolean;
      
      private var displaysPosY:uint = 4;
      
      private var currentPackage:DisplayObject;
      
      private var packageY:Number;
      
      private var specialOfferButton:SpecialOfferButton;
      
      private var timerCounter:TextFieldDisplayConcrete;
      
      private var timerCounterStringBuilder:StaticStringBuilder;
      
      private var enemyCounter:TextFieldDisplayConcrete;
      
      private var enemyCounterStringBuilder:StaticStringBuilder;
      
      private var lastUpdateInteractiveTime:int = 0;

      private var questModel:QuestModel;
      
      private var seasonalEventModel:SeasonalEventModel;
      
      private var mapName:String;
      
      public function GameSprite(param1:Server, param2:int, param3:Boolean, param4:int, param5:int, param6:ByteArray, param7:PlayerModel, param8:String, param9:Boolean) {
         showPackage = new Signal();
         currentPackage = new Sprite();
         super();
         this.model = param7;
         map = new Map(this);
         addChild(map);
         gsc_ = new GameServerConnectionConcrete(this,param1,param2,param3,param4,param5,param6,param8,param9);
         mui_ = new MapUserInput(this);
         this.chatBox_ = new Chat();
         this.chatBox_.list.addEventListener("mouseDown",this.onChatDown,false,0,true);
         this.chatBox_.list.addEventListener("mouseUp",this.onChatUp,false,0,true);
         addChild(this.chatBox_);
         this.hitQueue.length = 0;
      }
      
      public static function toTimeCode_HOWDIDIBREAKTHIS(param1:Number) : String {
         var _loc4_:int = param1 * 0.001;
         var _loc2_:int = Math.floor(_loc4_ % 60);
         var _loc3_:String = !!(Math.round(Math.floor(_loc4_ * 0.0166666666666667)) + ":" + (_loc2_ < 10))?"0" + _loc2_:String(_loc2_);
         return _loc3_;
      }
      
      public static function toTimeCode(param1:Number) : String {
         var _loc2_:int = Math.floor(param1 * 0.001 % 60);
         var _loc4_:String = _loc2_ < 10?"0" + _loc2_:String(_loc2_);
         var _loc6_:int = Math.round(Math.floor(param1 * 0.001 * 0.0166666666666667));
         var _loc5_:String = String(_loc6_);
         var _loc3_:String = _loc5_ + ":" + _loc4_;
         return _loc3_;
      }
      
      override public function setFocus(param1:GameObject) : void {
         param1 = param1 || map.player_;
         this.focus = param1;
      }
      
      override public function applyMapInfo(param1:MapInfo) : void {
         map.setProps(param1.width_,param1.height_,param1.name_,param1.background_,param1.allowPlayerTeleport_,param1.showDisplays_,param1.maxPlayers_);
         Parameters.savingMap_ = false;
      }
      
      override public function initialize() : void {
         this.questModel = StaticInjectorContext.getInjector().getInstance(QuestModel);
         this.seasonalEventModel = StaticInjectorContext.getInjector().getInstance(SeasonalEventModel);
         this.map.initialize();
         this.modelInitialized.dispatch();
         var _loc4_:String = this.map.name_;
         this.mapName = _loc4_;
         this.showHideKeyUISignal.dispatch(_loc4_ == "Davy Jones\' Locker");
         this.isNexus_ = _loc4_ == "Nexus";
         this.map.isTrench = this.map.name_ == "Ocean Trench";
         this.map.isRealm = _loc4_ == "Realm of the Mad God";
         this.map.isVault = _loc4_ == "Vault";
         var _loc5_:Vector.<String> = new <String>["Nexus","Vault","Guild Hall","Guild Hall 2","Guild Hall 3","Guild Hall 4","Guild Hall 5","Cloth Bazaar","Nexus Explanation","Daily Quest Room","Daily Login Room","Pet Yard","Pet Yard 2","Pet Yard 3","Pet Yard 4","Pet Yard 5"];
         this.isSafeMap = _loc5_.indexOf(_loc4_) != -1;
         if(this.isSafeMap) {
            this.showSafeAreaDisplays();
         } else {
            this.addQuestBar();
         }
         if(_loc4_ == "Arena") {
            this.showTimer();
            this.showWaveCounter();
         }
         var _loc2_:Account = StaticInjectorContext.getInjector().getInstance(Account);
         this.creditDisplay_ = new CreditDisplay(this,true);
         this.creditDisplay_.x = 594;
         this.creditDisplay_.y = 0;
         if(!this.isSafeMap) {
            this.creditDisplay_.mouseEnabled = false;
            this.creditDisplay_.mouseChildren = false;
         }
         addChild(this.creditDisplay_);
         if(!isSafeMap && this.canShowRealmQuestDisplay(this.mapName)) {
            this.realmQuestsDisplay = new RealmQuestsDisplay(map);
            this.realmQuestsDisplay.x = 10;
            this.realmQuestsDisplay.y = 10;
            addChild(this.realmQuestsDisplay);
            gsc_.playerText("/server");
         } else {
            this.questModel.previousRealm = "";
         }
         if(_loc4_ == "Daily Quest Room") {
            this.gsc_.questFetch();
         } else if(_loc4_ == "Cloth Bazaar") {
            Parameters.timerActive = true;
            Parameters.phaseName = "Portal Entry";
            Parameters.phaseChangeAt = TimeUtil.getTrueTime() + 30000;
         }
         map.setHitAreaProps(map.width,map.height);
         Parameters.save();
         this.parent.parent.setChildIndex((this.parent.parent as Layers).top,2);
         stage.dispatchEvent(new Event("resize"));
         if(Parameters.data.perfStats) {
            if(Parameters.data.liteMonitor) {
               addStats();
               statsStart = TimeUtil.getTrueTime();
               stage.dispatchEvent(new Event("resize"));
            } else {
               this.addChild(MapUserInput.stats_);
               this.gsc_.enableJitterWatcher();
               this.gsc_.jitterWatcher_.y = MapUserInput.stats_.height;
               this.addChild(this.gsc_.jitterWatcher_);
            }
         }
      }
      
      override public function fixFullScreen() : void {
         stage.scaleMode = "noScale";
      }
      
      override public function evalIsNotInCombatMapArea() : Boolean {
         return NON_COMBAT_MAPS.indexOf(map.name_) != -1;
      }
      
      override public function showDailyLoginCalendar() : void {
         this.openDialog.dispatch(new DailyLoginModal());
      }
      
      public function addChatPlayerMenu(param1:Player, param2:Number, param3:Number, param4:String = null, param5:Boolean = false, param6:Boolean = false) : void {
         this.removeChatPlayerMenu();
         this.chatPlayerMenu = new PlayerMenu();
         if(param4 == null) {
            this.chatPlayerMenu.init(this,param1);
         } else if(param6) {
            this.chatPlayerMenu.initDifferentServer(this,param4,param5,param6);
         } else {
            if(param4.length > 0 && (param4.charAt(0) == "#" || param4.charAt(0) == "*" || param4.charAt(0) == "@")) {
               return;
            }
            this.chatPlayerMenu.initDifferentServer(this,param4,param5);
         }
         addChild(this.chatPlayerMenu);
         chatMenuPositionFixed();
      }
      
      public function removeChatPlayerMenu() : void {
         if(this.chatPlayerMenu && this.chatPlayerMenu.parent) {
            removeChild(this.chatPlayerMenu);
            this.chatPlayerMenu = null;
         }
      }
      
      public function hudModelInitialized() : void {
         if(hudView) {
            hudView.dispose();
         }
         hudView = new HUDView();
         hudView.x = 600;
         addChild(hudView);
         if(!Parameters.data.mapHack) {
            return;
         }
         if(Parameters.needsMapCheck == 2) {
            this.hudView.miniMap.setFullMap(this.map.name_);
         }
      }
      
      public function addStats() : void {
         if(this.stats == null) {
            this.stats = new TextFieldDisplayConcrete().setSize(14).setColor(16777215);
            this.stats.mouseChildren = false;
            this.stats.mouseEnabled = false;
            this.statsStringBuilder = new StaticStringBuilder("FPS -1\nLAT -1\nMEM -1");
            this.stats.setStringBuilder(this.statsStringBuilder);
            this.stats.filters = [EMPTY_FILTER];
            this.stats.setBold(true);
            this.stats.x = 5;
            this.stats.y = 5;
            addChild(this.stats);
            stage.dispatchEvent(new Event("resize"));
         }
      }

      public function updateStats(param1:int) : void {
         statsFrameNumber = Number(statsFrameNumber) + 1;
         var _loc2_:int = param1 - statsStart;
         if(_loc2_ >= 1000) {
            statsFPS = Math.floor(statsFrameNumber / (0.001 * _loc2_) * 10) * 0.1;
            statsStart = param1;
            statsFrameNumber = 0;
            this.stats.setText("FPS " + statsFPS + "\nLAT " + -1 + "\nMEM " + Math.round(1.0e-6 * System.totalMemoryNumber));
         }
      }
      
      public function updateEnemyCounter(param1:String) : void {
         if(!this.enemyCounter) {
            this.addEnemyCounter();
         }
         this.enemyCounter.visible = true;
         this.enemyCounter.setText(param1);
      }
      
      public function chatMenuPositionFixed() : void {
         var _loc1_:Number = (stage.mouseX + (stage.stageWidth >> 1) - 400) / stage.stageWidth * 800;
         var _loc2_:Number = (stage.mouseY + (stage.stageHeight >> 1) - 300) / stage.stageHeight * 600;
         this.chatPlayerMenu.x = _loc1_;
         this.chatPlayerMenu.y = _loc2_ - this.chatPlayerMenu.height;
      }
      
      public function positionDynamicDisplays() : void {
         var _loc2_:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
         var _loc1_:int = 72;
         if(this.giftStatusDisplay && this.giftStatusDisplay.isOpen) {
            this.giftStatusDisplay.y = _loc1_;
            _loc1_ = _loc1_ + 32;
         }
         if(this.newsModalButton && (NewsModalButton.showsHasUpdate || _loc2_.hasValidModalNews())) {
            this.newsModalButton.y = _loc1_;
            _loc1_ = _loc1_ + 32;
         }
         if(this.specialOfferButton && this.specialOfferButton.isSpecialOfferAvailable) {
            this.specialOfferButton.y = _loc1_;
         }
         if(this.newsTicker && this.newsTicker.visible) {
            this.newsTicker.y = _loc1_;
            _loc1_ = _loc1_ + 32;
         }
         this.onScreenResize(null);
      }
      
      public function refreshNewsUpdateButton() : void {
         this.showNewsUpdate(false);
      }
      
      public function showSpecialOfferIfSafe(param1:Boolean) : void {
         if(this.evalIsNotInCombatMapArea()) {
            this.specialOfferButton = new SpecialOfferButton(param1);
            this.specialOfferButton.x = 6;
            addChild(this.specialOfferButton);
            this.positionDynamicDisplays();
         }
      }
      
      public function connect() : void {
         if(!this.isGameStarted) {
            this.isGameStarted = true;
            Renderer.inGame = true;
            this.newsModalButton = null;
            this.questBar = null;
            gsc_.connect();
            lastUpdate_ = TimeUtil.getModdedTime();
            statsStart = -1;
            statsFrameNumber = -1;
            stage.addEventListener("MONEY_CHANGED",this.onMoneyChanged,false,0,true);
            stage.addEventListener("enterFrame",this.onEnterFrame,false,0,true);
            stage.addEventListener("activate",this.onFocusIn,false,0,true);
            stage.addEventListener("deactivate",this.onFocusOut,false,0,true);
            this.parent.parent.setChildIndex((this.parent.parent as Layers).top,0);
            stage.scaleMode = "noScale";
            stage.addEventListener("resize",this.onScreenResize,false,0,true);
            stage.dispatchEvent(new Event("resize"));
            Main.STAGE.vsyncEnabled = Parameters.data.vSync;
         }
      }
      
      public function disconnect() : void {
         if(this.isGameStarted) {
            this.isGameStarted = false;
            Parameters.data.noClip = false;
            Parameters.data.fakeLag = 0;
            Renderer.inGame = false;
            stage.removeEventListener("MONEY_CHANGED",this.onMoneyChanged);
            stage.removeEventListener("enterFrame",this.onEnterFrame);
            stage.removeEventListener("activate",this.onFocusIn);
            stage.removeEventListener("deactivate",this.onFocusOut);
            stage.removeEventListener("resize",this.onScreenResize);
            stage.scaleMode = "exactFit";
            stage.dispatchEvent(new Event("resize"));
            contains(map) && removeChild(map);
            if(hudView) {
               hudView.dispose();
            }
            map.dispose();
            CachingColorTransformer.clear();
            TextureRedrawer.clearCache();
            TileRedrawer.clearCache();
            GlowRedrawer.clearCache();
            Projectile.dispose();
            this.newsModalButton = null;
            this.questBar = null;
            if(this.timerCounter && !(Parameters.phaseName == "Realm Closed" || Parameters.phaseName == "Oryx Shake")) {
               Parameters.timerActive = false;
               this.timerCounter.visible = false;
               this.timerCounter = null;
            }
            if(this.enemyCounter) {
               this.enemyCounter.visible = false;
               this.enemyCounterStringBuilder = null;
               this.enemyCounter = null;
            }
            Parameters.followPlayer = null;
            Parameters.player = null;
            gsc_.disconnect();
            System.pauseForGCIfCollectionImminent(0);
         }
      }
      
      private function addQuestBar() : void {
         this.questBar = new StatusBar(600,15,4294967295,4284226845,"Quest!",true);
         this.questBar.x = 0;
         this.questBar.y = 0;
         this.questBar.visible = false;
         addChild(this.questBar);
      }
      
      private function updateQuestBar() : void {
         var _loc1_:GameObject = this.map.quest_.getObject(0);
         if(_loc1_ == null) {
            this.questBar.visible = false;
            return;
         }
         this.questBar.visible = true;
         if(this.questBar.quest == null || _loc1_.objectId_ != this.questBar.quest.objectId_) {
            this.questBar.quest = _loc1_;
         }
         var _loc2_:String = Parameters.dmgCounter[_loc1_.objectId_] > 0?"(" + (Parameters.dmgCounter[_loc1_.objectId_] / _loc1_.maxHP_ * 100).toFixed(2) + "%) ":"";
         this.questBar.setLabelText(_loc2_ + ObjectLibrary.typeToDisplayId_[_loc1_.objectType_]);
         this.questBar.color_ = Character.green2red(this.questBar.quest.hp_ * 100 / this.questBar.quest.maxHP_);
         this.questBar.draw(_loc1_.hp_,_loc1_.maxHP_,0);
      }
      
      private function addTimer() : void {
         if(this.timerCounter == null) {
            this.timerCounter = new TextFieldDisplayConcrete().setSize(Parameters.data.uiTextSize).setColor(16777215);
            this.timerCounter.mouseChildren = false;
            this.timerCounter.mouseEnabled = false;
            this.timerCounter.setBold(true);
            this.timerCounterStringBuilder = new StaticStringBuilder("0:00");
            this.timerCounter.setStringBuilder(this.timerCounterStringBuilder);
            this.timerCounter.filters = [EMPTY_FILTER];
            this.timerCounter.x = 3;
            this.timerCounter.y = 180;
            addChild(this.timerCounter);
            stage.dispatchEvent(new Event("resize"));
         }
      }
      
      private function addEnemyCounter() : void {
         if(this.enemyCounter == null) {
            this.enemyCounter = new TextFieldDisplayConcrete().setSize(Parameters.data.uiTextSize).setColor(16777215);
            this.enemyCounter.mouseChildren = false;
            this.enemyCounter.mouseEnabled = false;
            this.enemyCounter.setBold(true);
            this.enemyCounterStringBuilder = new StaticStringBuilder("0");
            this.enemyCounter.setStringBuilder(this.enemyCounterStringBuilder);
            this.enemyCounter.filters = [EMPTY_FILTER];
            this.enemyCounter.x = 3;
            this.enemyCounter.y = 160;
            addChild(this.enemyCounter);
            stage.dispatchEvent(new Event("resize"));
         }
      }
      
      private function updateTimer(param1:int) : void {
         this.timerCounter.setText(Parameters.phaseName + "\n" + toTimeCode(Parameters.phaseChangeAt - param1));
         if(!this.timerCounter.visible) {
            this.timerCounter.visible = true;
            stage.dispatchEvent(new Event("resize"));
         }
      }
      
      private function fadeRed(param1:Number) : uint {
         if(param1 > 100) {
            param1 = 100;
         }
         var _loc2_:int = 255 * param1;
         var _loc3_:* = _loc2_ << 8;
         var _loc4_:* = _loc2_;
         return 16711680 | _loc3_ | _loc4_;
      }
      
      private function canShowRealmQuestDisplay(param1:String) : Boolean {
         var _loc2_:Boolean = false;
         if(param1 == "Realm of the Mad God") {
            this.questModel.previousRealm = param1;
            this.questModel.requirementsStates[1] = false;
            this.questModel.remainingHeroes = -1;
            if(this.questModel.hasOryxBeenKilled) {
               this.questModel.hasOryxBeenKilled = false;
               this.questModel.resetRequirementsStates();
            }
            _loc2_ = true;
         } else if(this.questModel.previousRealm == "Realm of the Mad God" && param1.indexOf("Oryx") != -1) {
            this.questModel.requirementsStates[1] = true;
            this.questModel.remainingHeroes = 0;
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      private function showSafeAreaDisplays() : void {
         this.showRankText();
         this.showGuildText();
         this.showShopDisplay();
         this.setYAndPositionPackage();
         this.showGiftStatusDisplay();
         this.showNewsUpdate();
         this.showNewsTicker();
      }
      
      private function setDisplayPosY(param1:Number) : void {
         var _loc2_:Number = 28 * param1;
         if(param1 != 0) {
            this.displaysPosY = 4 + _loc2_;
         } else {
            this.displaysPosY = 2;
         }
      }
      
      private function showTimer() : void {
         this.arenaTimer = new ArenaTimer();
         this.arenaTimer.y = 5;
         addChild(this.arenaTimer);
      }
      
      private function showWaveCounter() : void {
         this.arenaWaveCounter = new ArenaWaveCounter();
         this.arenaWaveCounter.y = 5;
         this.arenaWaveCounter.x = 5;
         addChild(this.arenaWaveCounter);
      }
      
      private function showNewsTicker() : void {
         this.newsTicker = new NewsTicker();
         this.newsTicker.x = 300 - this.newsTicker.width / 2;
         addChild(this.newsTicker);
         this.positionDynamicDisplays();
      }
      
      private function showGiftStatusDisplay() : void {
         this.giftStatusDisplay = new GiftStatusDisplay();
         this.giftStatusDisplay.x = 6;
         addChild(this.giftStatusDisplay);
         this.positionDynamicDisplays();
      }
      
      private function showShopDisplay() : void {
         this.shopDisplay = new ShopDisplay(map.name_ == "Nexus");
         this.shopDisplay.x = 6;
         this.shopDisplay.y = 40;
         addChild(this.shopDisplay);
      }
      
      private function showNewsUpdate(param1:Boolean = true) : void {
         var _loc2_:* = null;
         var _loc3_:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
         if(_loc3_.hasValidModalNews()) {
            _loc2_ = new NewsModalButton();
            if(this.newsModalButton) {
               return;
            }
            this.newsModalButton = _loc2_;
            addChild(this.newsModalButton);
            stage.dispatchEvent(new Event("resize"));
         }
      }
      
      private function setYAndPositionPackage() : void {
         this.packageY = this.displaysPosY + 2;
         this.displaysPosY = this.displaysPosY + 28;
         this.positionPackage();
      }
      
      private function addAndPositionPackage(param1:DisplayObject) : void {
         this.currentPackage = param1;
         addChild(this.currentPackage);
         this.positionPackage();
      }
      
      private function positionPackage() : void {
         this.currentPackage.x = 80;
         this.setDisplayPosY(1);
         this.currentPackage.y = this.displaysPosY;
      }
      
      private function showGuildText() : void {
         this.guildText_ = new GuildText("",-1);
         this.guildText_.x = 76;
         this.setDisplayPosY(0);
         this.guildText_.y = this.displaysPosY;
         addChild(this.guildText_);
      }
      
      private function showRankText() : void {
         this.rankText_ = new RankText(-1,true,false);
         this.rankText_.x = 8;
         this.rankText_.y = 8;
         this.setDisplayPosY(0);
         addChild(this.rankText_);
      }
      
      private function updateNearestInteractive() : void {
         var _loc8_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc1_:* = null;
         var _loc7_:* = null;
         var _loc10_:* = null;
         if(!map || !map.player_) {
            return;
         }
         var _loc4_:Player = map.player_;
         var _loc11_:* = 1;
         var _loc9_:Number = _loc4_.x_;
         var _loc2_:Number = _loc4_.y_;
         var _loc6_:* = map.goDict_;
         var _loc14_:int = 0;
         var _loc13_:* = map.goDict_;
         for each(_loc7_ in map.goDict_) {
            _loc10_ = _loc7_;
            if(_loc10_ is IInteractiveObject && (!(_loc10_ is Pet) || this.map.isPetYard)) {
               _loc8_ = _loc7_.x_;
               _loc3_ = _loc7_.y_;
               if(Math.abs(_loc9_ - _loc8_) < 1 || Math.abs(_loc2_ - _loc3_) < 1) {
                  _loc12_ = PointUtil.distanceSquaredXY(_loc8_,_loc3_,_loc9_,_loc2_);
                  if(_loc12_ < 1 && _loc12_ < _loc11_) {
                     _loc11_ = _loc12_;
                     _loc1_ = _loc10_;
                  }
               }
            }
         }
         this.mapModel.currentInteractiveTarget = _loc1_ as IInteractiveObject;
         if(_loc1_ == null) {
            this.mapModel.currentInteractiveTargetObjectId = -1;
         } else {
            this.mapModel.currentInteractiveTargetObjectId = _loc1_.objectId_;
         }
      }
      
      public function onChatDown(param1:MouseEvent) : void {
         if(this.chatPlayerMenu != null) {
            this.removeChatPlayerMenu();
         }
         mui_.onMouseDown(param1);
      }
      
      public function onChatUp(param1:MouseEvent) : void {
         mui_.onMouseUp(param1);
      }
      
      public function onScreenResize(param1:Event) : void {
         var _loc6_:Number = NaN;
         var _loc2_:Boolean = Parameters.data.uiscale;
         var _loc4_:Number = 800 / stage.stageWidth;
         var _loc3_:Number = 600 / stage.stageHeight;
         var _loc5_:Number = _loc4_ / _loc3_;
         if(this.map) {
            this.map.scaleX = _loc4_ * Parameters.data.mscale;
            this.map.scaleY = _loc3_ * Parameters.data.mscale;
         }
         if(this.timerCounter) {
            if(_loc2_) {
               this.timerCounter.scaleX = _loc5_;
               this.timerCounter.scaleY = 1;
               this.timerCounter.y = 180;
            } else {
               this.timerCounter.scaleX = _loc4_;
               this.timerCounter.scaleY = _loc3_;
            }
         }
         if(this.enemyCounter) {
            if(_loc2_) {
               this.enemyCounter.scaleX = _loc5_;
               this.enemyCounter.scaleY = 1;
               this.enemyCounter.y = 160;
            } else {
               this.enemyCounter.scaleX = _loc4_;
               this.enemyCounter.scaleY = _loc3_;
            }
         }
         if(this.stats) {
            if(_loc2_) {
               this.stats.scaleX = _loc5_;
               this.stats.scaleY = 1;
               this.stats.y = 5;
            } else {
               this.stats.scaleX = _loc4_;
               this.stats.scaleY = _loc3_;
            }
            this.stats.x = 5 * this.stats.scaleX;
            this.stats.y = 5 * this.stats.scaleY;
         }
         if(this.questBar) {
            if(_loc2_) {
               this.questBar.scaleX = _loc5_;
               this.questBar.scaleY = 1;
            } else {
               this.questBar.scaleX = _loc4_;
               this.questBar.scaleY = _loc3_;
            }
         }
         if(this.hudView) {
            if(_loc2_) {
               this.hudView.scaleX = _loc5_;
               this.hudView.scaleY = 1;
               this.hudView.y = 0;
            } else {
               this.hudView.scaleX = _loc4_;
               this.hudView.scaleY = _loc3_;
               this.hudView.y = 300 * (1 - _loc3_);
            }
            this.hudView.x = 800 - 200 * this.hudView.scaleX;
            if(this.creditDisplay_) {
               this.creditDisplay_.x = this.hudView.x - 6 * this.creditDisplay_.scaleX;
            }
         }
         if(this.chatBox_) {
            if(_loc2_) {
               this.chatBox_.scaleX = _loc5_;
               this.chatBox_.scaleY = 1;
            } else {
               this.chatBox_.scaleX = _loc4_;
               this.chatBox_.scaleY = _loc3_;
            }
            this.chatBox_.y = 300 + 300 * (1 - this.chatBox_.scaleY);
         }
         if(this.rankText_) {
            if(_loc2_) {
               this.rankText_.scaleX = _loc5_;
               this.rankText_.scaleY = 1;
            } else {
               this.rankText_.scaleX = _loc4_;
               this.rankText_.scaleY = _loc3_;
            }
            this.rankText_.x = 8 * this.rankText_.scaleX;
            this.rankText_.y = 2 * this.rankText_.scaleY;
         }
         if(this.guildText_) {
            if(_loc2_) {
               this.guildText_.scaleX = _loc5_;
               this.guildText_.scaleY = 1;
            } else {
               this.guildText_.scaleX = _loc4_;
               this.guildText_.scaleY = _loc3_;
            }
            this.guildText_.x = 86 * this.guildText_.scaleX;
            this.guildText_.y = 2 * this.guildText_.scaleY;
         }
         if(this.creditDisplay_) {
            if(_loc2_) {
               this.creditDisplay_.scaleX = _loc5_;
               this.creditDisplay_.scaleY = 1;
            } else {
               this.creditDisplay_.scaleX = _loc4_;
               this.creditDisplay_.scaleY = _loc3_;
            }
         }
         if(this.shopDisplay) {
            if(_loc2_) {
               this.shopDisplay.scaleX = _loc5_;
               this.shopDisplay.scaleY = 1;
            } else {
               this.shopDisplay.scaleX = _loc4_;
               this.shopDisplay.scaleY = _loc3_;
            }
            this.shopDisplay.x = 6 * this.shopDisplay.scaleX;
            this.shopDisplay.y = 40 * this.shopDisplay.scaleY;
         }
         if(this.packageOffer) {
            if(_loc2_) {
               this.packageOffer.scaleX = _loc5_;
               this.packageOffer.scaleY = 1;
            } else {
               this.packageOffer.scaleX = _loc4_;
               this.packageOffer.scaleY = _loc3_;
            }
            this.packageOffer.x = 6 * this.packageOffer.scaleX;
            this.packageOffer.y = 31 * this.packageOffer.scaleY;
         }
         var _loc7_:int = 72;
         if(this.giftStatusDisplay) {
            if(_loc2_) {
               this.giftStatusDisplay.scaleX = _loc5_;
               this.giftStatusDisplay.scaleY = 1;
            } else {
               this.giftStatusDisplay.scaleX = _loc4_;
               this.giftStatusDisplay.scaleY = _loc3_;
            }
            this.giftStatusDisplay.x = 6 * this.giftStatusDisplay.scaleX;
            this.giftStatusDisplay.y = _loc7_ * this.giftStatusDisplay.scaleY;
            _loc7_ = _loc7_ + 32;
         }
         if(this.newsModalButton) {
            if(_loc2_) {
               this.newsModalButton.scaleX = _loc5_;
               this.newsModalButton.scaleY = 1;
            } else {
               this.newsModalButton.scaleX = _loc4_;
               this.newsModalButton.scaleY = _loc3_;
            }
            this.newsModalButton.x = 6 * this.newsModalButton.scaleX;
            this.newsModalButton.y = _loc7_ * this.newsModalButton.scaleY;
            _loc7_ = _loc7_ + 32;
         }
         if(this.specialOfferButton) {
            if(_loc2_) {
               this.specialOfferButton.scaleX = _loc5_;
               this.specialOfferButton.scaleY = 1;
            } else {
               this.specialOfferButton.scaleX = _loc4_;
               this.specialOfferButton.scaleY = _loc3_;
            }
            this.specialOfferButton.x = 6 * this.specialOfferButton.scaleX;
            this.specialOfferButton.y = _loc7_ * this.specialOfferButton.scaleY;
            _loc7_ = _loc7_ + 32;
         }
         if(this.challengerLeaderBoard) {
            if(_loc2_) {
               this.challengerLeaderBoard.scaleX = _loc5_;
               this.challengerLeaderBoard.scaleY = 1;
            } else {
               this.challengerLeaderBoard.scaleX = _loc4_;
               this.challengerLeaderBoard.scaleY = _loc3_;
            }
            if(this.challengerLeaderBoard) {
               this.challengerLeaderBoard.x = this.hudView.x - this.challengerLeaderBoard.width - 6;
               this.challengerLeaderBoard.y = 40;
            }
         }
         if(this.challengerInfoButton) {
            if(_loc2_) {
               this.challengerInfoButton.scaleX = _loc5_;
               this.challengerInfoButton.scaleY = 1;
            } else {
               this.challengerInfoButton.scaleX = _loc4_;
               this.challengerInfoButton.scaleY = _loc3_;
            }
            if(this.challengerInfoButton) {
               this.challengerInfoButton.x = this.hudView.x - this.challengerInfoButton.width - 6;
               this.challengerInfoButton.y = 80;
            }
         }
      }
      
      private function onTimerCounterClick(param1:MouseEvent) : void {
         this.gsc_.playerText(Parameters.phaseName + " time left: " + toTimeCode(Parameters.phaseChangeAt - TimeUtil.getTrueTime()));
      }
      
      private function onFocusOut(param1:Event) : void {
         if(Parameters.data.FocusFPS) {
            stage.frameRate = Parameters.data.bgFPS;
         }
      }
      
      private function onFocusIn(param1:Event) : void {
         if(Parameters.data.FocusFPS) {
            stage.frameRate = Parameters.data.fgFPS;
         }
      }
      
      private function onMoneyChanged(param1:Event) : void {
         gsc_.checkCredits();
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = TimeUtil.getModdedTime();
         var _loc4_:int = TimeUtil.getTrueTime();
         var _loc2_:int = _loc5_ - lastUpdate_;
         var _loc7_:Player = map.player_;
         if(_loc7_) {
            _loc7_.checkHealth();
         }
         if(mui_.held) {
            _loc6_ = Main.STAGE.mouseX - mui_.heldX;
            Parameters.data.cameraAngle = mui_.heldAngle + _loc6_ * 0.0174532925199433;
            if(Parameters.data.tiltCam) {
               _loc3_ = Main.STAGE.mouseY - mui_.heldY;
               mui_.heldY = Main.STAGE.mouseY;
               this.camera_.nonPPMatrix_.appendRotation(_loc3_,Vector3D.X_AXIS,null);
            }
         }
         if(_loc5_ - this.lastUpdateInteractiveTime > 100) {
            this.lastUpdateInteractiveTime = _loc5_;
            this.updateNearestInteractive();
         }
         this.map.update(_loc5_,_loc2_);
         var _loc10_:int = 0;
         var _loc9_:* = this.hitQueue;
         for each(var _loc8_ in this.hitQueue) {
            this.gsc_.playerHit(_loc8_.bulletId,_loc8_.objectId);
            _loc8_ = null;
         }
         this.hitQueue.length = 0;
         this.camera_.update(int(_loc2_ / Parameters.data.timeScale));
         if(Parameters.data.showQuestBar && this.questBar) {
            updateQuestBar();
         } else if(this.questBar) {
            this.questBar.visible = false;
         }
         if(Parameters.timerActive && Parameters.data.showTimers) {
            if(this.timerCounter == null) {
               this.addTimer();
            }
            if(_loc4_ >= Parameters.phaseChangeAt) {
               Parameters.phaseChangeAt = 2147483647;
               Parameters.timerActive = false;
               this.timerCounter.visible = false;
            } else {
               updateTimer(_loc4_);
            }
         }
         if(Parameters.data.liteMonitor) {
            if(this.stats) {
               this.updateStats(_loc4_);
            }
         }
         if(this.enemyCounter && Parameters.data.showEnemyCounter) {
            this.enemyCounter.visible = true;
         }
         if(this.focus && this.camera_ && _loc7_) {
            camera_.configureCamera(this.focus,_loc7_.isHallucinating);
            map.draw(camera_,_loc4_);
         }
         if(_loc7_) {
            if(this.mapName == "Realm of the Mad God" && this.gsc_.server_.address != "127.0.0.1" && this.gsc_.server_.address != "localhost") {
               Parameters.data.lastRealmIP = this.gsc_.server_.address;
               Parameters.save();
            }
            if(Parameters.followPlayer) {
               _loc7_.followPos.x = Parameters.followPlayer.x_;
               _loc7_.followPos.y = Parameters.followPlayer.y_;
            }
            this.drawCharacterWindow.dispatch(_loc7_);
            if(Parameters.data.showFameGoldRealms) {
               this.creditDisplay_.visible = true;
               if(this.isSafeMap) {
                  this.rankText_.draw(_loc7_.numStars_,_loc7_.starsBg_);
                  this.guildText_.draw(_loc7_.guildName_,_loc7_.guildRank_);
                  this.creditDisplay_.draw(_loc7_.credits_,_loc7_.fame_,_loc7_.forgefire);
               } else {
                  this.creditDisplay_.draw(_loc7_.credits_,_loc7_.fame_,_loc7_.forgefire);
               }
            } else if(this.isSafeMap) {
               this.rankText_.draw(_loc7_.numStars_,_loc7_.starsBg_);
               this.guildText_.draw(_loc7_.guildName_,_loc7_.guildRank_);
               this.creditDisplay_.draw(_loc7_.credits_,_loc7_.fame_,_loc7_.forgefire);
            } else {
               this.creditDisplay_.visible = false;
            }
            if(_loc7_.isPaused) {
               map.mouseEnabled = false;
               map.mouseChildren = false;
               hudView.filters = [PAUSED_FILTER];
               hudView.mouseEnabled = false;
               hudView.mouseChildren = false;
            } else if(map.filters.length > 0 || hudView.filters.length > 0) {
               map.filters = [];
               map.mouseEnabled = true;
               map.mouseChildren = true;
               hudView.filters = [];
               hudView.mouseEnabled = true;
               hudView.mouseChildren = true;
            }
            if(!Parameters.data.noClip) {
               moveRecords_.addRecord(_loc5_, _loc7_.x_, _loc7_.y_);
            }

            if(Parameters.data.tpCursor) {
               moveRecords_.addRecord(_loc5_, this.map.mouseX, this.map.mouseY);
            }
         }
         lastUpdate_ = _loc5_;
      }
   }
}
