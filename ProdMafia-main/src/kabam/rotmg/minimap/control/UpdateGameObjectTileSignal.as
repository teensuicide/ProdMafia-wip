package kabam.rotmg.minimap.control {
   import com.company.assembleegameclient.objects.GameObject;
   import org.osflash.signals.Signal;
   
   public class UpdateGameObjectTileSignal extends Signal {
       
      
      public function UpdateGameObjectTileSignal() {
         super(Number,Number,GameObject);
      }
   }
}
