package kabam.rotmg.util.components {
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kabam.rotmg.util.graphics.BevelRect;
   import kabam.rotmg.util.graphics.GraphicsHelper;
   import org.osflash.signals.Signal;
   
   final class VerticalScrollbarGroove extends Sprite {
      
      public static const WIDTH:int = 20;
      
      public static const BEVEL:int = 4;
       
      
      public const clicked:Signal = new Signal(int);
      
      public const rect:BevelRect = new BevelRect(20,0,4);
      
      private const helper:GraphicsHelper = new GraphicsHelper();
      
      function VerticalScrollbarGroove() {
         super();
      }
      
      public function redraw() : void {
         graphics.clear();
         graphics.beginFill(5526612);
         this.helper.drawBevelRect(0,0,this.rect,graphics);
         graphics.endFill();
      }
      
      public function addMouseListeners() : void {
         addEventListener("click",this.onClick);
      }
      
      public function removeMouseListeners() : void {
         removeEventListener("click",this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void {
         this.clicked.dispatch(mouseY);
      }
   }
}
