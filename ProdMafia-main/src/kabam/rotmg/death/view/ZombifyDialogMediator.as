package kabam.rotmg.death.view {
   import flash.display.BitmapData;
   import kabam.rotmg.death.control.HandleNormalDeathSignal;
   import kabam.rotmg.death.model.DeathModel;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ZombifyDialogMediator extends Mediator {
       
      
      [Inject]
      public var view:ZombifyDialog;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      [Inject]
      public var handleDeath:HandleNormalDeathSignal;
      
      [Inject]
      public var death:DeathModel;
      
      public function ZombifyDialogMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.closed.addOnce(this.onClosed);
      }
      
      private function onClosed() : void {
         var _loc2_:* = null;
         _loc2_ = this.death.getLastDeath();
         var _loc1_:BitmapData = new BitmapData(this.view.stage.width,this.view.stage.height,true,0);
         _loc1_.draw(this.view.stage);
         _loc2_.background = _loc1_;
         this.closeDialogs.dispatch();
         this.handleDeath.dispatch(_loc2_);
      }
   }
}
