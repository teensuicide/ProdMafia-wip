package io.decagames.rotmg.shop.packages.startupPackage {
   import io.decagames.rotmg.shop.packages.contentPopup.PackageBoxContentPopup;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
   import kabam.rotmg.packages.services.PackageModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class StartupPackageMediator extends Mediator {
       
      
      [Inject]
      public var view:StartupPackage;
      
      [Inject]
      public var closePopupSignal:ClosePopupSignal;
      
      [Inject]
      public var flush:FlushPopupStartupQueueSignal;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var model:PackageModel;
      
      public function StartupPackageMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.closeButton.clickSignal.addOnce(this.onClose);
         this.view.infoButton.clickSignal.add(this.showInfo);
      }
      
      override public function destroy() : void {
         this.view.infoButton.clickSignal.remove(this.showInfo);
         this.view.dispose();
      }
      
      private function onClose(param1:BaseButton) : void {
         this.closePopupSignal.dispatch(this.view);
         this.flush.dispatch();
      }
      
      private function showInfo(param1:BaseButton) : void {
         this.showPopupSignal.dispatch(new PackageBoxContentPopup(this.view.info));
      }
   }
}
