package com.company.assembleegameclient.editor {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.utils.Dictionary;

public class CommandMenu extends Sprite {


    public function CommandMenu() {
        keyCodeDict_ = new Dictionary();
        super();
        addEventListener("addedToStage", this.onAddedToStage);
        addEventListener("removedFromStage", this.onRemovedFromStage);
    }
    private var keyCodeDict_:Dictionary;
    private var yOffset_:int = 0;
    private var selected_:CommandMenuItem = null;

    public function getCommand():int {
        return this.selected_.command_;
    }

    public function setCommand(_arg_1:int):void {
        var _local3:* = null;
        var _local2:int = 0;
        while (_local2 < numChildren) {
            _local3 = getChildAt(_local2) as CommandMenuItem;
            if (_local3 != null) {
                if (_local3.command_ == _arg_1) {
                    this.setSelected(_local3);
                    return;
                }
            }
            _local2++;
        }
    }

    protected function setSelected(_arg_1:CommandMenuItem):void {
        if (this.selected_ != null) {
            this.selected_.setSelected(false);
        }
        this.selected_ = _arg_1;
        this.selected_.setSelected(true);
    }

    protected function addCommandMenuItem(_arg_1:String, _arg_2:int, _arg_3:Function, _arg_4:int):void {
        var _local5:CommandMenuItem = new CommandMenuItem(_arg_1, _arg_3, _arg_4);
        _local5.y = this.yOffset_;
        addChild(_local5);
        if (_arg_2 != -1) {
            this.keyCodeDict_[_arg_2] = _local5;
        }
        if (this.selected_ == null) {
            this.setSelected(_local5);
        }
        this.yOffset_ = this.yOffset_ + 30;
    }

    protected function addBreak():void {
        this.yOffset_ = this.yOffset_ + 30;
    }

    private function onAddedToStage(_arg_1:Event):void {
        stage.addEventListener("keyDown", this.onKeyDown);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        stage.removeEventListener("keyDown", this.onKeyDown);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        if (stage.focus != null) {
            return;
        }
        var _local2:CommandMenuItem = this.keyCodeDict_[_arg_1.keyCode];
        if (_local2 == null) {
            return;
        }
        _local2.callback_(_local2);
    }
}
}
