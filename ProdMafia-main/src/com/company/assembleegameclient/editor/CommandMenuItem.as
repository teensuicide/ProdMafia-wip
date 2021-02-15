package com.company.assembleegameclient.editor {
import com.company.ui.BaseSimpleText;

import flash.display.Sprite;
import flash.events.MouseEvent;

public class CommandMenuItem extends Sprite {

    private static const WIDTH:int = 80;

    private static const HEIGHT:int = 25;

    public function CommandMenuItem(_arg_1:String, _arg_2:Function, _arg_3:int) {
        super();
        this.callback_ = _arg_2;
        this.command_ = _arg_3;
        this.text_ = new BaseSimpleText(16, 0xffffff, false, 0, 0);
        this.text_.setBold(true);
        this.text_.text = _arg_1;
        this.text_.updateMetrics();
        this.text_.x = 2;
        addChild(this.text_);
        this.redraw();
        addEventListener("mouseOver", this.onMouseOver);
        addEventListener("mouseOut", this.onMouseOut);
        addEventListener("mouseDown", this.onMouseDown);
        addEventListener("mouseUp", this.onMouseUp);
        addEventListener("click", this.onClick);
    }
    public var callback_:Function;
    public var command_:int;
    private var over_:Boolean = false;
    private var down_:Boolean = false;
    private var selected_:Boolean = false;
    private var text_:BaseSimpleText;

    public function setSelected(_arg_1:Boolean):void {
        this.selected_ = _arg_1;
        this.redraw();
    }

    public function setLabel(_arg_1:String):void {
        this.text_.text = _arg_1;
        this.text_.updateMetrics();
    }

    private function redraw():void {
        graphics.clear();
        if (this.selected_ || this.down_) {
            graphics.lineStyle(2, 0xffffff);
            graphics.beginFill(0x7f7f7f, 1);
            graphics.drawRect(0, 0, 80, 25);
            graphics.endFill();
            graphics.lineStyle();
        } else if (this.over_) {
            graphics.lineStyle(2, 0xffffff);
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, 80, 25);
            graphics.endFill();
            graphics.lineStyle();
        } else {
            graphics.lineStyle(1, 0xffffff);
            graphics.beginFill(0, 0);
            graphics.drawRect(0, 0, 80, 25);
            graphics.endFill();
            graphics.lineStyle();
        }
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.over_ = true;
        this.redraw();
    }

    private function onMouseOut(_arg_1:MouseEvent):void {
        this.over_ = false;
        this.down_ = false;
        this.redraw();
    }

    private function onMouseDown(_arg_1:MouseEvent):void {
        this.down_ = true;
        this.redraw();
    }

    private function onMouseUp(_arg_1:MouseEvent):void {
        this.down_ = false;
        this.redraw();
    }

    private function onClick(_arg_1:MouseEvent):void {
        this.callback_(this);
    }
}
}
