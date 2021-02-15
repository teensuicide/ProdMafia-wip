package io.decagames.rotmg.pets.popup.info {
import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;

import robotlegs.bender.bundles.mvcs.Mediator;

public class PetInfoItemMediator extends Mediator {


    public function PetInfoItemMediator() {
        super();
    }
    [Inject]
    public var view:PetInfoItem;
    [Inject]
    public var showTooltipSignal:ShowTooltipSignal;
    [Inject]
    public var hideTooltipSignal:HideTooltipsSignal;
    private var hoverTooltipDelegate:HoverTooltipDelegate;

    override public function initialize():void {
        var _loc1_:* = null;
        if (this.view.titel == "Pets") {
            _loc1_ = new PetsTooltip();
        } else if (this.view.titel == "Feeding") {
            _loc1_ = new FeedTooltip();
        } else if (this.view.titel == "Fusing") {
            _loc1_ = new FuseTooltip();
        } else if (this.view.titel == "Upgrade") {
            _loc1_ = new UpgradeTooltip();
        } else if (this.view.titel == "Wardrobe") {
            _loc1_ = new WardrobeTooltip();
        }
        this.hoverTooltipDelegate = new HoverTooltipDelegate();
        this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
        this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipSignal);
        this.hoverTooltipDelegate.setDisplayObject(this.view.background);
        this.hoverTooltipDelegate.tooltip = _loc1_;
    }
}
}
