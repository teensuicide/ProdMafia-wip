package kabam.lib.console.view {
import flash.display.Sprite;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

import kabam.lib.console.model.Console;
import kabam.lib.console.model.Watch;
import kabam.lib.resizing.view.Resizable;

public final class ConsoleOutputView extends Sprite implements Resizable {

    private static const DEFAULT_OUTPUT:String = "kabam.lib/console";


    private const PATTERN:RegExp = /\[0x(.+)\:(.+)\]/gi;

    private const HTML_TEMPLATE:String = "<font color=\'#$1\'>$2</font>";

    private const logged:Array = [];

    private const watched:Array = [];

    private const watchMap:Object = {};

    public function ConsoleOutputView() {
        watchTextField = new TextField();
        super();
        alpha = 0.8;
        blendMode = "layer";
        addChild(this.watchTextField);
        this.watchTextField.alpha = 0.6;
        this.watchTextField.defaultTextFormat = new TextFormat("_sans", 14, 0xffffff, true);
        this.watchTextField.htmlText = "kabam.lib/console";
        this.watchTextField.selectable = false;
        this.watchTextField.multiline = true;
        this.watchTextField.wordWrap = true;
        this.watchTextField.autoSize = "left";
        this.watchTextField.background = true;
        this.watchTextField.border = false;
        this.watchTextField.backgroundColor = 0x3300;
        //this.logConsole = new Console("", new ConsoleConfig());
        //addChild(this.logConsole);
    }
    private var watchTextField:TextField;
    private var logConsole:Console;
    private var watchBottom:Number;

    public function watch(_arg_1:Watch):void {
        var _local3:* = this.watchMap[_arg_1.name] || this.makeWatch(_arg_1.name);
        this.watchMap[_arg_1.name] = _local3;
        var _local2:Watch = _local3;
        _local2.data = _arg_1.data.replace(this.PATTERN, "<font color=\'#$1\'>$2</font>");
        this.updateOutputText();
    }

    public function unwatch(_arg_1:String):void {
        var _local2:Watch = this.watchMap[_arg_1];
        if (_local2) {
            delete this.watchMap[_arg_1];
            this.watched.splice(this.watched.indexOf(_local2), 1);
        }
    }

    public function log(_arg_1:String):void {
        var _local2:String = _arg_1.replace(this.PATTERN, "<font color=\'#$1\'>$2</font>");
        this.logged.push(_local2);
        //this.logConsole.addHTML(_local2);
    }

    public function clear():void {
        var _local1:* = undefined;
        this.logged.length = 0;
        this.watched.length = 0;
        var _local3:int = 0;
        var _local2:* = this.watchMap;
        for (_local1 in this.watchMap) {
            delete this.watchMap[_local1];
        }
    }

    public function resize(_arg_1:Rectangle):void {
        this.watchBottom = _arg_1.height - 20;
        x = _arg_1.x;
        y = _arg_1.y;
        this.watchTextField.width = _arg_1.width;
        //this.logConsole.width = _arg_1.width;
        this.snapWatchTextToInputView();
    }

    public function getText():String {
        return this.logged.join("\r");
    }

    private function makeWatch(_arg_1:String):Watch {
        var _local2:Watch = new Watch(_arg_1);
        this.watched.push(_local2);
        return _local2;
    }

    private function snapWatchTextToInputView():void {
        this.watchTextField.y = this.watchBottom - this.watchTextField.height;
    }

    private function updateOutputText():void {
        this.watchTextField.htmlText = this.watched.join("\n");
        this.snapWatchTextToInputView();
    }
}
}
