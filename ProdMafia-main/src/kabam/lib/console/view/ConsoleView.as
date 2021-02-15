package kabam.lib.console.view {
import flash.display.Sprite;

public final class ConsoleView extends Sprite {


    public function ConsoleView() {
        super();
        var _local1:* = new ConsoleOutputView();
        this.output = _local1;
        addChild(_local1);
        _local1 = new ConsoleInputView();
        this.input = _local1;
        addChild(_local1);
    }
    public var output:ConsoleOutputView;
    public var input:ConsoleInputView;

    override public function set visible(_arg_1:Boolean):void {
        super.visible = _arg_1;
        if (_arg_1 && stage) {
            stage.focus = this.input;
        }
    }
}
}
