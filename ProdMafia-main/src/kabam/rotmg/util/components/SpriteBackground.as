package kabam.rotmg.util.components {
import com.company.util.GraphicsUtil;
import com.company.util.MoreColorUtil;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.GraphicsPath;
import flash.display.GraphicsSolidFill;
import flash.display.IGraphicsData;
import flash.display.Sprite;
import flash.filters.ColorMatrixFilter;

import kabam.rotmg.assets.services.IconFactory;
import kabam.rotmg.text.view.TextFieldDisplayConcrete;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;
import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;
import kabam.rotmg.ui.view.SignalWaiter;

public class SpriteBackground extends Sprite {

    private static const BEVEL:int = 4;

    private static const PADDING:int = 2;

    public static const coin:BitmapData = IconFactory.makeCoin();

    public static const fame:BitmapData = IconFactory.makeFame();

    public static const guildFame:BitmapData = IconFactory.makeGuildFame();

    private static const grayfilter:ColorMatrixFilter = new ColorMatrixFilter(MoreColorUtil.greyscaleFilterMatrix);


    private const enabledFill:GraphicsSolidFill = new GraphicsSolidFill(0xffffff, 1);

    private const disabledFill:GraphicsSolidFill = new GraphicsSolidFill(0x7f7f7f, 1);

    private const graphicsPath:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());

    private const waiter:SignalWaiter = new SignalWaiter();

    public function SpriteBackground(_arg_1:Number, _arg_2:Number) {
        staticStringBuilder = new StaticStringBuilder("");
        lineBuilder = new LineBuilder();
        graphicsData = new <IGraphicsData>[enabledFill, graphicsPath, GraphicsUtil.END_FILL];
        super();
        this.prefix = "   ";
        this.sizeX = _arg_1;
        this.sizeY = _arg_2;
        this.price = 1;
        this.currency = 0;
        this.text = new TextFieldDisplayConcrete().setSize(_arg_1).setColor(0x363636).setBold(true);
        this.waiter.push(this.text.textChanged);
        var _local3:StringBuilder = this.prefix != "" ? this.lineBuilder.setParams(this.prefix, {"cost": this.price.toString()}) : this.staticStringBuilder.setString(this.price.toString());
        this.text.setStringBuilder(_local3);
        this.waiter.complete.add(this.updateUI);
        addChild(this.text);
    }
    public var prefix:String;
    public var text:TextFieldDisplayConcrete;
    public var icon:Bitmap;
    public var price:int = -1;
    public var currency:int = -1;
    public var _width:int = -1;
    private var staticStringBuilder:StaticStringBuilder;
    private var lineBuilder:LineBuilder;
    private var graphicsData:Vector.<IGraphicsData>;
    private var sizeX:Number = 100;
    private var sizeY:Number = 100;

    public function setEnabled(_arg_1:Boolean):void {
        if (_arg_1 != mouseEnabled) {
            mouseEnabled = _arg_1;
            filters = !!_arg_1 ? [] : [grayfilter];
            this.draw();
        }
    }

    private function updateUI():void {
        this.updateBackground();
        this.draw();
    }

    private function updateBackground():void {
        GraphicsUtil.clearPath(this.graphicsPath);
        GraphicsUtil.drawCutEdgeRect(0, 0, this.getWidth(), this.getHeight(), 4, [1, 1, 1, 1], this.graphicsPath);
    }

    private function draw():void {
        this.graphicsData[0] = !!mouseEnabled ? this.enabledFill : this.disabledFill;
        graphics.clear();
        graphics.drawGraphicsData(this.graphicsData);
    }

    private function getWidth():int {
        return this.sizeX;
    }

    private function getHeight():int {
        return this.sizeY;
    }
}
}
