package kabam.rotmg.util.components {
   import flash.display.Sprite;
   import kabam.rotmg.util.graphics.BevelRect;
   import kabam.rotmg.util.graphics.GraphicsHelper;
   
   public class DialogBackground extends Sprite {
      
      private static const BEVEL:int = 4;
       
      
      public function DialogBackground() {
         super();
      }
      
      public function draw(param1:int, param2:int) : void {
         var _loc4_:BevelRect = new BevelRect(param1,param2,4);
         var _loc3_:GraphicsHelper = new GraphicsHelper();
         graphics.lineStyle(1,16777215,1,false,"normal","none","round",3);
         graphics.beginFill(3552822);
         _loc3_.drawBevelRect(0,0,_loc4_,graphics);
         graphics.endFill();
      }
   }
}
