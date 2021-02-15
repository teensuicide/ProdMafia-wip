package kabam.lib.util {
import flash.display.DisplayObject;
import flash.events.Event;

import org.osflash.signals.Signal;

public class StageLifecycleUtil {


    public function StageLifecycleUtil(_arg_1:DisplayObject) {
        super();
        this.target = _arg_1;
        _arg_1.addEventListener("addedToStage", this.handleAddedToStage);
    }
    private var target:DisplayObject;

    private var _addedToStage:Signal;

    public function get addedToStage():Signal {
        var _local1:* = this._addedToStage || new Signal();
        this._addedToStage = _local1;
        return _local1;
    }

    private var _removedFromStage:Signal;

    public function get removedFromStage():Signal {
        var _local1:* = this._removedFromStage || new Signal();
        this._removedFromStage = _local1;
        return _local1;
    }

    private function handleAddedToStage(_arg_1:Event):void {
        this.target.removeEventListener("addedToStage", this.handleAddedToStage);
        this.target.addEventListener("removedFromStage", this.handleRemovedFromStage);
    }

    private function handleRemovedFromStage(_arg_1:Event):void {
        this.target.addEventListener("addedToStage", this.handleAddedToStage);
        this.target.removeEventListener("removedFromStage", this.handleRemovedFromStage);
    }
}
}
