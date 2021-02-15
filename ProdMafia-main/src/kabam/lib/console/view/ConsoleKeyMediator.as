package kabam.lib.console.view {
import flash.display.DisplayObjectContainer;
import flash.events.KeyboardEvent;

import kabam.lib.console.signals.ToggleConsoleSignal;

import robotlegs.bender.bundles.mvcs.Mediator;

public class ConsoleKeyMediator extends Mediator {


    private const TRIGGER:uint = 123;

    public function ConsoleKeyMediator() {
        super();
    }
    [Inject]
    public var view:DisplayObjectContainer;
    [Inject]
    public var toggle:ToggleConsoleSignal;

    override public function initialize():void {
        this.view.stage.addEventListener("keyDown", this.onKeyDown);
    }

    override public function destroy():void {
        this.view.stage.removeEventListener("keyDown", this.onKeyDown);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if (_arg_1.keyCode == 123) {
            this.toggle.dispatch();
        }
    }
}
}
