package io.decagames.rotmg.ui.labels {
import flash.text.TextField;

public class UILabel extends TextField {

    public static var DEBUG:Boolean = false;


    public function UILabel() {
        super();
        if (DEBUG) {
            this.debugDraw();
        }
        this.embedFonts = true;
        this.selectable = false;
        this.autoSize = "left";
    }

    override public function set y(param1:Number):void {
        super.y = param1;
    }

    override public function get textWidth():Number {
        return super.textWidth + 4;
    }

    private function debugDraw():void {
        this.border = true;
        this.borderColor = 16711680;
    }
}
}
