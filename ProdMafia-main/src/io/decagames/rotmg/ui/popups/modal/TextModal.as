package io.decagames.rotmg.ui.popups.modal {
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;

public class TextModal extends ModalPopup {


    public function TextModal(param1:int, param2:String, param3:String, param4:Vector.<BaseButton>, param5:Boolean = false) {
        var _loc9_:int = 0;
        var _loc7_:int = 0;
        var _loc6_:* = null;
        super(param1, 0, param2);
        var _loc8_:UILabel = new UILabel();
        _loc8_.multiline = true;
        DefaultLabelFormat.defaultTextModalText(_loc8_);
        _loc8_.multiline = true;
        _loc8_.width = param1;
        if (param5) {
            _loc8_.htmlText = param3;
        } else {
            _loc8_.text = param3;
        }
        _loc8_.wordWrap = true;
        addChild(_loc8_);
        var _loc11_:int = 0;
        var _loc10_:* = param4;
        for each(_loc6_ in param4) {
            _loc7_ = _loc7_ + _loc6_.width;
        }
        _loc7_ = _loc7_ + this.buttonsMargin * (param4.length - 1);
        _loc9_ = (param1 - _loc7_) / 2;
        var _loc13_:int = 0;
        var _loc12_:* = param4;
        for each(_loc6_ in param4) {
            _loc6_.x = _loc9_;
            _loc9_ = _loc9_ + (this.buttonsMargin + _loc6_.width);
            _loc6_.y = _loc8_.y + _loc8_.textHeight + 15;
            addChild(_loc6_);
            registerButton(_loc6_);
        }
    }
    private var buttonsMargin:int = 30;
}
}
