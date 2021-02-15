package kabam.lib.util {
public class VectorAS3Util {


    public static function toArray(_arg_1:Object):Array {
        var _local3:* = null;
        var _local2:* = [];
        var _local5:int = 0;
        var _local4:* = _arg_1;
        for each(_local3 in _arg_1) {
            _local2.push(_local3);
        }
        return _local2;
    }

    public function VectorAS3Util() {
        super();
    }
}
}
