package io.decagames.rotmg.fame {
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.util.AssetLibrary;
import com.company.util.GraphicsUtil;

import flash.display.Bitmap;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.text.TextFormat;

import io.decagames.rotmg.ui.labels.UILabel;
import io.decagames.rotmg.utils.colors.Tint;

import kabam.rotmg.text.model.FontModel;

public class StatsLine extends Sprite {

    public static const TYPE_BONUS:int = 0;

    public static const TYPE_STAT:int = 1;

    public static const TYPE_TITLE:int = 2;

    public function StatsLine(param1:String, param2:String, param3:String, param4:int, param5:Boolean = false) {
        var _loc8_:int = 0;
        fameValue = new UILabel();
        backgroundFill_ = new GraphicsSolidFill(1973790);
        path_ = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
        super();
        var _loc7_:TextFormat = new TextFormat();
        _loc7_.color = 9079434;
        _loc7_.font = FontModel.DEFAULT_FONT_NAME;
        _loc7_.size = 13;
        _loc7_.bold = true;
        _loc7_.align = "left";
        this.isLocked = param5;
        this._lineType = param4;
        this._labelText = param1;
        if (param4 == 2) {
            _loc7_.size = 15;
            _loc7_.color = 16777215;
        }
        var _loc6_:TextFormat = new TextFormat();
        if (param4 == 0) {
            _loc6_.color = 16762880;
        } else {
            _loc6_.color = 5544494;
        }
        _loc6_.font = FontModel.DEFAULT_FONT_NAME;
        _loc6_.size = 13;
        _loc6_.bold = true;
        _loc6_.align = "left";
        this.label = new UILabel();
        this.label.defaultTextFormat = _loc7_;
        addChild(this.label);
        this.label.text = param1;
        if (!param5) {
            this.fameValue = new UILabel();
            this.fameValue.defaultTextFormat = _loc6_;
            if (param2 == "0" || param2 == "0.00%") {
                this.fameValue.defaultTextFormat = _loc7_;
            }
            if (param4 == 0) {
                this.fameValue.text = "+" + param2;
            } else {
                this.fameValue.text = param2;
            }
            this.fameValue.x = this.lineWidth - 4 - this.fameValue.textWidth;
            addChild(this.fameValue);
            this.fameValue.y = 2;
        } else {
            _loc8_ = 36;
            this.lock = new Bitmap(TextureRedrawer.resize(AssetLibrary.getImageFromSet("lofiInterface2", 5), null, _loc8_, true, 0, 0));
            Tint.add(this.lock, 9971490, 1);
            addChild(this.lock);
            this.lock.x = this.lineWidth - _loc8_ + 5;
            this.lock.y = -8;
        }
        this.setLabelsPosition();
        this._tooltipText = param3;
    }
    protected var lineHeight:int;
    protected var fameValue:UILabel;
    protected var label:UILabel;
    protected var lock:Bitmap;
    private var backgroundFill_:GraphicsSolidFill;
    private var path_:GraphicsPath;
    private var lineWidth:int = 306;
    private var isLocked:Boolean;

    private var _tooltipText:String;

    public function get tooltipText():String {
        return this._tooltipText;
    }

    private var _lineType:int;

    public function get lineType():int {
        return this._lineType;
    }

    private var _labelText:String;

    public function get labelText():String {
        return this._labelText;
    }

    public function clean():void {
        if (this.lock) {
            removeChild(this.lock);
            this.lock.bitmapData.dispose();
        }
    }

    public function drawBrightBackground():void {
        var _loc1_:Vector.<IGraphicsData> = new <IGraphicsData>[this.backgroundFill_, this.path_, GraphicsUtil.END_FILL];
        GraphicsUtil.drawCutEdgeRect(0, 0, this.lineWidth, this.lineHeight, 5, [1, 1, 1, 1], this.path_);
        graphics.drawGraphicsData(_loc1_);
    }

    protected function setLabelsPosition():void {
        this.label.y = 2;
        this.label.x = 2;
        this.lineHeight = 20;
    }
}
}
