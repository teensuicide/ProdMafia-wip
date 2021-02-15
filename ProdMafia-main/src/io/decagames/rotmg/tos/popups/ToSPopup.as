package io.decagames.rotmg.tos.popups {
import io.decagames.rotmg.tos.popups.buttons.AcceptButton;
import io.decagames.rotmg.tos.popups.buttons.RefuseButton;
import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.popups.modal.TextModal;

public class ToSPopup extends TextModal {


    public function ToSPopup() {
        var _loc1_:Vector.<BaseButton> = new Vector.<BaseButton>();
        _loc1_.push(new RefuseButton());
        _loc1_.push(new AcceptButton());
        super(400, "Update to Terms of Service and Privacy", "We have updated our <font color=\"#7777EE\"><a href=\"http://legal.decagames.com/tos/\" target=\"_blank\">Terms of Service</a></font> and <font color=\"#7777EE\"><a href=\"http://legal.decagames.com/privacy/\" target=\"_blank\">Privacy Policy</a></font> to be compliant with the new European regulations regarding data privacy and make them clearer for you to understand.\n\nYou need to review and accept our Terms of Service and Privacy Policy in order to be able to continue playing Realm of the Mad God.\n\nBy clicking accept you hereby confirm that you are at least 16 years old.", _loc1_, true);
    }
}
}
