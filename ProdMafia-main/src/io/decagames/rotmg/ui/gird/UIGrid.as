package io.decagames.rotmg.ui.gird {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class UIGrid extends Sprite {


    public function UIGrid(param1:int, param2:int, param3:int, param4:int = -1, param5:int = 0, param6:DisplayObject = null) {
        super();
        this.elements = new Vector.<UIGridElement>();
        this.decors = new Vector.<SliceScalingBitmap>();
        this.gridMargin = param3;
        this.gridWidth = param1;
        this.gridContent = new Sprite();
        this.addChild(this.gridContent);
        this.scrollHeight = param4;
        if (param4 > 0) {
            this.scroll = new UIScrollbar(param4);
            this.scroll.x = param1 + param5;
            addChild(this.scroll);
            this.scroll.content = this.gridContent;
            this.scroll.scrollObject = param6;
            this.gridMask = new Sprite();
        }
        this.numberOfColumns = param2;
        this.addEventListener("addedToStage", this.onAddedHandler);
    }
    private var elements:Vector.<UIGridElement>;
    private var decors:Vector.<SliceScalingBitmap>;
    private var gridMargin:int;
    private var gridWidth:int;
    private var numberOfColumns:int;
    private var scrollHeight:int;
    private var scroll:UIScrollbar;
    private var gridContent:Sprite;
    private var gridMask:Sprite;
    private var lastRenderedItemsNumber:int = 0;
    private var elementWidth:int;

    override public function set width(param1:Number):void {
        this.gridWidth = param1;
        this.render();
    }

    private var _centerLastRow:Boolean;

    public function get centerLastRow():Boolean {
        return this._centerLastRow;
    }

    public function set centerLastRow(param1:Boolean):void {
        this._centerLastRow = param1;
    }

    private var _decorBitmap:String = "";

    public function get decorBitmap():String {
        return this._decorBitmap;
    }

    public function set decorBitmap(param1:String):void {
        this._decorBitmap = param1;
    }

    public function get numberOfElements():int {
        return this.elements.length;
    }

    public function addGridElement(param1:UIGridElement):void {
        if (this.elements) {
            this.elements.push(param1);
            this.gridContent.addChild(param1);
            if (this.stage) {
                this.render();
            }
        }
    }

    public function clearGrid():void {
        var _loc3_:* = null;
        var _loc1_:* = null;
        var _loc2_:* = this.elements;
        var _loc8_:int = 0;
        var _loc7_:* = this.elements;
        for each(_loc3_ in this.elements) {
            this.gridContent.removeChild(_loc3_);
            _loc3_.dispose();
        }
        var _loc6_:* = this.decors;
        var _loc10_:int = 0;
        var _loc9_:* = this.decors;
        for each(_loc1_ in this.decors) {
            this.gridContent.removeChild(_loc1_);
            _loc1_.dispose();
        }
        if (this.elements) {
            this.elements.length = 0;
        }
        if (this.decors) {
            this.decors.length = 0;
        }
        this.lastRenderedItemsNumber = 0;
    }

    public function render():void {
        var _loc9_:int = 0;
        var _loc1_:int = 0;
        var _loc4_:int = 0;
        var _loc3_:int = 0;
        var _loc10_:* = 0;
        var _loc6_:* = null;
        if (this.lastRenderedItemsNumber == this.elements.length) {
            return;
        }
        this.elementWidth = (this.gridWidth - (this.numberOfColumns - 1) * this.gridMargin) / this.numberOfColumns;
        var _loc8_:int = 1;
        var _loc7_:int = Math.ceil(this.elements.length / this.numberOfColumns);
        var _loc11_:int = 1;
        var _loc2_:* = this.elements;
        var _loc13_:int = 0;
        var _loc12_:* = this.elements;
        for each(_loc6_ in this.elements) {
            _loc6_.resize(this.elementWidth);
            if (_loc6_.height > _loc3_) {
                _loc3_ = _loc6_.height;
            }
            _loc6_.x = _loc1_;
            _loc6_.y = _loc4_;
            _loc8_++;
            if (_loc8_ > this.numberOfColumns) {
                if (this._decorBitmap != "") {
                    _loc10_ = _loc11_;
                    this.addDecorToRow(_loc4_, _loc3_, _loc8_ - 1);
                }
                _loc11_++;
                _loc1_ = 0;
                if (_loc11_ == _loc7_ && this._centerLastRow) {
                    _loc9_ = _loc11_ * this.numberOfColumns - this.elements.length;
                    _loc1_ = Math.round((_loc9_ * this.elementWidth + (_loc9_ - 1) * this.gridMargin) / 2);
                }
                _loc4_ = _loc4_ + (_loc3_ + this.gridMargin);
                _loc3_ = 0;
                _loc8_ = 1;
            } else {
                _loc1_ = _loc1_ + (this.elementWidth + this.gridMargin);
            }
        }
        if (this._decorBitmap != "" && _loc10_ != _loc11_) {
            this.addDecorToRow(_loc4_, _loc3_, _loc8_ - 1);
        }
        if (this.scrollHeight != -1) {
            this.gridMask.graphics.clear();
            this.gridMask.graphics.beginFill(16711680);
            this.gridMask.graphics.drawRect(0, 0, this.gridWidth, this.scrollHeight);
            this.gridContent.mask = this.gridMask;
            addChild(this.gridMask);
        }
        this.lastRenderedItemsNumber = this.elements.length;
    }

    public function dispose():void {
        var _loc3_:* = null;
        var _loc1_:* = null;
        this.removeEventListener("enterFrame", this.onUpdate);
        var _loc2_:* = this.elements;
        var _loc8_:int = 0;
        var _loc7_:* = this.elements;
        for each(_loc3_ in this.elements) {
            _loc3_.dispose();
        }
        var _loc6_:* = this.decors;
        var _loc10_:int = 0;
        var _loc9_:* = this.decors;
        for each(_loc1_ in this.decors) {
            _loc1_.dispose();
        }
        this.elements = null;
    }

    private function addDecorToRow(param1:int, param2:int, param3:int):void {
        var _loc4_:* = null;
        var _loc5_:int = 0;
        param3--;
        if (param3 == 0) {
            param3 = 1;
        }
        while (_loc5_ < param3) {
            _loc4_ = TextureParser.instance.getSliceScalingBitmap("UI", this._decorBitmap);
            _loc4_.x = Math.round(_loc5_ * (this.gridMargin / 2) + (_loc5_ + 1) * (this.elementWidth + this.gridMargin / 2) - _loc4_.width / 2);
            _loc4_.y = Math.round(param1 + param2 - _loc4_.height / 2 + this.gridMargin / 2);
            this.gridContent.addChild(_loc4_);
            this.decors.push(_loc4_);
            _loc5_++;
        }
    }

    private function onAddedHandler(param1:Event):void {
        this.removeEventListener("addedToStage", this.onAddedHandler);
        this.addEventListener("enterFrame", this.onUpdate);
        this.render();
    }

    private function onUpdate(param1:Event):void {
        var _loc2_:* = null;
        var _loc3_:* = this.elements;
        var _loc6_:int = 0;
        var _loc5_:* = this.elements;
        for each(_loc2_ in this.elements) {
            _loc2_.update();
        }
    }
}
}
