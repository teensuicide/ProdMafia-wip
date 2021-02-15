package io.decagames.rotmg.ui.scroll {
import flash.events.Event;
import flash.events.MouseEvent;

import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.framework.api.ILogger;

public class UIScrollbarMediator extends Mediator {


    public function UIScrollbarMediator() {
        super();
    }
    [Inject]
    public var view:UIScrollbar;
    [Inject]
    public var logger:ILogger;
    private var startDragging:Boolean;
    private var startY:Number;

    override public function initialize():void {
        this.view.addEventListener("enterFrame", this.onUpdateHandler);
        this.view.slider.addEventListener("mouseDown", this.onMouseDown);
        Main.STAGE.addEventListener("mouseUp", this.onMouseUp);
        Main.STAGE.addEventListener("mouseWheel", this.onMouseWheel);
    }

    override public function destroy():void {
        this.view.removeEventListener("enterFrame", this.onUpdateHandler);
        this.view.slider.removeEventListener("mouseDown", this.onMouseDown);
        if (this.view.scrollObject) {
            this.view.scrollObject.removeEventListener("mouseWheel", this.onMouseWheel);
        }
        Main.STAGE.removeEventListener("mouseUp", this.onMouseUp);
        Main.STAGE.removeEventListener("mouseWheel", this.onMouseWheel);
        this.view.dispose();
    }

    private function onMouseWheel(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        param1.stopPropagation();
        this.view.updatePosition(-param1.delta * this.view.mouseRollSpeedFactor);
    }

    private function onMouseDown(param1:Event):void {
        this.startDragging = true;
        this.startY = Main.STAGE.mouseY;
    }

    private function onMouseUp(param1:Event):void {
        this.startDragging = false;
    }

    private function onUpdateHandler(param1:Event):void {
        if (this.view.scrollObject && !this.view.scrollObject.hasEventListener("mouseWheel")) {
            this.view.scrollObject.addEventListener("mouseWheel", this.onMouseWheel);
        }
        if (this.startDragging) {
            this.view.updatePosition(Main.STAGE.mouseY - this.startY);
            this.startY = Main.STAGE.mouseY;
        }
        this.view.update();
    }
}
}
