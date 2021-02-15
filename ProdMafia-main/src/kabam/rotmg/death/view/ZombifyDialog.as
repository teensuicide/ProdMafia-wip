package kabam.rotmg.death.view {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import flash.display.Sprite;
   import flash.events.Event;
   import org.osflash.signals.Signal;
   
   public class ZombifyDialog extends Sprite {
      
      public static const TITLE:String = "ZombifyDialog.title";
      
      public static const BODY:String = "ZombifyDialog.body";
      
      public static const BUTTON:String = "ZombifyDialog.button";
       
      
      public const closed:Signal = new Signal();
      
      private var dialog:Dialog;
      
      public function ZombifyDialog() {
         super();
         this.dialog = new Dialog("ZombifyDialog.title","ZombifyDialog.body","ZombifyDialog.button",null,null);
         this.dialog.offsetX = -100;
         this.dialog.offsetY = 200;
         this.dialog.addEventListener("dialogLeftButton",this.onButtonClick);
         addChild(this.dialog);
      }
      
      private function onButtonClick(param1:Event) : void {
         this.closed.dispatch();
      }
   }
}
