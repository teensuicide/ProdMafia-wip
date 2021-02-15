package kabam.rotmg.minimap.control {
   import org.osflash.signals.Signal;
   
   public class UpdateGroundTileSignal extends Signal {
       
      
      public function UpdateGroundTileSignal() {
         super(int,int,uint);
      }
   }
}
