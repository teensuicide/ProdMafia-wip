package kabam.lib.net.impl {
import flash.utils.IDataInput;
import flash.utils.IDataOutput;

public class Message {


    public function Message(_arg_1:uint, _arg_2:Function = null) {
        super();
        this.id = _arg_1;
        this.isCallback = _arg_2 != null;
        this.callback = _arg_2;
    }
    public var pool:MessagePool;
    public var prev:Message;
    public var next:Message;
    public var id:uint;
    public var callback:Function;
    private var isCallback:Boolean;

    public function parseFromInput(_arg_1:IDataInput):void {
    }

    public function writeToOutput(_arg_1:IDataOutput):void {
    }

    public function toString():String {
        return this.formatToString("MESSAGE", "id");
    }

    public function consume():void {
        this.isCallback && this.callback(this);
        this.prev = null;
        this.next = null;
        this.pool.append(this);
    }

    protected function formatToString(_arg_1:String, ...rest):String {
        var _local3:int = 0;
        var _local5:String = "[" + _arg_1;
        var _local4:uint = rest.length;
        _local3 = 0;
        while (_local3 < _local4) {
            _local5 = _local5 + (" " + rest[_local3] + "=\"" + this[rest[_local3]] + "\"");
            _local3++;
        }
        return _local5 + "]";
    }
}
}
