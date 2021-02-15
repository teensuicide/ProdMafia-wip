package kabam.rotmg.friends.view {
   import flash.display.Sprite;
   import io.decagames.rotmg.social.model.FriendVO;
   import org.osflash.signals.Signal;
   
   public class FListItem extends Sprite {
       
      
      public var actionSignal:Signal;
      
      public function FListItem() {
         actionSignal = new Signal(String,String);
         super();
      }
      
      public function update(param1:FriendVO, param2:String) : void {
      }
      
      public function destroy() : void {
      }
      
      protected function init(param1:Number, param2:Number) : void {
      }
   }
}
