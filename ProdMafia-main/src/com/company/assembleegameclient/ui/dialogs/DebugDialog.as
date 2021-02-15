package com.company.assembleegameclient.ui.dialogs {
import flash.events.Event;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.dialogs.control.CloseDialogsSignal;

public class DebugDialog extends StaticDialog {


    public function DebugDialog(_arg_1:String, _arg_2:String = "Debug", _arg_3:Function = null) {
        super(_arg_2, _arg_1, "OK", null, null);
        this.f = _arg_3;
        addEventListener("dialogLeftButton", this.onDialogComplete);
    }
    private var f:Function;

    private function onDialogComplete(_arg_1:Event):void {
        var _local2:CloseDialogsSignal = StaticInjectorContext.getInjector().getInstance(CloseDialogsSignal);
        _local2.dispatch();
        if (this.parent != null && this.parent.contains(this)) {
            this.parent.removeChild(this);
        }
        if (this.f != null) {
            this.f();
        }
    }
}
}
