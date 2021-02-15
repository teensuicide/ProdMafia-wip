package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.signals.TextPanelMessageUpdateSignal;
import kabam.rotmg.game.view.TextPanel;

public class ClosedGiftChest extends GameObject implements IInteractiveObject {


    public function ClosedGiftChest(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
        this.textPanelUpdateSignal = StaticInjectorContext.getInjector().getInstance(TextPanelMessageUpdateSignal);
    }
    private var textPanelUpdateSignal:TextPanelMessageUpdateSignal;

    public function getTooltip():ToolTip {
        return new TextToolTip(0x363636, 0x9b9b9b, "ClosedGiftChest.title", "TextPanel.giftChestIsEmpty", 200);
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        this.textPanelUpdateSignal.dispatch("TextPanel.giftChestIsEmpty");
        return new TextPanel(_arg_1);
    }
}
}
