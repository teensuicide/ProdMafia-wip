package io.decagames.rotmg.ui.tabs {
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

import io.decagames.rotmg.ui.buttons.SliceScalingButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class TabButton extends SliceScalingButton {

    public static const SELECTED_MARGIN:int = 3;

    public static const LEFT:String = "left";

    public static const RIGHT:String = "right";

    public static const CENTER:String = "center";

    public static const BORDERLESS:String = "borderless";

    public function TabButton(param1:String) {
        this.buttonType = param1;
        var _loc3_:* = param1;
        var _loc4_:* = _loc3_;
        switch (_loc4_) {
            case "left":
                this.defaultBitmap = "tab_button_left_idle";
                this.selectedBitmap = "tab_button_center_open";
                break;
            case "right":
                this.defaultBitmap = "tab_button_right_idle";
                this.selectedBitmap = "tab_button_right_open";
                break;
            case "center":
                this.defaultBitmap = "tab_button_center_idle";
                this.selectedBitmap = "tab_button_center_open";
                break;
            case "borderless":
                this.defaultBitmap = "tab_button_borderless_idle";
                this.selectedBitmap = "tab_button_borderless";
        }
        var _loc2_:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI", this.defaultBitmap);
        super(_loc2_);
        bitmap.name = "TabButton";
        _loc2_.addMargin(0, this.buttonType == "borderless" ? 0 : 3);
        _interactionEffects = false;
    }
    private var selectedBitmap:String;
    private var defaultBitmap:String;
    private var buttonType:String;
    private var indicator:Sprite;

    private var _selected:Boolean;

    public function get selected():Boolean {
        return this._selected;
    }

    public function set selected(param1:Boolean):void {
        this._selected = param1;
        if (!this._selected) {
            setLabelMargin(0, 0);
            DefaultLabelFormat.defaultInactiveTab(this.label);
            changeBitmap(this.defaultBitmap, new Point(0, this.buttonType == "borderless" ? 0 : 3));
            bitmap.alpha = 0;
        } else {
            setLabelMargin(0, this.buttonType == "borderless" ? 0 : 2);
            DefaultLabelFormat.defaultActiveTab(this.label);
            changeBitmap(this.selectedBitmap, new Point(0, this.buttonType == "borderless" ? 0 : 3));
            bitmap.alpha = 1;
        }
        this.updateIndicatorPosition();
    }

    public function get hasIndicator():Boolean {
        return this.indicator && this.indicator.parent;
    }

    public function set showIndicator(param1:Boolean):void {
        if (param1) {
            if (!this.indicator) {
                this.indicator = new Sprite();
            }
            this.indicator.graphics.clear();
            this.indicator.graphics.beginFill(823807);
            this.indicator.graphics.drawCircle(0, 0, 4);
            this.indicator.graphics.endFill();
            addChild(this.indicator);
            this.updateIndicatorPosition();
        } else if (this.indicator && this.indicator.parent) {
            removeChild(this.indicator);
        }
    }

    private function updateIndicatorPosition():void {
        if (this.indicator) {
            this.indicator.x = this.label.x + this.label.width + 7;
            this.indicator.y = this.label.y + 8;
        }
    }

    override protected function onClickHandler(param1:MouseEvent):void {
        super.onClickHandler(param1);
    }
}
}
