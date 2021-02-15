package kabam.rotmg.ui {
   import com.company.assembleegameclient.ui.menu.PlayerGroupMenu;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import org.swiftsuspenders.Injector;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PlayerGroupMenuMediator extends Mediator {
       
      
      [Inject]
      public var view:PlayerGroupMenu;
      
      public function PlayerGroupMenuMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.unableToTeleport.add(this.onUnableToTeleport);
      }
      
      override public function destroy() : void {
         this.view.unableToTeleport.remove(this.onUnableToTeleport);
      }
      
      private function onUnableToTeleport() : void {
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc1_:AddTextLineSignal = _loc2_.getInstance(AddTextLineSignal);
         _loc1_.dispatch(ChatMessage.make("*Error*","No players are eligible for teleporting."));
      }
   }
}
