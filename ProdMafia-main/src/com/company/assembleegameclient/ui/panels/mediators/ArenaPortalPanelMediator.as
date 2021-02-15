package com.company.assembleegameclient.ui.panels.mediators {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.assembleegameclient.ui.panels.ArenaPortalPanel;
   import com.company.assembleegameclient.util.Currency;
   import flash.events.Event;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.view.RegisterPromptDialog;
   import kabam.rotmg.arena.model.CurrentArenaRunModel;
   import kabam.rotmg.arena.service.GetBestArenaRunTask;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.game.signals.ExitGameSignal;
   import kabam.rotmg.messaging.impl.outgoing.arena.EnterArena;
   import kabam.rotmg.ui.view.NotEnoughGoldDialog;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ArenaPortalPanelMediator extends Mediator {
      
      public static const TEXT:String = "SellableObjectPanelMediator.text";
       
      
      [Inject]
      public var view:ArenaPortalPanel;
      
      [Inject]
      public var socketServer:SocketServer;
      
      [Inject]
      public var messages:MessageProvider;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var closeDialog:CloseDialogsSignal;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var currentRunModel:CurrentArenaRunModel;
      
      [Inject]
      public var injector:Injector;
      
      [Inject]
      public var exitSignal:ExitGameSignal;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      private var dialog:Dialog;
      
      public function ArenaPortalPanelMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.purchase.add(this.onPurchase);
      }
      
      private function onPurchase(param1:int) : void {
         if(param1 == 0) {
            this.purchaseWithGold();
         } else {
            this.purchaseWithFame();
         }
      }
      
      private function purchaseWithFame() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(this.gameModel.player.nameChosen_) {
            this.currentRunModel.saveCurrentUserInfo();
            _loc2_ = this.injector.getInstance(GetBestArenaRunTask);
            _loc2_.start();
            _loc1_ = this.messages.require(17) as EnterArena;
            _loc1_.currency = 1;
            this.socketServer.sendMessage(_loc1_);
            this.exitSignal.dispatch();
         } else {
            this.dialog = new Dialog("MustBeNamed.title","MustBeNamed.desc","ErrorDialog.ok",null,null);
            this.dialog.addEventListener("dialogLeftButton",this.onNoNameDialogClose);
            this.openDialog.dispatch(this.dialog);
         }
      }
      
      private function purchaseWithGold() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!this.account.isRegistered()) {
            this.openDialog.dispatch(new RegisterPromptDialog("SellableObjectPanelMediator.text",{"type":Currency.typeToName(0)}));
         } else if(!this.gameModel.player.nameChosen_) {
            this.dialog = new Dialog("MustBeNamed.title","MustBeNamed.desc","ErrorDialog.ok",null,null);
            this.dialog.addEventListener("dialogLeftButton",this.onNoNameDialogClose);
            this.openDialog.dispatch(this.dialog);
         } else if(this.gameModel.player.credits_ < 50) {
            this.showPopupSignal.dispatch(new NotEnoughGoldDialog());
         } else {
            this.currentRunModel.saveCurrentUserInfo();
            _loc2_ = this.injector.getInstance(GetBestArenaRunTask);
            _loc2_.start();
            _loc1_ = this.messages.require(17) as EnterArena;
            _loc1_.currency = 0;
            this.socketServer.sendMessage(_loc1_);
            this.exitSignal.dispatch();
         }
      }
      
      private function onNoNameDialogClose(param1:Event) : void {
         if(this.dialog && this.dialog.hasEventListener("dialogLeftButton")) {
            this.dialog.removeEventListener("dialogLeftButton",this.onNoNameDialogClose);
         }
         this.dialog = null;
         this.closeDialog.dispatch();
      }
   }
}
