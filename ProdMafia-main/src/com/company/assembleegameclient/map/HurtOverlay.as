package com.company.assembleegameclient.map {
import com.company.assembleegameclient.game.AGameSprite;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.util.GraphicsUtil;

import flash.display.GraphicsGradientFill;
import flash.display.GraphicsPath;
import flash.display.IGraphicsData;
import flash.display.Shape;

public class HurtOverlay extends Shape {


    private const s:Number = 600 / Math.sin(0.785398163397448);

    public function HurtOverlay(_arg_1:AGameSprite = null) {
        gradientFill_ = new GraphicsGradientFill("radial", [0xffffff, 0xffffff, 0xffffff], [0, 0, 0.92], [0, 155, 255], GraphicsUtil.getGradientMatrix(s, s, 0, (600 - s) * 0.5, (600 - s) * 0.5));
        gradientPath_ = GraphicsUtil.getRectPath(0, 0, 10 * 60, 10 * 60);
        gradientGraphicsData_ = new <IGraphicsData>[gradientFill_, gradientPath_, GraphicsUtil.END_FILL];
        super();
        var _local7:Number = Parameters.data.mscale;
        var _local8:Number = WebMain.STAGE.stageWidth / _local7;
        var _local3:Number = WebMain.STAGE.stageHeight / _local7;
        var _local2:* = 200;
        if (_arg_1 && _arg_1.hudView) {
            _local2 = Number(_local8 * (1 - _arg_1.hudView.x * 0.00125));
        }
        var _local6:Number = _local8 - _local2;
        _local2 = Number(Math.sin(0.785398163397448));
        var _local5:Number = _local6 / _local2;
        var _local4:Number = _local3 / _local2;
        this.gradientFill_ = new GraphicsGradientFill("radial", [0xffffff, 0xffffff, 0xffffff], [0, 0, 0.92], [0, 155, 255], GraphicsUtil.getGradientMatrix(_local5, _local4, 0, (_local6 - _local5) * 0.5, (_local3 - _local4) * 0.5));
        this.gradientPath_ = GraphicsUtil.getRectPath(0, 0, _local8, _local3);
        this.gradientGraphicsData_ = new <IGraphicsData>[gradientFill_, gradientPath_, GraphicsUtil.END_FILL];
        graphics.drawGraphicsData(this.gradientGraphicsData_);
        visible = false;
    }
    private var gradientFill_:GraphicsGradientFill;
    private var gradientPath_:GraphicsPath;
    private var gradientGraphicsData_:Vector.<IGraphicsData>;
}
}
