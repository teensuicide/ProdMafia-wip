package kabam.rotmg.util.components {
import flash.display.DisplayObject;
import flash.display.Sprite;

import kabam.rotmg.pets.view.components.PopupWindowBackground;

public class InfoHoverPaneFactory extends Sprite {


    public static function make(_arg_1:DisplayObject):Sprite {
        var _local3:* = null;
        if (_arg_1 == null) {
            return null;
        }
        var _local2:Sprite = new Sprite();
        _arg_1.width = 283;
        _arg_1.height = 580;
        _local2.addChild(_arg_1);
        _local3 = new PopupWindowBackground();
        _local3.draw(_arg_1.width, _arg_1.height + 2, 2);
        _local3.x = _arg_1.x;
        _local3.y = _arg_1.y - 1;
        _local2.addChild(_local3);
        return _local2;
    }

    public function InfoHoverPaneFactory() {
        super();
    }
}
}
