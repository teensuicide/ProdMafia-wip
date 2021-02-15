package com.company.assembleegameclient.ui.panels.mediators {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
   import kabam.rotmg.ui.signals.ToggleShowTierTagSignal;
   import kabam.rotmg.ui.signals.UpdateHUDSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class InventoryGridMediator extends Mediator {
       
      
      [Inject]
      public var view:InventoryGrid;
      
      [Inject]
      public var updateHUD:UpdateHUDSignal;
      
      [Inject]
      public var toggleShowTierTag:ToggleShowTierTagSignal;
      
      public function InventoryGridMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.updateHUD.add(this.onUpdateHUD);
         this.toggleShowTierTag.add(this.onToggleShowTierTag);
      }
      
      override public function destroy() : void {
         this.updateHUD.remove(this.onUpdateHUD);
      }
      
      private function onToggleShowTierTag(param1:Boolean) : void {
         this.view.toggleTierTags(param1);
      }
      
      private function onUpdateHUD(param1:Player) : void {
         this.view.draw();
      }
   }
}
