package io.decagames.rotmg.ui.buttons {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import org.osflash.signals.Signal;

public class BaseButton extends Sprite {


    public function BaseButton() {
        clickSignal = new Signal();
        rollOverSignal = new Signal();
        rollOutSignal = new Signal();
        super();
        this.addEventListener("addedToStage", this.onAddedToStage);
    }
    public var clickSignal:Signal;
    public var rollOverSignal:Signal;
    public var rollOutSignal:Signal;

    protected var _disabled:Boolean;

    public function get disabled():Boolean {
        return this._disabled;
    }

    public function set disabled(param1:Boolean):void {
        this._disabled = param1;
    }

    private var _instanceName:String;

    public function get instanceName():String {
        return this._instanceName;
    }

    public function set instanceName(param1:String):void {
        this._instanceName = param1;
    }

    public function dispose():void {
        this.removeEventListener("addedToStage", this.onAddedToStage);
        this.removeEventListener("click", this.onClickHandler);
        this.removeEventListener("mouseOut", this.onRollOutHandler);
        this.removeEventListener("mouseOver", this.onRollOverHandler);
        this.removeEventListener("mouseDown", this.onMouseDownHandler);
        this.clickSignal.removeAll();
        this.rollOverSignal.removeAll();
        this.rollOutSignal.removeAll();
    }

    protected function onAddedToStage(param1:Event):void {
        this.removeEventListener("addedToStage", this.onAddedToStage);
        this.addEventListener("click", this.onClickHandler);
        this.addEventListener("mouseOut", this.onRollOutHandler);
        this.addEventListener("mouseOver", this.onRollOverHandler);
        this.addEventListener("mouseDown", this.onMouseDownHandler);
    }

    protected function onClickHandler(param1:MouseEvent):void {
        if (!this._disabled) {
            this.clickSignal.dispatch(this);
        }
    }

    protected function onMouseDownHandler(param1:MouseEvent):void {
    }

    protected function onRollOutHandler(param1:MouseEvent):void {
        this.rollOutSignal.dispatch(this);
    }

    protected function onRollOverHandler(param1:MouseEvent):void {
        this.rollOverSignal.dispatch(this);
    }
}
}
