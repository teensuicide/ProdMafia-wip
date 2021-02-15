package kabam.lib.json {
import com.hurlant.util.Base64;

public class Base64Decoder {


    public function Base64Decoder() {
        super();
    }

    public function decode(_arg_1:String):String {
        var _local2:RegExp = /-/g;
        var _local4:RegExp = /_/g;
        var _local3:int = 4 - _arg_1.length % 4;
        while (true) {
            _local3--;
            if (!_local3) {
                break;
            }
            _arg_1 = _arg_1 + "=";
        }
        _arg_1 = _arg_1.replace(_local2, "+").replace(_local4, "/");
        return Base64.decode(_arg_1);
    }
}
}
