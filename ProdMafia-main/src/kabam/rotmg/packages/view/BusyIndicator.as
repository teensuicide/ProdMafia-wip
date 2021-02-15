package kabam.rotmg.packages.view {
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BusyIndicator extends Sprite {
       
      
      private const pinwheel:Sprite = makePinWheel();
      
      private const innerCircleMask:Sprite = makeInner();
      
      private const quarterCircleMask:Sprite = makeQuarter();
      
      private const timer:Timer = new Timer(25);
      
      private const radius:int = 22;
      
      private const color:uint = 16777215;
      
      public function BusyIndicator() {
         super();
         y = 22;
         x = 22;
         this.addChildren();
         addEventListener("addedToStage",this.onAdded);
         addEventListener("removedFromStage",this.onRemoved);
      }
      
      private function makePinWheel() : Sprite {
         var _loc1_:* = null;
         _loc1_ = new Sprite();
         _loc1_.blendMode = "layer";
         _loc1_.graphics.beginFill(16777215);
         _loc1_.graphics.drawCircle(0,0,22);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function makeInner() : Sprite {
         var _loc1_:Sprite = new Sprite();
         _loc1_.blendMode = "erase";
         _loc1_.graphics.beginFill(10066329);
         _loc1_.graphics.drawCircle(0,0,11);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function makeQuarter() : Sprite {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215);
         _loc1_.graphics.drawRect(0,0,22,22);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function addChildren() : void {
         this.pinwheel.addChild(this.innerCircleMask);
         this.pinwheel.addChild(this.quarterCircleMask);
         this.pinwheel.mask = this.quarterCircleMask;
         addChild(this.pinwheel);
      }
      
      private function onAdded(param1:Event) : void {
         this.timer.addEventListener("timer",this.updatePinwheel);
         this.timer.start();
      }
      
      private function onRemoved(param1:Event) : void {
         this.timer.stop();
         this.timer.removeEventListener("timer",this.updatePinwheel);
      }
      
      private function updatePinwheel(param1:TimerEvent) : void {
         this.quarterCircleMask.rotation = this.quarterCircleMask.rotation + 20;
      }
   }
}
