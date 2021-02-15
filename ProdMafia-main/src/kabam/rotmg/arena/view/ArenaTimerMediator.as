package kabam.rotmg.arena.view {
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import kabam.rotmg.arena.control.ArenaDeathSignal;
   import kabam.rotmg.arena.control.ImminentArenaWaveSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ArenaTimerMediator extends Mediator {
       
      
      [Inject]
      public var view:ArenaTimer;
      
      [Inject]
      public var imminentWave:ImminentArenaWaveSignal;
      
      [Inject]
      public var arenaDeath:ArenaDeathSignal;
      
      private var delayTimer:Timer;
      
      public function ArenaTimerMediator() {
         delayTimer = new Timer(6000);
         super();
      }
      
      override public function initialize() : void {
         this.imminentWave.add(this.startView);
         this.arenaDeath.add(this.onArenaDeath);
         this.delayTimer.addEventListener("timer",this.onRestart);
      }
      
      override public function destroy() : void {
         this.imminentWave.remove(this.startView);
         this.arenaDeath.remove(this.onArenaDeath);
         this.view.stop();
      }
      
      private function onArenaDeath() : void {
         this.view.stop();
      }
      
      private function startView(param1:int) : void {
         this.delayTimer.start();
         this.view.stop();
      }
      
      private function onRestart(param1:TimerEvent) : void {
         this.delayTimer.stop();
         this.view.start();
         this.view.x = 300 - this.view.width / 2;
      }
   }
}
