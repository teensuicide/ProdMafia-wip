package kabam.rotmg.arena.view {
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.rotmg.arena.model.CurrentArenaRunModel;
   import kabam.rotmg.core.view.Layers;
   import kabam.rotmg.game.signals.GameClosedSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ImminentWaveCountdownClockMediator extends Mediator {
       
      
      [Inject]
      public var view:ImminentWaveCountdownClock;
      
      [Inject]
      public var layers:Layers;
      
      [Inject]
      public var currentArenaRun:CurrentArenaRunModel;
      
      [Inject]
      public var gameClosed:GameClosedSignal;
      
      private var fadeOutTimer:Timer;
      
      public function ImminentWaveCountdownClockMediator() {
         fadeOutTimer = new Timer(800,1);
         super();
      }
      
      override public function initialize() : void {
         this.fadeOutTimer.addEventListener("timer",this.onShow);
         this.gameClosed.add(this.removeView);
         this.view.setWaveNumber(this.currentArenaRun.entry.currentWave);
         this.view.close.addOnce(this.onClose);
         this.view.init();
         if(this.currentArenaRun.entry.currentWave == 1) {
            this.fadeOutTimer.start();
         } else {
            this.view.show();
         }
      }
      
      override public function destroy() : void {
         this.fadeOutTimer.removeEventListener("timer",this.onShow);
         this.gameClosed.remove(this.removeView);
      }
      
      private function removeView() : void {
         this.view.destroy();
         this.onClose();
      }
      
      private function initView() : void {
         this.fadeOutTimer.start();
      }
      
      private function onClose() : void {
         if(this.layers.mouseDisabledTop.contains(this.view)) {
            this.layers.mouseDisabledTop.removeChild(this.view);
         }
      }
      
      private function onShow(param1:TimerEvent) : void {
         this.view.show();
      }
   }
}
