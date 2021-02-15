package com.company.assembleegameclient.ui {
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.Player;
import com.company.assembleegameclient.ui.tooltip.PlayerToolTip;
import com.company.util.MoreColorUtil;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.ColorTransform;

import kabam.rotmg.core.signals.HideTooltipsSignal;
import kabam.rotmg.core.signals.ShowTooltipSignal;
import kabam.rotmg.tooltips.HoverTooltipDelegate;
import kabam.rotmg.tooltips.TooltipAble;

public class PlayerGameObjectListItem extends GameObjectListItem implements TooltipAble {


    public const hoverTooltipDelegate:HoverTooltipDelegate = new HoverTooltipDelegate();

    public function PlayerGameObjectListItem(_arg_1:uint, _arg_2:Boolean, _arg_3:GameObject) {
        super(_arg_1, _arg_2, _arg_3);
        var _local4:Player = _arg_3 as Player;
        if (_local4) {
            this.starred = _local4.starred_;
        }
        addEventListener("addedToStage", this.onAddedToStage, false, 0, true);
        addEventListener("removedFromStage", this.onRemovedFromStage, false, 0, true);
    }
    private var enabled:Boolean = true;
    private var starred:Boolean = false;

    override public function draw(_arg_1:GameObject, _arg_2:ColorTransform = null):void {
        var _local3:Player = _arg_1 as Player;
        if (_local3 && this.starred != _local3.starred_) {
            transform.colorTransform = _arg_2 || MoreColorUtil.identity;
            this.starred = _local3.starred_;
        }
        super.draw(_arg_1, _arg_2);
    }

    public function setEnabled(_arg_1:Boolean):void {
        if (this.enabled != _arg_1 && Player(go) != null) {
            this.enabled = _arg_1;
            this.hoverTooltipDelegate.tooltip = !!this.enabled ? new PlayerToolTip(Player(go)) : null;
            if (!this.enabled) {
                this.hoverTooltipDelegate.getShowToolTip().dispatch(this.hoverTooltipDelegate.tooltip);
            }
        }
    }

    public function setShowToolTipSignal(_arg_1:ShowTooltipSignal):void {
        this.hoverTooltipDelegate.setShowToolTipSignal(_arg_1);
    }

    public function getShowToolTip():ShowTooltipSignal {
        return this.hoverTooltipDelegate.getShowToolTip();
    }

    public function setHideToolTipsSignal(_arg_1:HideTooltipsSignal):void {
        this.hoverTooltipDelegate.setHideToolTipsSignal(_arg_1);
    }

    public function getHideToolTips():HideTooltipsSignal {
        return this.hoverTooltipDelegate.getHideToolTips();
    }

    private function onAddedToStage(_arg_1:Event):void {
        addEventListener("mouseOver", this.onMouseOver, false, 0, true);
        this.hoverTooltipDelegate.setDisplayObject(this);
        addEventListener("rightClick", this.onRightClick, false, 0, true);
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener("mouseOver", this.onMouseOver);
        removeEventListener("addedToStage", this.onAddedToStage);
        removeEventListener("removedFromStage", this.onRemovedFromStage);
        removeEventListener("rightClick", this.onRightClick);
    }

    private function onRightClick(_arg_1:MouseEvent):void {
        if (this.go.map_.isNexus) {
            this.go.map_.gs_.gsc_.requestTrade(go.name_);
        } else {
            this.go.map_.gs_.gsc_.teleport(go.objectId_);
        }
    }

    private function onMouseOver(_arg_1:MouseEvent):void {
        this.hoverTooltipDelegate.tooltip = !!this.enabled ? new PlayerToolTip(Player(go)) : null;
    }
}
}
