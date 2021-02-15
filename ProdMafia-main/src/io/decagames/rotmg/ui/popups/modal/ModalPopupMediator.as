package io.decagames.rotmg.ui.popups.modal {
import flash.events.Event;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ModalPopupMediator extends Mediator {


    public function ModalPopupMediator() {
        super();
    }
    [Inject]
    public var view:ModalPopup;
    private var lastContentHeight:int = 0;

    override public function initialize():void {
        if (this.view.autoSize) {
            this.lastContentHeight = this.view.contentContainer.height;
            this.view.resize();
            this.view.addEventListener("enterFrame", this.checkForUpdates);
        }
    }

    override public function destroy():void {
        this.view.removeEventListener("enterFrame", this.checkForUpdates);
        this.view.dispose();
    }

    private function checkForUpdates(param1:Event):void {
        if (this.view.contentContainer.height != this.lastContentHeight) {
            this.lastContentHeight = this.view.contentContainer.height;
            this.view.resize();
        }
    }
}
}
