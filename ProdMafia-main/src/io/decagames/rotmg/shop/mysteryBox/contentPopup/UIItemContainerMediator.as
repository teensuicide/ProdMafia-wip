package io.decagames.rotmg.shop.mysteryBox.contentPopup {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.tooltip.EquipmentToolTip;
   import flash.events.MouseEvent;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class UIItemContainerMediator extends Mediator {
       
      
      [Inject]
      public var view:UIItemContainer;
      
      [Inject]
      public var hud:HUDModel;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      private var tooltip:EquipmentToolTip;
      
      public function UIItemContainerMediator() {
         super();
      }
      
      override public function initialize() : void {
         var _loc2_:Player = this.hud.gameSprite && this.hud.gameSprite.map?this.hud.gameSprite.map.player_:null;
         var _loc1_:int = ObjectLibrary.idToType_[this.view.itemId];
         this.tooltip = new EquipmentToolTip(this.view.itemId,_loc2_,_loc1_,"CURRENT_PLAYER");
         this.view.addEventListener("rollOver",this.onRollOverHandler);
      }
      
      override public function destroy() : void {
         this.view.removeEventListener("rollOver",this.onRollOverHandler);
         this.tooltip.detachFromTarget();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void {
         if(this.view.showTooltip) {
            this.tooltip.attachToTarget(this.view);
            this.showTooltipSignal.dispatch(this.tooltip);
         }
      }
   }
}
