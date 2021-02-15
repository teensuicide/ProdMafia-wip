package kabam.lib.console.view {
import flash.events.KeyboardEvent;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

import kabam.lib.resizing.view.Resizable;
import kabam.lib.util.StageLifecycleUtil;

public final class ConsoleInputView extends TextField implements Resizable {

    public static const HEIGHT:int = 20;

    public function ConsoleInputView() {
        super();
        background = true;
        backgroundColor = 0x3300;
        border = true;
        borderColor = 0x333333;
        defaultTextFormat = new TextFormat("_sans", 14, 0xffffff, true);
        text = "";
        type = "input";
        restrict = "^`";
        this.lifecycle = new StageLifecycleUtil(this);
        this.lifecycle.addedToStage.add(this.onAddedToStage);
        this.lifecycle.removedFromStage.add(this.onRemovedFromStage);
    }
    private var lifecycle:StageLifecycleUtil;

    public function resize(_arg_1:Rectangle):void {
        var _local2:int = _arg_1.height * 0.5;
        if (_local2 > 20) {
            _local2 = 20;
        }
        width = _arg_1.width;
        height = _local2;
        x = _arg_1.x;
        y = _arg_1.bottom - height;
    }

    private function onAddedToStage():void {
        addEventListener("keyDown", this.onKeyDown);
    }

    private function onRemovedFromStage():void {
        removeEventListener("keyDown", this.onKeyDown);
    }

    private function onKeyDown(_arg_1:KeyboardEvent):void {
        var _local2:String = text;
        var _local3:* = _arg_1.keyCode;
        switch (_local3) {
            case 13:
                text = "";
                dispatchEvent(new ConsoleEvent("ConsoleEvent.INPUT", _local2));
                return;
            case 38:
                dispatchEvent(new ConsoleEvent("ConsoleEvent.GET_PREVIOUS"));
                return;
            case 40:
                dispatchEvent(new ConsoleEvent("ConsoleEvent.GET_NEXT"));
                return;
            default:
                return;
        }
    }
}
}
