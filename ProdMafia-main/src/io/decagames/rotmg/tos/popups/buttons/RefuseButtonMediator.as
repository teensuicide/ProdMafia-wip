package io.decagames.rotmg.tos.popups.buttons {
import io.decagames.rotmg.tos.popups.RefusePopup;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class RefuseButtonMediator extends Mediator {


    public function RefuseButtonMediator() {
        super();
    }
    [Inject]
    public var view:RefuseButton;
    [Inject]
    public var closePopupSignal:CloseCurrentPopupSignal;
    [Inject]
    public var showPopupSignal:ShowPopupSignal;

    override public function initialize():void {
        this.view.clickSignal.add(this.clickHandler);
    }

    override public function destroy():void {
        this.view.clickSignal.remove(this.clickHandler);
    }

    private function clickHandler(param1:BaseButton):void {
        this.closePopupSignal.dispatch();
        this.showPopupSignal.dispatch(new RefusePopup());
    }
}
}
