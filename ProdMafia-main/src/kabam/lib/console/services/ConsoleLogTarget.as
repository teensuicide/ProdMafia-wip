package kabam.lib.console.services {
import kabam.lib.console.signals.ConsoleLogSignal;

import robotlegs.bender.extensions.logging.impl.LogMessageParser;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogTarget;
import robotlegs.bender.framework.api.LogLevel;

public class ConsoleLogTarget implements ILogTarget {


    public function ConsoleLogTarget(_arg_1:IContext) {
        super();
        this.consoleLog = _arg_1.injector.getInstance(ConsoleLogSignal);
        this.messageParser = new LogMessageParser();
    }
    private var consoleLog:ConsoleLogSignal;
    private var messageParser:LogMessageParser;

    public function log(_arg_1:Object, _arg_2:uint, _arg_3:int, _arg_4:String, _arg_5:Array = null):void {
        var _local6:String = LogLevel.NAME[_arg_2] + " " + _arg_1 + " " + this.messageParser.parseMessage(_arg_4, _arg_5);
        this.consoleLog.dispatch(_local6);
    }
}
}
