package kabam.lib.console.model {
import org.osflash.signals.Signal;

internal final class ActionHash {


    function ActionHash() {
        super();
        this.signalMap = {};
        this.descriptionMap = {};
    }
    private var signalMap:Object;
    private var descriptionMap:Object;

    public function register(_arg_1:String, _arg_2:String, _arg_3:Signal):void {
        this.signalMap[_arg_1] = _arg_3;
        this.descriptionMap[_arg_1] = _arg_2;
    }

    public function getNames():Vector.<String> {
        var _local1:Vector.<String> = new Vector.<String>(0);
        for (var _local2:String in this.signalMap) {
            _local1.push(_local2 + " - " + this.descriptionMap[_local2]);
        }
        return _local1;
    }

    public function execute(_arg_1:String):void {
        var _local2:Array = _arg_1.split(" ");
        if (_local2.length == 0) {
            return;
        }
        var _local4:String = _local2.shift();
        var _local3:Signal = this.signalMap[_local4];
        if (!_local3) {
            return;
        }
        if (_local2.length > 0) {
            _local3.dispatch.apply(this, _local2.join(" ").split(","));
        } else {
            _local3.dispatch.apply(this);
        }
    }

    public function has(_arg_1:String):Boolean {
        var _local2:Array = _arg_1.split(" ");
        return _local2.length > 0 && this.signalMap[_local2[0]] != null;
    }
}
}
