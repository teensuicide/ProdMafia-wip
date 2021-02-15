package kabam.rotmg.arena.view {
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.rotmg.arena.model.ArenaLeaderboardEntry;
   import kabam.rotmg.arena.model.BestArenaRunModel;
   import kabam.rotmg.arena.model.CurrentArenaRunModel;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class BattleSummaryDialogMediator extends Mediator {
       
      
      [Inject]
      public var view:BattleSummaryDialog;
      
      [Inject]
      public var currentRunModel:CurrentArenaRunModel;
      
      [Inject]
      public var bestRunModel:BestArenaRunModel;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      private var fadeOutTimer:Timer;
      
      public function BattleSummaryDialogMediator() {
         fadeOutTimer = new Timer(800,1);
         super();
      }
      
      override public function initialize() : void {
         this.view.visible = false;
         this.view.positionThis();
         this.view.setCurrentRun(this.currentRunModel.entry.currentWave,this.currentRunModel.entry.runtime);
         var _loc2_:Boolean = this.bestRunModel.entry.currentWave > this.currentRunModel.entry.currentWave || this.bestRunModel.entry.currentWave == this.currentRunModel.entry.currentWave && this.bestRunModel.entry.runtime < this.currentRunModel.entry.runtime;
         var _loc1_:ArenaLeaderboardEntry = !!_loc2_?this.bestRunModel.entry:this.currentRunModel.entry;
         this.view.setBestRun(_loc1_.currentWave,_loc1_.runtime);
         this.view.close.add(this.onClose);
      }
      
      override public function destroy() : void {
         this.view.close.remove(this.onClose);
      }
      
      private function onClose() : void {
         this.openDialog.dispatch(new ArenaLeaderboard());
      }
      
      private function startTimer() : void {
         this.fadeOutTimer.addEventListener("timer",this.showBattleSummaryDialog);
         this.fadeOutTimer.start();
      }
      
      private function showBattleSummaryDialog(param1:TimerEvent) : void {
         this.fadeOutTimer.removeEventListener("timer",this.showBattleSummaryDialog);
         this.view.visible = true;
      }
   }
}
