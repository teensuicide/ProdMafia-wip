package kabam.rotmg.ui.view.components {
   import flash.display.Shape;
   
   public class DarkLayer extends Shape {
       
      
      public function DarkLayer(param1:int = 2829099) {
         super();
         graphics.beginFill(param1,0.7);
         graphics.drawRect(0,0,800,600);
         graphics.endFill();
      }
   }
}
