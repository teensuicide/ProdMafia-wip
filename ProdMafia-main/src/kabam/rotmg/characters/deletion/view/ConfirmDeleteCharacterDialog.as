package kabam.rotmg.characters.deletion.view {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import flash.display.Sprite;
   import flash.events.Event;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.rotmg.core.StaticInjectorContext;
   import org.osflash.signals.Signal;
   
   public class ConfirmDeleteCharacterDialog extends Sprite {
       
      
      private const CANCEL_EVENT:String = "dialogLeftButton";
      
      private const DELETE_EVENT:String = "dialogRightButton";
      
      public var deleteCharacter:Signal;
      
      public var cancel:Signal;
      
      public function ConfirmDeleteCharacterDialog() {
         super();
         this.deleteCharacter = new Signal();
         this.cancel = new Signal();
      }
      
      public function setText(param1:String, param2:String) : void {
         var _loc5_:Boolean = StaticInjectorContext.getInjector().getInstance(SeasonalEventModel).isChallenger;
         var _loc4_:String = !_loc5_?"ConfirmDeleteCharacterDialog":"It will cost you a character life to delete {name} the {displayID} - Are you really sure you want to?";
         var _loc3_:Dialog = new Dialog("ConfirmDelete.verifyDeletion","","ConfirmDelete.cancel","ConfirmDelete.delete","/deleteDialog");
         _loc3_.setTextParams(_loc4_,{
            "name":param1,
            "displayID":param2
         });
         _loc3_.addEventListener("dialogLeftButton",this.onCancel);
         _loc3_.addEventListener("dialogRightButton",this.onDelete);
         addChild(_loc3_);
      }
      
      private function onCancel(param1:Event) : void {
         this.cancel.dispatch();
      }
      
      private function onDelete(param1:Event) : void {
         this.deleteCharacter.dispatch();
      }
   }
}
