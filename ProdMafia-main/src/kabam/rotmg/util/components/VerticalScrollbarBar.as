package kabam.rotmg.util.components {
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kabam.rotmg.util.graphics.BevelRect;
   import kabam.rotmg.util.graphics.GraphicsHelper;
   import org.osflash.signals.Signal;
   
   final class VerticalScrollbarBar extends Sprite {
      
      public static const WIDTH:int = 20;
      
      public static const BEVEL:int = 4;
      
      public static const PADDING:int = 0;
       
      
      public const dragging:Signal = new Signal(int);
      
      public const scrolling:Signal = new Signal(Number);
      
      public const rect:BevelRect = new BevelRect(20,0,4);
      
      private const helper:GraphicsHelper = new GraphicsHelper();
      
      private var downOffset:Number;
      
      private var isOver:Boolean;
      
      private var isDown:Boolean;
      
      function VerticalScrollbarBar() {
         super();
      }
      
      public function redraw() : void {
         var _loc1_:int = this.isOver || this.isDown?16767876:13421772;
         graphics.clear();
         graphics.beginFill(_loc1_);
         this.helper.drawBevelRect(0,0,this.rect,graphics);
         graphics.endFill();
      }
      
      public function addMouseListeners() : void {
         addEventListener("mouseDown",this.onMouseDown);
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("mouseOut",this.onMouseOut);
         if(parent && parent.parent) {
            parent.parent.addEventListener("mouseWheel",this.onMouseWheel);
         } else if(Main.STAGE) {
            Main.STAGE.addEventListener("mouseWheel",this.onMouseWheel);
         }
      }
      
      public function removeMouseListeners() : void {
         removeEventListener("mouseOver",this.onMouseOver);
         removeEventListener("mouseOut",this.onMouseOut);
         removeEventListener("mouseDown",this.onMouseDown);
         if(parent && parent.parent) {
            parent.parent.removeEventListener("mouseWheel",this.onMouseWheel);
         } else if(Main.STAGE) {
            Main.STAGE.removeEventListener("mouseWheel",this.onMouseWheel);
         }
         this.onMouseUp();
      }
      
      protected function onMouseWheel(param1:MouseEvent) : void {
         if(param1.delta > 0) {
            this.scrolling.dispatch(-0.25);
         } else if(param1.delta < 0) {
            this.scrolling.dispatch(0.25);
         }
      }
      
      private function onMouseDown(param1:MouseEvent = null) : void {
         this.isDown = true;
         this.downOffset = parent.mouseY - y;
         if(stage != null) {
            stage.addEventListener("mouseUp",this.onMouseUp);
         }
         addEventListener("enterFrame",this.iterate);
         this.redraw();
      }
      
      private function onMouseUp(param1:MouseEvent = null) : void {
         this.isDown = false;
         if(stage != null) {
            stage.removeEventListener("mouseUp",this.onMouseUp);
         }
         removeEventListener("enterFrame",this.iterate);
         this.redraw();
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.isOver = true;
         this.redraw();
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.isOver = false;
         this.redraw();
      }
      
      private function iterate(param1:Event) : void {
         this.dragging.dispatch(int(parent.mouseY - this.downOffset));
      }
   }
}
