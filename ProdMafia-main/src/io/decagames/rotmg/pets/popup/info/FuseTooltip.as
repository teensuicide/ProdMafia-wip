package io.decagames.rotmg.pets.popup.info {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class FuseTooltip extends ToolTip {


    public function FuseTooltip() {
        super(3552822, 1, 10197915, 1);
        this.init();
    }
    private var title:UILabel;
    private var topDesc:UILabel;
    private var fuseIcon:SliceScalingBitmap;
    private var imageContainer:Sprite;
    private var botDesc:UILabel;

    private function init():void {
        this.createTitle();
        this.createImage();
        this.createBottom();
    }

    private function createTitle():void {
        this.title = new UILabel();
        DefaultLabelFormat.petNameLabel(this.title, 16777215);
        addChild(this.title);
        this.title.text = "Fusing";
        this.title.y = 5;
        this.title.x = 0;
        this.topDesc = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.topDesc, 11184810);
        addChild(this.topDesc);
        this.topDesc.text = "With some of the technology we stole from the Mad Lab, we can fuse pets together to unlock new abilities, achieve higher max stats, and get your pets to evolve into stronger and more beautiful creatures! Fusing two pets from a given rarity level will produce a pet at a higher rarity level:";
        this.topDesc.width = 220;
        this.topDesc.wordWrap = true;
        this.topDesc.y = this.title.y + this.title.height;
        this.topDesc.x = 0;
    }

    private function createImage():void {
        this.imageContainer = new Sprite();
        addChild(this.imageContainer);
        this.fuseIcon = TextureParser.instance.getSliceScalingBitmap("UI", "FuseTooltip", 280);
        this.imageContainer.addChild(this.fuseIcon);
        this.fuseIcon.width = 180;
        this.fuseIcon.height = 151;
        this.fuseIcon.x = 0;
        this.fuseIcon.y = 0;
        this.imageContainer.y = this.topDesc.y + this.topDesc.height + 5;
        this.imageContainer.x = 20;
    }

    private function createBottom():void {
        this.botDesc = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.botDesc, 11184810);
        addChild(this.botDesc);
        this.botDesc.text = "You can fuse any two pets that are the same family and rarity at any time. However, pets will only have the highest possible ability levels if you fuse them after they have been fed enough items to reach their max ability levels.";
        this.botDesc.width = 220;
        this.botDesc.wordWrap = true;
        this.botDesc.y = this.imageContainer.y + this.imageContainer.height + 5;
        this.botDesc.x = 0;
    }
}
}
