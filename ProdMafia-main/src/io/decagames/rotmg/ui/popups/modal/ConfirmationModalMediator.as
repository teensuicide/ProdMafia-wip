package io.decagames.rotmg.ui.popups.modal {
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ConfirmationModalMediator extends Mediator {


    public function ConfirmationModalMediator() {
        super();
    }
    [Inject]
    public var view:ConfirmationModal;
    [Inject]
    public var closeSignal:CloseCurrentPopupSignal;

    override public function initialize():void {
        this.view.confirmButton.clickSignal.addOnce(this.onConfirmClicked);
    }

    override public function destroy():void {
        this.view.confirmButton.clickSignal.remove(this.onConfirmClicked);
    }

    private function onConfirmClicked(param1:BaseButton):void {
        this.closeSignal.dispatch();
    }
}
}
