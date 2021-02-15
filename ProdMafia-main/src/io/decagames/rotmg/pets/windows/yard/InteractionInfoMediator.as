package io.decagames.rotmg.pets.windows.yard {
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class InteractionInfoMediator extends Mediator {
       
      
      [Inject]
      public var view:InteractionInfo;
      
      public function InteractionInfoMediator() {
         super();
      }
      
      override public function initialize() : void {
      }
   }
}
