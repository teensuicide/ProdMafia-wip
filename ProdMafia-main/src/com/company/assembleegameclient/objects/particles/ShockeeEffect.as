package com.company.assembleegameclient.objects.particles {
   import com.company.assembleegameclient.objects.GameObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class ShockeeEffect extends ParticleEffect {
       
      
      public var start_:Point;
      
      public var go:GameObject;
      
      private var isShocked:Boolean;
      
      public function ShockeeEffect(param1:GameObject) {
         super();
         this.go = param1;
         this.go.hasShock = true;
      }
      
      override public function update(param1:int, param2:int) : Boolean {
         var _loc3_:Timer = new Timer(50,12);
         _loc3_.addEventListener("timer",this.onTimer);
         _loc3_.addEventListener("timerComplete",this.onTimerComplete);
         _loc3_.start();
         return false;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void {
         this.go = null;
      }
      
      private function onTimer(param1:TimerEvent) : void {
         this.isShocked = !this.isShocked;
         if(this.go) {
            this.go.toggleShockEffect(this.isShocked);
         }
      }
   }
}
