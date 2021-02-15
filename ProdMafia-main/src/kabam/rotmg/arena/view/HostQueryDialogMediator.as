package kabam.rotmg.arena.view {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import flash.display.BitmapData;
   import flash.events.Event;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class HostQueryDialogMediator extends Mediator {
       
      
      [Inject]
      public var view:HostQueryDialog;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      public function HostQueryDialogMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.setHostIcon(this.makeHostIcon());
         this.view.backClick.add(this.onBackClick);
      }
      
      private function makeHostIcon() : BitmapData {
         return ObjectLibrary.getRedrawnTextureFromType(6546,80,true);
      }
      
      private function onBackClick(param1:Event) : void {
         this.closeDialogs.dispatch();
      }
   }
}
