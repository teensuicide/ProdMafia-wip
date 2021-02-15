package io.decagames.rotmg.ui.tabs {
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Point;

import io.decagames.rotmg.social.signals.TabSelectedSignal;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;

import org.osflash.signals.Signal;

public class UITabs extends Sprite {


    public function UITabs(param1:int, param2:Boolean = false) {
        buttonsRenderedSignal = new Signal();
        tabSelectedSignal = new TabSelectedSignal();
        super();
        this.tabsWidth = param1;
        this.borderlessMode = param2;
        this.addEventListener("addedToStage", this.onAddedHandler);
        this.content = new Vector.<UITab>(0);
        this.buttons = new Vector.<TabButton>(0);
        if (!param2) {
            this.background = new TabContentBackground();
            this.background.addMargin(0, 3);
            this.background.width = param1;
            this.background.height = 405;
            this.background.x = 0;
            this.background.y = 41;
            addChild(this.background);
        } else {
            this.tabsButtonMargin = 3;
        }
    }
    public var buttonsRenderedSignal:Signal;
    public var tabSelectedSignal:TabSelectedSignal;
    private var tabsXSpace:int = 3;
    private var tabsButtonMargin:int = 14;
    private var content:Vector.<UITab>;
    private var buttons:Vector.<TabButton>;
    private var tabsWidth:int;
    private var background:TabContentBackground;
    private var currentContent:UITab;
    private var defaultSelectedIndex:int = 0;
    private var borderlessMode:Boolean;

    private var _currentTabLabel:String;

    public function get currentTabLabel():String {
        return this._currentTabLabel;
    }

    public function addTab(param1:UITab, param2:Boolean = false):void {
        this.content.push(param1);
        param1.y = !!this.borderlessMode ? 34 : 56;
        if (param2) {
            this.defaultSelectedIndex = this.content.length - 1;
            this.currentContent = param1;
            this._currentTabLabel = param1.tabName;
            addChild(param1);
        }
        if (this._currentTabLabel == "") {
            this._currentTabLabel = param1.tabName;
        }
    }

    public function getTabButtonByLabel(param1:String):TabButton {
        var _loc2_:* = null;
        var _loc3_:* = this.buttons;
        var _loc6_:int = 0;
        var _loc5_:* = this.buttons;
        for each(_loc2_ in this.buttons) {
            if (_loc2_.label.text == param1) {
                return _loc2_;
            }
        }
        return null;
    }

    public function dispose():void {
        var _loc3_:* = null;
        var _loc1_:* = null;
        if (this.background) {
            this.background.dispose();
        }
        var _loc2_:* = this.buttons;
        var _loc8_:int = 0;
        var _loc7_:* = this.buttons;
        for each(_loc3_ in this.buttons) {
            _loc3_.dispose();
        }
        var _loc6_:* = this.content;
        var _loc10_:int = 0;
        var _loc9_:* = this.content;
        for each(_loc1_ in this.content) {
            _loc1_.dispose();
        }
        this.currentContent.dispose();
        this.content = null;
        this.buttons = null;
    }

    private function createTabButtons():void {
        var _loc5_:int = 0;
        var _loc1_:int = 0;
        var _loc3_:* = null;
        var _loc7_:* = null;
        var _loc2_:* = null;
        var _loc8_:* = null;
        _loc5_ = 1;
        _loc1_ = (this.tabsWidth - (this.content.length - 1) * this.tabsXSpace - this.tabsButtonMargin * 2) / this.content.length;
        var _loc6_:* = this.content;
        var _loc10_:int = 0;
        var _loc9_:* = this.content;
        for each(_loc2_ in this.content) {
            if (_loc5_ == 1) {
                _loc3_ = "left";
            } else if (_loc5_ == this.content.length) {
                _loc3_ = "right";
            } else {
                _loc3_ = "center";
            }
            _loc8_ = this.createTabButton(_loc2_.tabName, _loc3_);
            _loc8_.width = _loc1_;
            _loc8_.selected = this.defaultSelectedIndex == _loc5_ - 1;
            if (_loc8_.selected) {
                _loc7_ = _loc8_;
            }
            _loc8_.y = 3;
            _loc8_.x = this.tabsButtonMargin + _loc1_ * (_loc5_ - 1) + this.tabsXSpace * (_loc5_ - 1);
            addChild(_loc8_);
            _loc8_.clickSignal.add(this.onButtonSelected);
            this.buttons.push(_loc8_);
            _loc5_++;
        }
        if (this.background) {
            this.background.addDecor(_loc7_.x - 4, _loc7_.x + _loc7_.width - 12, this.defaultSelectedIndex, this.buttons.length);
        }
        this.onButtonSelected(_loc7_);
        this.buttonsRenderedSignal.dispatch();
    }

    private function onButtonSelected(param1:TabButton):void {
        var _loc3_:* = null;
        var _loc2_:int = this.buttons.indexOf(param1);
        param1.y = 0;
        this._currentTabLabel = param1.label.text;
        this.tabSelectedSignal.dispatch(param1.label.text);
        var _loc4_:* = this.buttons;
        var _loc7_:int = 0;
        var _loc6_:* = this.buttons;
        for each(_loc3_ in this.buttons) {
            if (_loc3_ != param1) {
                _loc3_.selected = false;
                _loc3_.y = 3;
                this.updateTabButtonGraphicState(_loc3_, _loc2_);
            } else {
                _loc3_.selected = true;
            }
        }
        if (this.currentContent) {
            this.currentContent.displaySignal.dispatch(false);
            this.currentContent.alpha = 0;
            this.currentContent.mouseChildren = false;
            this.currentContent.mouseEnabled = false;
        }
        this.currentContent = this.content[_loc2_];
        if (this.background) {
            this.background.addDecor(param1.x - 5, param1.x + param1.width - 12, _loc2_, this.buttons.length);
        }
        addChild(this.currentContent);
        this.currentContent.displaySignal.dispatch(true);
        this.currentContent.alpha = 1;
        this.currentContent.mouseChildren = true;
        this.currentContent.mouseEnabled = true;
    }

    private function updateTabButtonGraphicState(param1:TabButton, param2:int):void {
        var _loc3_:int = this.buttons.indexOf(param1);
        if (this.borderlessMode) {
            param1.changeBitmap("tab_button_borderless_idle", new Point(0, !!this.borderlessMode ? 0 : 3));
            param1.bitmap.alpha = 0;
        } else if (_loc3_ > param2) {
            param1.changeBitmap("tab_button_right_idle", new Point(0, !!this.borderlessMode ? 0 : 3));
        } else {
            param1.changeBitmap("tab_button_left_idle", new Point(0, !!this.borderlessMode ? 0 : 3));
        }
    }

    private function createTabButton(param1:String, param2:String):TabButton {
        var _loc3_:TabButton = new TabButton(!!this.borderlessMode ? "borderless" : param2);
        _loc3_.setLabel(param1, DefaultLabelFormat.defaultInactiveTab);
        return _loc3_;
    }

    private function onAddedHandler(param1:Event):void {
        this.removeEventListener("addedToStage", this.onAddedHandler);
        this.createTabButtons();
    }
}
}
