package kabam.lib.ui.impl {
import flash.display.DisplayObject;

import kabam.lib.ui.api.Layout;

public class HorizontalLayout implements Layout {


    public function HorizontalLayout() {
        super();
    }
    private var padding:int = 0;

    public function getPadding():int {
        return this.padding;
    }

    public function setPadding(_arg_1:int):void {
        this.padding = _arg_1;
    }

    public function layout(_arg_1:Vector.<DisplayObject>, _arg_2:int = 0):void {
        var _local5:* = null;
        var _local3:int = 0;
        var _local6:* = _arg_2;
        var _local4:int = _arg_1.length;
        while (_local3 < _local4) {
            _local5 = _arg_1[_local3];
            _local5.x = _local6;
            _local6 = _local6 + (_local5.width + this.padding);
            _local3++;
        }
    }
}
}
