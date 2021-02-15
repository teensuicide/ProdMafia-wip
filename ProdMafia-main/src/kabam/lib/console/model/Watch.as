package kabam.lib.console.model {
public class Watch {


    public function Watch(_arg_1:String, _arg_2:String = "") {
        super();
        this.name = _arg_1;
        this.data = _arg_2;
    }
    public var name:String;
    public var data:String;

    public function toString():String {
        return this.data;
    }
}
}
