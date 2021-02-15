package kabam.lib.util {
public class TimeWriter {


    public function TimeWriter() {
        super();
    }
    private var timeStringStarted:Boolean = false;
    private var seconds:int;
    private var minutes:int;
    private var hours:int;
    private var days:int;
    private var textValues:Array;

    public function parseTime(_arg_1:Number):String {
        this.seconds = Math.floor(_arg_1 / 1000);
        this.minutes = Math.floor(this.seconds / 60);
        this.hours = Math.floor(this.minutes / 60);
        this.days = Math.floor(this.hours / 24);
        this.seconds = this.seconds % 60;
        this.minutes = this.minutes % 60;
        this.hours = this.hours % 24;
        this.timeStringStarted = false;
        this.textValues = [];
        this.formatUnit(this.days, "d");
        this.formatUnit(this.hours, "h");
        this.formatUnit(this.minutes, "m", 2);
        this.formatUnit(this.seconds, "s", 2);
        this.timeStringStarted = false;
        return this.textValues.join(" ");
    }

    private function formatUnit(_arg_1:int, _arg_2:String, _arg_3:int = -1):void {
        if (_arg_1 == 0 && !this.timeStringStarted) {
            return;
        }
        this.timeStringStarted = true;
        var _local5:String = _arg_1.toString();
        if (_arg_3 == -1) {
            _arg_3 = _local5.length;
        }
        var _local4:* = "";
        var _local6:int = _local5.length;
        while (_local6 < _arg_3) {
            _local4 = _local4 + "0";
            _local6++;
        }
        _local5 = _local4 + _local5 + _arg_2;
        this.textValues.push(_local5);
    }
}
}
