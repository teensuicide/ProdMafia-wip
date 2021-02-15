package io.decagames.rotmg.pets.popup.info {
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.Sprite;

import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class PetsTooltip extends ToolTip {


    public function PetsTooltip() {
        super(3552822, 1, 10197915, 1);
        this.init();
    }
    private var title:UILabel;
    private var topDesc:UILabel;
    private var hatchIconContainer:Sprite;
    private var hatchIcon:SliceScalingBitmap;
    private var midDesc:UILabel;
    private var tableLeft:UILabel;
    private var tableCenter:UILabel;
    private var tableRight:UILabel;
    private var tableContainer:Sprite;
    private var botDesc:UILabel;

    private function init():void {
        this.createTitle();
        this.createHatchIcons();
        this.createMiddle();
        this.createTable();
        this.createBottom();
    }

    private function createTitle():void {
        this.title = new UILabel();
        DefaultLabelFormat.petNameLabel(this.title, 16777215);
        addChild(this.title);
        this.title.text = "Pets";
        this.title.y = 5;
        this.title.x = 0;
        this.topDesc = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.topDesc, 11184810);
        addChild(this.topDesc);
        this.topDesc.text = "Hatching a pet egg will provide you with a loyal pet that will follow you into battle.";
        this.topDesc.width = 220;
        this.topDesc.wordWrap = true;
        this.topDesc.y = this.title.y + this.title.height;
        this.topDesc.x = 0;
    }

    private function createHatchIcons():void {
        this.hatchIconContainer = new Sprite();
        addChild(this.hatchIconContainer);
        this.hatchIcon = TextureParser.instance.getSliceScalingBitmap("UI", "PetsTooltip", 280);
        this.hatchIconContainer.addChild(this.hatchIcon);
        this.hatchIcon.width = 196;
        this.hatchIcon.height = 62;
        this.hatchIcon.x = 0;
        this.hatchIcon.y = 0;
        this.hatchIconContainer.y = this.topDesc.y + this.topDesc.height + 5;
        this.hatchIconContainer.x = 10;
    }

    private function createMiddle():void {
        this.midDesc = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.midDesc, 11184810);
        addChild(this.midDesc);
        this.midDesc.text = "Level up your pets’ abilities by feeding them items and then fuse them to take them to the next stage of evolution!\n\nEach of your pets can have up to three abilities. A pet’s first ability is determined by its pet family and itemType, but the second and third abilities are determined at random.\n\nFusing pets will increase the max levels for each of their abilities:";
        this.midDesc.width = 220;
        this.midDesc.wordWrap = true;
        this.midDesc.y = this.hatchIconContainer.y + this.hatchIconContainer.height + 5;
        this.midDesc.x = 0;
    }

    private function createTable():void {
        this.tableContainer = new Sprite();
        addChild(this.tableContainer);
        this.tableLeft = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.tableLeft, 11184810);
        this.tableContainer.addChild(this.tableLeft);
        this.tableLeft.text = "Common\nUncommon\nRare\nLegendary\nDivine";
        this.tableLeft.x = 0;
        var _loc5_:UILabel = new UILabel();
        DefaultLabelFormat.infoTooltipText(_loc5_, 6539085);
        this.tableContainer.addChild(_loc5_);
        _loc5_.text = "1st Ability";
        _loc5_.x = 80;
        _loc5_.y = 0;
        var _loc1_:UILabel = new UILabel();
        DefaultLabelFormat.infoTooltipText(_loc1_, 6539085);
        this.tableContainer.addChild(_loc1_);
        _loc1_.text = "2nd Ability";
        _loc1_.x = 80;
        _loc1_.y = _loc5_.y + _loc5_.height - 4;
        var _loc3_:UILabel = new UILabel();
        DefaultLabelFormat.infoTooltipText(_loc3_, 5082311);
        this.tableContainer.addChild(_loc3_);
        _loc3_.text = "Evolution";
        _loc3_.x = 80;
        _loc3_.y = _loc1_.y + _loc1_.height - 4;
        var _loc4_:UILabel = new UILabel();
        DefaultLabelFormat.infoTooltipText(_loc4_, 6539085);
        this.tableContainer.addChild(_loc4_);
        _loc4_.text = "3rd Ability";
        _loc4_.x = 80;
        _loc4_.y = _loc3_.y + _loc3_.height - 4;
        var _loc2_:UILabel = new UILabel();
        DefaultLabelFormat.infoTooltipText(_loc2_, 5082311);
        this.tableContainer.addChild(_loc2_);
        _loc2_.text = "Evolution";
        _loc2_.x = 80;
        _loc2_.y = _loc4_.y + _loc4_.height - 4;
        this.tableRight = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.tableRight, 11184810);
        this.tableContainer.addChild(this.tableRight);
        this.tableRight.text = "Lvl. 30\nLvl. 50\nLvl. 70\nLvl. 90\nLvl. 100";
        this.tableRight.x = 160;
        this.tableContainer.height = 80;
        this.tableContainer.y = this.midDesc.y + this.midDesc.height + 5;
        this.tableContainer.x = 0;
    }

    private function createBottom():void {
        this.botDesc = new UILabel();
        DefaultLabelFormat.infoTooltipText(this.botDesc, 11184810);
        addChild(this.botDesc);
        this.botDesc.text = "As you fuse your pets from Uncommon to Rare and Legendary to Divine, they will evolve to get a new name and look!";
        this.botDesc.width = 220;
        this.botDesc.wordWrap = true;
        this.botDesc.y = this.tableContainer.y + this.tableContainer.height + 5;
        this.botDesc.x = 0;
    }
}
}
