package com.company.assembleegameclient.screens {
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import io.decagames.rotmg.seasonalEvent.signals.ShowSeasonHasEndedPopupSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class LeagueItemMediator extends Mediator {
       
      
      [Inject]
      public var view:LeagueItem;
      
      [Inject]
      public var showSeasonHasEndedPopupSignal:ShowSeasonHasEndedPopupSignal;
      
      private var _timer:Timer;
      
      public function LeagueItemMediator() {
         super();
      }
      
      override public function initialize() : void {
         if(this.view.endDate) {
            this._timer = new Timer(1000);
            this._timer.addEventListener("timer",this.onTime);
            this._timer.start();
         }
      }
      
      override public function destroy() : void {
         super.destroy();
         if(this._timer) {
            this._timer.removeEventListener("timer",this.onTime);
            this._timer = null;
         }
      }
      
      private function onTime(param1:TimerEvent) : void {
         var _loc2_:Number = this.view.endDate.time - new Date().time;
         this.view.updateTimeLabel(_loc2_);
         if(_loc2_ <= 0) {
            this._timer.stop();
            this._timer.removeEventListener("timer",this.onTime);
            this.showSeasonHasEndedPopupSignal.dispatch();
         }
      }
   }
}
