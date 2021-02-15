package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import flash.display.BitmapData;

public class ClosedVaultChest extends SellableObject {


    public function ClosedVaultChest(_arg_1:XML) {
        super(_arg_1);
    }

    override public function soldObjectName():String {
        return "Vault.chest";
    }

    override public function soldObjectInternalName():String {
        return "Vault Chest";
    }

    override public function getTooltip():ToolTip {
        return new TextToolTip(0x363636, 0x9b9b9b, this.soldObjectName(), "Vault.chestDescription", 200);
    }

    override public function getSellableType():int {
        return ObjectLibrary.idToType_["Vault Chest"];
    }

    override public function getIcon():BitmapData {
        return ObjectLibrary.getRedrawnTextureFromType(ObjectLibrary.idToType_["Vault Chest"], 80, true);
    }
}
}
