package kabam.lib.net.impl {
import kabam.lib.net.api.MessageMap;
import kabam.lib.net.api.MessageMapping;
import kabam.lib.net.api.MessageProvider;

import org.swiftsuspenders.Injector;

public class MessageCenter implements MessageMap, MessageProvider {

    private static const MAX_ID:int = 256;


    private const maps:Vector.<MessageCenterMapping> = new Vector.<MessageCenterMapping>(256, true);

    private const pools:Vector.<MessagePool> = new Vector.<MessagePool>(256, true);

    public function MessageCenter() {
        super();
    }
    private var injector:Injector;

    public function setInjector(_arg_1:Injector):MessageCenter {
        this.injector = _arg_1;
        return this;
    }

    public function map(_arg_1:int):MessageMapping {
        var _local2:* = this.maps[_arg_1] || this.makeMapping(_arg_1);
        this.maps[_arg_1] = _local2;
        return _local2;
    }

    public function unmap(_arg_1:int):void {
        this.pools[_arg_1] && this.pools[_arg_1].dispose();
        this.pools[_arg_1] = null;
        this.maps[_arg_1] = null;
    }

    public function require(_arg_1:int):Message {
        var _local3:MessagePool = this.pools[_arg_1] || this.makePool(_arg_1);
        if (!_local3)
            return null;

        this.pools[_arg_1] = _local3;
        var _local2:MessagePool = _local3;
        return _local2.require();
    }

    private function makeMapping(_arg_1:int):MessageCenterMapping {
        return new MessageCenterMapping().setInjector(this.injector).setID(_arg_1) as MessageCenterMapping;
    }

    private function makePool(_arg_1:uint):MessagePool {
        var _local2:MessageCenterMapping = this.maps[_arg_1];
        return _local2 ? _local2.makePool() : null;
    }
}
}
