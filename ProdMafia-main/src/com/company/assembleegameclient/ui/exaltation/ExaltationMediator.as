package com.company.assembleegameclient.ui.exaltation {
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.popups.signals.ClosePopupSignal;
import io.decagames.rotmg.ui.texture.TextureParser;
import robotlegs.bender.bundles.mvcs.Mediator;

public class ExaltationMediator extends Mediator {


   [Inject]
   public var view:ExaltationView;

   [Inject]
   public var closePopupSignal:ClosePopupSignal;

   private var closeButton:SliceScalingButton;

   public function ExaltationMediator() {
      super();
   }

   override public function initialize() : void {
      this.closeButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","close_button"));
      this.closeButton.clickSignal.addOnce(this.onClose);
      this.view.header.addButton(this.closeButton,"right_button");
   }

   override public function destroy() : void {
      this.closeButton.dispose();
   }

   private function onClose(param1:BaseButton) : void {
      this.closePopupSignal.dispatch(this.view);
   }
}
}
