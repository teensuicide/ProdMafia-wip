package io.decagames.rotmg.pets.popup.ability {
import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.popups.modal.ModalPopup;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class NewAbilityUnlockedDialog extends ModalPopup {


    public function NewAbilityUnlockedDialog(param1:String) {
        var _loc2_:* = null;
        var _loc4_:* = null;
        var _loc3_:* = null;
        super(270, 120, LineBuilder.getLocalizedStringFromKey("NewAbility.gratz"));
        _loc2_ = new UILabel();
        DefaultLabelFormat.newAbilityInfo(_loc2_);
        _loc2_.y = 5;
        _loc2_.width = _contentWidth;
        _loc2_.wordWrap = true;
        _loc2_.text = LineBuilder.getLocalizedStringFromKey("NewAbility.text");
        addChild(_loc2_);
        var _loc5_:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", "popup_content_inset", 229);
        addChild(_loc5_);
        _loc5_.height = 35;
        _loc5_.y = _loc2_.y + _loc2_.textHeight + 10;
        _loc5_.x = Math.round((_contentWidth - _loc5_.width) / 2);
        _loc4_ = new UILabel();
        DefaultLabelFormat.newAbilityName(_loc4_);
        _loc4_.y = _loc5_.y + 8;
        _loc4_.width = _contentWidth;
        _loc4_.wordWrap = true;
        _loc4_.text = param1;
        addChild(_loc4_);
        _loc3_ = new TextureParser().getSliceScalingBitmap("UI", "main_button_decoration", 194);
        addChild(_loc3_);
        _loc3_.y = _loc5_.y + _loc5_.height + 10;
        _loc3_.x = Math.round((_contentWidth - _loc3_.width) / 2);
        this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI", "generic_green_button"));
        this._okButton.setLabel(LineBuilder.getLocalizedStringFromKey("NewAbility.righteous"), DefaultLabelFormat.questButtonCompleteLabel);
        this._okButton.width = 149;
        this._okButton.x = Math.round((_contentWidth - this._okButton.width) / 2);
        this._okButton.y = _loc3_.y + 6;
        addChild(this._okButton);
    }

    private var _okButton:SliceScalingButton;

    public function get okButton():SliceScalingButton {
        return this._okButton;
    }
}
}
