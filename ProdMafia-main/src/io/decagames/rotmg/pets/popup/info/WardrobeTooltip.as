package io.decagames.rotmg.pets.popup.info {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;

public class WardrobeTooltip extends ToolTip {


    public function WardrobeTooltip() {
        super(3552822, 1, 10197915, 1);
        this.init();
    }
    private var title:UILabel;
    private var topDesc:UILabel;

    private function init():void {
        this.createTitle();
    }

    private function createTitle():void {
        this.title = new UILabel();
        DefaultLabelFormat.petNameLabel(this.title, 16777215);
        addChild(this.title);
        this.title.text = "Wardrobe";
        this.title.y = 5;
        this.title.x = 0;
        this.topDesc = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.topDesc, 11184810);
        addChild(this.topDesc);
        this.topDesc.text = "Change the appearance of your pets by accessing the computer terminal right over there.\n\nYou can unlock pet skins in your wardrobe through hatching and fusing your pets.  Alternatively, you can also find pet skin unlocker items around the Realm and use them while in your Vault to collect more pet skins!";
        this.topDesc.width = 220;
        this.topDesc.wordWrap = true;
        this.topDesc.y = this.title.y + this.title.height;
        this.topDesc.x = 0;
    }
}
}
