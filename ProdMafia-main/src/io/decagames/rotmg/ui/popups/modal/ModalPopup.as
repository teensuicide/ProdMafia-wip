package io.decagames.rotmg.ui.popups.modal {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Rectangle;

import io.decagames.rotmg.ui.buttons.BaseButton;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.popups.BasePopup;
import io.decagames.rotmg.ui.popups.header.PopupHeader;
import io.decagames.rotmg.ui.scroll.UIScrollbar;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
import io.decagames.rotmg.ui.texture.TextureParser;

public class ModalPopup extends BasePopup {


    public function ModalPopup(param1:int, param2:int, param3:String = "", param4:Function = null, param5:Rectangle = null, param6:Number = 0.8, param7:Boolean = false, param8:int = 0, param9:int = 0) {
        var _loc10_:int = 0;
        super(param1 + 2 * this.contentMargin, param2 <= 2 * this.contentMargin ? 2 * this.contentMargin + 1 : Number(param2 + 2 * this.contentMargin), param5);
        this._contentWidth = param1;
        this._contentHeight = param2;
        this.buttonsList = new Vector.<BaseButton>();
        this._autoSize = param2 == 0;
        _popupFadeColor = 0;
        _popupFadeAlpha = param6;
        disablePopupBackground = param7;
        _showOnFullScreen = true;
        this.xOffset = param8;
        this.yOffset = param9;
        this.setBackground("popup_background_simple");
        this._contentContainer = new Sprite();
        this._contentContainer.x = this.contentMargin + this.xOffset;
        this._contentContainer.y = this.contentMargin + this.yOffset;
        this.contentMask = new Sprite();
        this.drawContentMask(param2);
        this._contentContainer.mask = this.contentMask;
        this.contentMask.x = this._contentContainer.x;
        this.contentMask.y = this._contentContainer.y;
        super.addChild(this.contentMask);
        super.addChild(this._contentContainer);
        if (param3 != "") {
            this._header = new PopupHeader(width, PopupHeader.TYPE_MODAL);
            this._header.x = this._header.x + this.xOffset;
            this._header.y = this._header.y + this.yOffset;
            this._header.setTitle(param3, popupWidth - 18, param4 == null ? DefaultLabelFormat.defaultModalTitle : param4);
            super.addChild(this._header);
            _loc10_ = this._header.height / 2 - 1;
            this._contentContainer.y = this._contentContainer.y + (_loc10_ + 15);
            this.contentMask.y = this.contentMask.y + (_loc10_ + 15);
            this.background.y = this.background.y + _loc10_;
            this.background.height = this.background.height + 15;
        }
    }
    protected var contentMask:Sprite;
    protected var background:SliceScalingBitmap;
    protected var contentMargin:int = 11;
    protected var maxHeight:int = 520;
    protected var scroll:UIScrollbar;
    private var buttonsList:Vector.<BaseButton>;
    private var xOffset:int;
    private var yOffset:int;

    override public function get height():Number {
        if (this._contentContainer.height > this.maxHeight) {
            return this.maxHeight + 2 * this.contentMargin + (!this.header ? 0 : Number(this._header.height / 2 + 14));
        }
        return super.height;
    }

    protected var _contentContainer:Sprite;

    public function get contentContainer():Sprite {
        return this._contentContainer;
    }

    protected var _header:PopupHeader;

    public function get header():PopupHeader {
        return this._header;
    }

    protected var _autoSize:Boolean;

    public function get autoSize():Boolean {
        return this._autoSize;
    }

    override public function addChildAt(param1:DisplayObject, param2:int):DisplayObject {
        return this._contentContainer.addChildAt(param1, param2);
    }

    override public function addChild(param1:DisplayObject):DisplayObject {
        return this._contentContainer.addChild(param1);
    }

    override public function removeChild(param1:DisplayObject):DisplayObject {
        return this._contentContainer.removeChild(param1);
    }

    override public function removeChildAt(param1:int):DisplayObject {
        return this._contentContainer.removeChildAt(param1);
    }

    public function resize():void {
        var _loc1_:int = this._contentContainer.height;
        if (_loc1_ > this.maxHeight) {
            _loc1_ = this.maxHeight;
        }
        this.drawContentMask(_loc1_);
        this.background.height = _loc1_ + 2 * this.contentMargin + (!this.header ? 0 : 15);
        if (this._contentContainer.height > this.maxHeight && !this.scroll) {
            this.scroll = new UIScrollbar(_loc1_);
            this.scroll.x = popupWidth - 18 + this.xOffset;
            this.scroll.y = this._contentContainer.y + this.yOffset;
            super.addChild(this.scroll);
            this.scroll.scrollObject = this;
            this.scroll.content = this._contentContainer;
        }
    }

    public function dispose():void {
        var _loc3_:* = null;
        if (this.background) {
            this.background.dispose();
            this.background = null;
        }
        if (this._header) {
            this._header.dispose();
        }
        var _loc1_:* = this.buttonsList;
        var _loc5_:int = 0;
        var _loc4_:* = this.buttonsList;
        for each(_loc3_ in this.buttonsList) {
            _loc3_.dispose();
        }
        this.buttonsList = null;
    }

    protected function registerButton(param1:BaseButton):void {
        this.buttonsList.push(param1);
    }

    private function drawContentMask(param1:int):void {
        this.contentMask.graphics.clear();
        this.contentMask.graphics.beginFill(16711680, 0.2);
        this.contentMask.graphics.drawRect(0, 0, _contentWidth, param1);
        this.contentMask.graphics.endFill();
    }

    private function setBackground(param1:String):void {
        this.background = TextureParser.instance.getSliceScalingBitmap("UI", param1);
        this.background.width = popupWidth;
        this.background.height = popupHeight;
        this.background.x = this.xOffset;
        this.background.y = this.yOffset;
        super.addChildAt(this.background, 0);
    }
}
}
