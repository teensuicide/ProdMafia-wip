package io.decagames.rotmg.pets.components.tooltip {
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PetTooltipMediator extends Mediator {
       
      
      [Inject]
      public var view:PetTooltip;
      
      public function PetTooltipMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.init();
      }
   }
}
