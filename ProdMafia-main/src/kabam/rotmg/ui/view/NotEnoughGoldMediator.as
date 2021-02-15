package kabam.rotmg.ui.view {
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.services.GetOffersTask;
   import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class NotEnoughGoldMediator extends Mediator {
       
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var getOffers:GetOffersTask;
      
      [Inject]
      public var view:NotEnoughGoldDialog;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var openMoneyWindow:OpenMoneyWindowSignal;
      
      public function NotEnoughGoldMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.getOffers.start();
         this.view.buyGold.clickSignal.add(this.onBuyGold);
         this.view.cancel.clickSignal.add(this.onCancel);
      }
      
      override public function destroy() : void {
         this.view.buyGold.clickSignal.remove(this.onBuyGold);
         this.view.cancel.clickSignal.remove(this.onCancel);
      }
      
      public function onCancel(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
      }
      
      public function onBuyGold(param1:BaseButton) : void {
         this.openMoneyWindow.dispatch();
      }
   }
}
