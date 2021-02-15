package kabam.rotmg.ui.controller {
   import com.company.assembleegameclient.util.StageProxy;
   import flash.events.MouseEvent;
   import kabam.rotmg.ui.view.UnFocusAble;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class UnFocusAbleMediator extends Mediator {
       
      
      [Inject]
      public var unFocusAble:UnFocusAble;
      
      [Inject]
      public var stageProxy:StageProxy;
      
      public function UnFocusAbleMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.unFocusAble.addEventListener("mouseUp",this.onMouseUp);
      }
      
      override public function destroy() : void {
         this.unFocusAble.removeEventListener("mouseUp",this.onMouseUp);
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         this.stageProxy.setFocus(null);
      }
   }
}
