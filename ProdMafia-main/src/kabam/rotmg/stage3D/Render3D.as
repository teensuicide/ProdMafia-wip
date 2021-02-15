package kabam.rotmg.stage3D {
   import flash.display.GraphicsBitmapFill;
   import org.osflash.signals.Signal;
   
   public class Render3D extends Signal {
       
      
      public function Render3D() {
         super(Vector.<GraphicsBitmapFill>,uint);
      }
   }
}
