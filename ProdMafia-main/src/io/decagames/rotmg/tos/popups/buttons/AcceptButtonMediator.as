package io.decagames.rotmg.tos.popups.buttons {
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;

import kabam.rotmg.account.core.Account;
import kabam.rotmg.appengine.api.AppEngineClient;

import robotlegs.bender.bundles.mvcs.Mediator;

public class AcceptButtonMediator extends Mediator {


    public function AcceptButtonMediator() {
        super();
    }
    [Inject]
    public var view:AcceptButton;
    [Inject]
    public var appEngineClient:AppEngineClient;
    [Inject]
    public var account:Account;
    [Inject]
    public var closePopupSignal:CloseCurrentPopupSignal;

    override public function initialize():void {
        this.view.clickSignal.add(this.onClickHandler);
    }

    override public function destroy():void {
        this.view.clickSignal.remove(this.onClickHandler);
    }

    private function onClickHandler(param1:BaseButton):void {
        this.appEngineClient.sendRequest("account/acceptTOS", this.account.getCredentials());
        this.closePopupSignal.dispatch();
    }
}
}
