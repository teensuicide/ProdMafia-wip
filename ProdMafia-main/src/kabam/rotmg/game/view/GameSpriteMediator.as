package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.game.events.DisplayAreaChangedSignal;
   import com.company.assembleegameclient.game.events.ReconnectEvent;
   import com.company.assembleegameclient.objects.Player;
   import flash.system.System;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.shop.packages.startupPackage.StartupPackage;
   import io.decagames.rotmg.ui.popups.signals.CloseAllPopupsSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.model.MapModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.InvalidateDataSignal;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   import kabam.rotmg.core.signals.TrackPageViewSignal;
   import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
   import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.dialogs.model.DialogsModel;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.game.signals.GameClosedSignal;
   import kabam.rotmg.game.signals.PlayGameSignal;
   import kabam.rotmg.game.signals.SetWorldInteractionSignal;
   import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
   import kabam.rotmg.packages.control.BeginnersPackageAvailableSignal;
   import kabam.rotmg.packages.control.InitPackagesSignal;
   import kabam.rotmg.packages.control.OpenPackageSignal;
   import kabam.rotmg.packages.model.PackageInfo;
   import kabam.rotmg.packages.services.PackageModel;
   import kabam.rotmg.promotions.model.BeginnersPackageModel;
   import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
   import kabam.rotmg.ui.signals.HUDModelInitialized;
   import kabam.rotmg.ui.signals.HUDSetupStarted;
   import kabam.rotmg.ui.signals.ShowHideKeyUISignal;
   import kabam.rotmg.ui.signals.UpdateHUDSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class GameSpriteMediator extends Mediator {
       
      
      [Inject]
      public var view:GameSprite;
      
      [Inject]
      public var setWorldInteraction:SetWorldInteractionSignal;
      
      [Inject]
      public var invalidate:InvalidateDataSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var playGame:PlayGameSignal;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var gameClosed:GameClosedSignal;
      
      [Inject]
      public var mapModel:MapModel;
      
      [Inject]
      public var beginnersPackageModel:BeginnersPackageModel;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      [Inject]
      public var hudSetupStarted:HUDSetupStarted;
      
      [Inject]
      public var updateHUDSignal:UpdateHUDSignal;
      
      [Inject]
      public var hudModelInitialized:HUDModelInitialized;
      
      [Inject]
      public var tracking:TrackPageViewSignal;
      
      [Inject]
      public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
      
      [Inject]
      public var initPackages:InitPackagesSignal;
      
      [Inject]
      public var showBeginnersPackage:ShowBeginnersPackageSignal;
      
      [Inject]
      public var packageModel:PackageModel;
      
      [Inject]
      public var openPackageSignal:OpenPackageSignal;
      
      [Inject]
      public var newsButtonRefreshSignal:NewsButtonRefreshSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var dialogsModel:DialogsModel;
      
      [Inject]
      public var showDailyCalendarSignal:ShowDailyCalendarPopupSignal;
      
      [Inject]
      public var addToQueueSignal:AddPopupToStartupQueueSignal;
      
      [Inject]
      public var flushQueueSignal:FlushPopupStartupQueueSignal;
      
      [Inject]
      public var showHideKeyUISignal:ShowHideKeyUISignal;
      
      [Inject]
      public var closeAllPopups:CloseAllPopupsSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var displayAreaChangedSignal:DisplayAreaChangedSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      public function GameSpriteMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.displayAreaChangedSignal.add(this.onDisplayAreaChanged);
         this.view.packageModel = this.packageModel;
         this.setWorldInteraction.add(this.onSetWorldInteraction);
         addViewListener("RECONNECT_EVENT",this.onReconnect);
         this.view.modelInitialized.add(this.onGameSpriteModelInitialized);
         this.view.drawCharacterWindow.add(this.onStatusPanelDraw);
         this.hudModelInitialized.add(this.onHUDModelInitialized);
         this.view.closed.add(this.onClosed);
         this.view.mapModel = this.mapModel;
         this.view.dialogsModel = this.dialogsModel;
         this.view.beginnersPackageModel = this.beginnersPackageModel;
         this.view.openDialog = this.openDialog;
         this.view.addToQueueSignal = this.addToQueueSignal;
         this.view.flushQueueSignal = this.flushQueueSignal;
         this.view.showHideKeyUISignal = this.showHideKeyUISignal;
         this.view.connect();
         this.tracking.dispatch("/gameStarted");
         this.view.showBeginnersPackage = this.showBeginnersPackage;
         this.view.openDailyCalendarPopupSignal = this.showDailyCalendarSignal;
         this.view.showPackage.add(this.onShowPackage);
         this.newsButtonRefreshSignal.add(this.onNewsButtonRefreshSignal);
      }
      
      override public function destroy() : void {
         this.displayAreaChangedSignal.remove(this.onDisplayAreaChanged);
         this.view.showPackage.remove(this.onShowPackage);
         this.setWorldInteraction.remove(this.onSetWorldInteraction);
         removeViewListener("RECONNECT_EVENT",this.onReconnect);
         this.view.modelInitialized.remove(this.onGameSpriteModelInitialized);
         this.view.drawCharacterWindow.remove(this.onStatusPanelDraw);
         this.hudModelInitialized.remove(this.onHUDModelInitialized);
         this.beginnersPackageAvailable.remove(this.onBeginner);
         this.view.closed.remove(this.onClosed);
         this.newsButtonRefreshSignal.remove(this.onNewsButtonRefreshSignal);
         this.view.disconnect();
      }
      
      public function onSetWorldInteraction(param1:Boolean) : void {
         this.view.mui_.setEnablePlayerInput(param1);
      }
      
      private function onDisplayAreaChanged() : void {
         this.view.positionDynamicDisplays();
      }
      
      private function onShowPackage() : void {
         var _loc1_:PackageInfo = this.packageModel.startupPackage();
         if(_loc1_) {
            this.showPopupSignal.dispatch(new StartupPackage(_loc1_));
         } else {
            this.flushQueueSignal.dispatch();
         }
      }
      
      private function onBeginner(param1:Boolean) : void {
         this.view.showSpecialOfferIfSafe(param1);
      }
      
      private function onClosed() : void {
         if(!this.view.isEditor) {
            this.gameClosed.dispatch();
         }
         this.closeDialogs.dispatch();
         this.closeAllPopups.dispatch();
         System.pauseForGCIfCollectionImminent(0);
      }
      
      private function onGameSpriteModelInitialized() : void {
         this.hudSetupStarted.dispatch(this.view);
         this.initPackages.dispatch();
      }
      
      private function onStatusPanelDraw(param1:Player) : void {
         this.updateHUDSignal.dispatch(param1);
      }
      
      private function onHUDModelInitialized() : void {
         this.view.hudModelInitialized();
      }
      
      private function onNewsButtonRefreshSignal() : void {
         this.view.refreshNewsUpdateButton();
      }
      
      private function onReconnect(param1:ReconnectEvent) : void {
         if(this.view.isEditor) {
            return;
         }
         var _loc2_:GameInitData = new GameInitData();
         _loc2_.server = param1.server_;
         _loc2_.gameId = param1.gameId_;
         _loc2_.createCharacter = param1.createCharacter_;
         _loc2_.charId = param1.charId_;
         _loc2_.keyTime = param1.keyTime_;
         _loc2_.key = param1.key_;
         _loc2_.isFromArena = param1.isFromArena_;
         this.playGame.dispatch(_loc2_);
      }
   }
}
