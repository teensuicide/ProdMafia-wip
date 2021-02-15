package kabam.rotmg.arena.view {
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
   import kabam.rotmg.arena.model.CurrentArenaRunModel;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.external.command.RequestPlayerCreditsCompleteSignal;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.messaging.impl.outgoing.arena.EnterArena;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ContinueOrQuitMediator extends Mediator {
       
      
      [Inject]
      public var view:ContinueOrQuitDialog;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      [Inject]
      public var socketServer:SocketServer;
      
      [Inject]
      public var messages:MessageProvider;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var currentRunModel:CurrentArenaRunModel;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var requestPlayerCreditsComplete:RequestPlayerCreditsCompleteSignal;
      
      [Inject]
      public var openMoneyWindow:OpenMoneyWindowSignal;
      
      public function ContinueOrQuitMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.requestPlayerCreditsComplete.add(this.onRequestPlayerCreditsComplete);
         this.view.quit.add(this.onQuit);
         this.view.buyContinue.add(this.onContinue);
         this.view.init(this.currentRunModel.entry.currentWave,this.gameModel.player.credits_);
      }
      
      override public function destroy() : void {
         this.requestPlayerCreditsComplete.remove(this.onRequestPlayerCreditsComplete);
         this.view.quit.remove(this.onQuit);
         this.view.buyContinue.remove(this.onContinue);
         this.view.destroy();
      }
      
      private function onRequestPlayerCreditsComplete() : void {
         this.view.setProcessing(false);
      }
      
      private function onContinue(param1:int, param2:int) : void {
         var _loc3_:* = null;
         if(this.gameModel.player.credits_ >= param2) {
            this.closeDialogs.dispatch();
            _loc3_ = this.messages.require(17) as EnterArena;
            _loc3_.currency = param1;
            this.socketServer.sendMessage(_loc3_);
         } else {
            this.view.setProcessing(true);
            this.openMoneyWindow.dispatch();
         }
      }
      
      private function onQuit() : void {
         this.closeDialogs.dispatch();
         this.hudModel.gameSprite.gsc_.escape();
      }
   }
}
