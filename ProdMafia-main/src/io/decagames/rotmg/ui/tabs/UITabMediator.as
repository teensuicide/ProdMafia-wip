package io.decagames.rotmg.ui.tabs {
import flash.events.Event;

import robotlegs.bender.bundles.mvcs.Mediator;

public class UITabMediator extends Mediator {


    public function UITabMediator() {
        super();
    }
    [Inject]
    public var view:UITab;

    override public function initialize():void {
        if (this.view.transparentBackgroundFix) {
            this.view.addEventListener("enterFrame", this.checkSize);
        }
    }

    override public function destroy():void {
        if (this.view.transparentBackgroundFix) {
            this.view.removeEventListener("enterFrame", this.checkSize);
        }
    }

    private function checkSize(param1:Event):void {
        if (this.view.content) {
            this.view.drawTransparentBackground();
        }
    }
}
}
