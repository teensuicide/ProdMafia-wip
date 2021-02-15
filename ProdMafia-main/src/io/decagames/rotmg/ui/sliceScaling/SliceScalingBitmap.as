package io.decagames.rotmg.ui.sliceScaling {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class SliceScalingBitmap extends Bitmap {

    public static var SCALE_TYPE_NONE:String = "none";

    public static var SCALE_TYPE_3:String = "3grid";

    public static var SCALE_TYPE_9:String = "9grid";

    public function SliceScalingBitmap(param1:BitmapData, param2:String, param3:Rectangle = null, param4:uint = 0, param5:Number = 1) {
        margin = new Point();
        super();
        this.bitmapDataToSlice = param1;
        this.scaleGrid = param3;
        this.currentWidth = param1.width;
        this.currentHeight = param1.height;
        this._scaleType = param2;
        this.fillColor = param4;
        this.fillColorAlpha = param5;
        if (param2 != SCALE_TYPE_NONE) {
            this.render();
        } else {
            this.bitmapData = param1;
        }
    }
    protected var margin:Point;
    private var scaleGrid:Rectangle;
    private var currentWidth:int;
    private var currentHeight:int;
    private var bitmapDataToSlice:BitmapData;
    private var fillColor:uint;
    private var fillColorAlpha:Number;

    override public function get width():Number {
        return this.currentWidth;
    }

    override public function set width(param1:Number):void {
        if (param1 != this.currentWidth || this._forceRenderInNextFrame) {
            this.currentWidth = param1;
            this.render();
        }
    }

    override public function get height():Number {
        return this.currentHeight;
    }

    override public function set height(param1:Number):void {
        if (param1 != this.currentHeight) {
            this.currentHeight = param1;
            this.render();
        }
    }

    override public function set x(param1:Number):void {
        super.x = Math.round(param1);
    }

    override public function set y(param1:Number):void {
        super.y = Math.round(param1);
    }

    private var _scaleType:String;

    public function get scaleType():String {
        return this._scaleType;
    }

    public function set scaleType(param1:String):void {
        this._scaleType = param1;
    }

    private var _forceRenderInNextFrame:Boolean;

    public function get forceRenderInNextFrame():Boolean {
        return this._forceRenderInNextFrame;
    }

    public function set forceRenderInNextFrame(param1:Boolean):void {
        this._forceRenderInNextFrame = param1;
    }

    private var _sourceBitmapName:String;

    public function get sourceBitmapName():String {
        return this._sourceBitmapName;
    }

    public function set sourceBitmapName(param1:String):void {
        this._sourceBitmapName = param1;
    }

    public function get marginX():int {
        return this.margin.x;
    }

    public function get marginY():int {
        return this.margin.y;
    }

    public function clone():SliceScalingBitmap {
        var _loc1_:SliceScalingBitmap = new SliceScalingBitmap(this.bitmapDataToSlice.clone(), this.scaleType, this.scaleGrid, this.fillColor, this.fillColorAlpha);
        _loc1_.sourceBitmapName = this._sourceBitmapName;
        return _loc1_;
    }

    public function addMargin(param1:int, param2:int):void {
        this.margin = new Point(param1, param2);
    }

    public function dispose():void {
        this.bitmapData.dispose();
        this.bitmapDataToSlice.dispose();
    }

    protected function render():void {
        if (this._scaleType == SCALE_TYPE_NONE) {
            return;
        }
        if (this.bitmapData) {
            this.bitmapData.dispose();
        }
        if (this._scaleType == SCALE_TYPE_3) {
            this.prepare3grid();
        }
        if (this._scaleType == SCALE_TYPE_9) {
            this.prepare9grid();
        }
        if (this._forceRenderInNextFrame) {
            this._forceRenderInNextFrame = false;
        }
    }

    private function prepare3grid():void {
        var _loc4_:int = 0;
        var _loc1_:int = 0;
        var _loc3_:int = 0;
        var _loc2_:int = 0;
        if (this.scaleGrid.y == 0) {
            _loc4_ = this.currentWidth - this.bitmapDataToSlice.width + this.scaleGrid.width;
            this.bitmapData = new BitmapData(this.currentWidth + this.margin.x, this.currentHeight + this.margin.y, true, 0);
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.scaleGrid.x, this.bitmapDataToSlice.height), new Point(this.margin.x, this.margin.y));
            _loc1_ = 0;
            while (_loc1_ < _loc4_) {
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(this.scaleGrid.x, 0, this.scaleGrid.width, this.bitmapDataToSlice.height), new Point(this.scaleGrid.x + _loc1_ + this.margin.x, this.margin.y));
                _loc1_++;
            }
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(this.scaleGrid.x + this.scaleGrid.width, 0, this.bitmapDataToSlice.width - (this.scaleGrid.x + this.scaleGrid.width), this.bitmapDataToSlice.height), new Point(this.scaleGrid.x + _loc4_ + this.margin.x, this.margin.y));
        } else {
            _loc3_ = this.currentHeight - this.bitmapDataToSlice.height + this.scaleGrid.height;
            this.bitmapData = new BitmapData(this.currentWidth + this.margin.x, this.currentHeight + this.margin.y, true, 0);
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, 0, this.bitmapDataToSlice.width, this.scaleGrid.y), new Point(this.margin.x, this.margin.y));
            _loc2_ = 0;
            while (_loc2_ < _loc3_) {
                this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, this.scaleGrid.y, this.scaleGrid.width, this.bitmapDataToSlice.height), new Point(this.margin.x, this.margin.y + this.scaleGrid.y + _loc2_));
                _loc2_++;
            }
            this.bitmapData.copyPixels(this.bitmapDataToSlice, new Rectangle(0, this.scaleGrid.y + this.scaleGrid.height, this.bitmapDataToSlice.width, this.bitmapDataToSlice.height - (this.scaleGrid.y + this.scaleGrid.height)), new Point(this.margin.x, this.margin.y + this.scaleGrid.y + _loc3_));
        }
    }

    private function prepare9grid():void {
        var _loc6_:int = 0;
        var _loc4_:int = 0;
        var _loc8_:Rectangle = new Rectangle();
        var _loc3_:Rectangle = new Rectangle();
        var _loc1_:Matrix = new Matrix();
        var _loc9_:BitmapData = new BitmapData(this.currentWidth + this.margin.x, this.currentHeight + this.margin.y, true, 0);
        var _loc2_:Array = [0, this.scaleGrid.top, this.scaleGrid.bottom, this.bitmapDataToSlice.height];
        var _loc7_:Array = [0, this.scaleGrid.left, this.scaleGrid.right, this.bitmapDataToSlice.width];
        var _loc10_:Array = [0, this.scaleGrid.top, this.currentHeight - (this.bitmapDataToSlice.height - this.scaleGrid.bottom), this.currentHeight];
        var _loc5_:Array = [0, this.scaleGrid.left, this.currentWidth - (this.bitmapDataToSlice.width - this.scaleGrid.right), this.currentWidth];
        while (_loc4_ < 3) {
            _loc6_ = 0;
            while (_loc6_ < 3) {
                _loc8_.setTo(_loc7_[_loc4_], _loc2_[_loc6_], _loc7_[_loc4_ + 1] - _loc7_[_loc4_], _loc2_[_loc6_ + 1] - _loc2_[_loc6_]);
                _loc3_.setTo(_loc5_[_loc4_], _loc10_[_loc6_], _loc5_[_loc4_ + 1] - _loc5_[_loc4_], _loc10_[_loc6_ + 1] - _loc10_[_loc6_]);
                _loc1_.identity();
                _loc1_.a = _loc3_.width / _loc8_.width;
                _loc1_.d = _loc3_.height / _loc8_.height;
                _loc1_.tx = _loc3_.x - _loc8_.x * _loc1_.a;
                _loc1_.ty = _loc3_.y - _loc8_.y * _loc1_.d;
                _loc9_.draw(this.bitmapDataToSlice, _loc1_, null, null, _loc3_);
                _loc6_++;
            }
            _loc4_++;
        }
        this.bitmapData = _loc9_;
    }
}
}
