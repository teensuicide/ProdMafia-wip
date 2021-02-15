package kabam.lib.signals {
import org.osflash.signals.ISlot;
import org.osflash.signals.Signal;

public class DeferredQueueSignal extends Signal {


    public function DeferredQueueSignal(...rest) {
        data = [];
        super(rest);
    }
    private var data:Array;
    private var log:Boolean = true;

    override public function dispatch(...rest):void {
        if (this.log) {
            this.data.push(rest);
        }
        super.dispatch.apply(this, rest);
    }

    override public function add(_arg_1:Function):ISlot {
        var _local2:ISlot = super.add(_arg_1);
        while (this.data.length > 0) {
            _arg_1.apply(this, this.data.shift());
        }
        this.log = false;
        return _local2;
    }

    override public function addOnce(_arg_1:Function):ISlot {
        var _local2:* = null;
        if (this.data.length > 0) {
            _arg_1.apply(this, this.data.shift());
        } else {
            _local2 = super.addOnce(_arg_1);
            this.log = false;
        }
        while (this.data.length > 0) {
            this.data.shift();
        }
        return _local2;
    }

    public function getNumData():int {
        return this.data.length;
    }
}
}
