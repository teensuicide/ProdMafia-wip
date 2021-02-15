package io.decagames.rotmg.ui.texture {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import io.decagames.rotmg.ui.assets.UIAssets;
import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;

public class TextureParser {

    private static var _instance:TextureParser;

    public static function get instance():TextureParser {
        if (_instance == null) {
            _instance = new TextureParser();
        }
        return _instance;
    }

    public function TextureParser() {
        super();
        this.textures = new Dictionary();
        this.json = StaticInjectorContext.getInjector().getInstance(JsonParser);
        this.registerTexture(new UIAssets.UI(), new UIAssets.UI_CONFIG(), new UIAssets.UI_SLICE_CONFIG(), "UI");
    }
    private var textures:Dictionary;
    private var json:JsonParser;

    public function registerTexture(param1:Bitmap, param2:String, param3:String, param4:String):void {
        this.textures[param4] = {
            "texture": param1,
            "configuration": this.json.parse(param2),
            "sliceRectangles": this.json.parse(param3)
        };
    }

    public function getTexture(param1:String, param2:String):Bitmap {
        var _loc3_:Object = this.getConfiguration(param1, param2);
        return this.getBitmapUsingConfig(param1, _loc3_);
    }

    public function getSliceScalingBitmap(param1:String, param2:String, param3:int = 0):SliceScalingBitmap {
        var _loc5_:* = null;
        var _loc7_:Bitmap = this.getTexture(param1, param2);
        var _loc4_:Object = this.textures[param1].sliceRectangles.slices[param2 + ".png"];
        var _loc8_:String = SliceScalingBitmap.SCALE_TYPE_NONE;
        if (_loc4_) {
            _loc5_ = new Rectangle(_loc4_.rectangle.x, _loc4_.rectangle.y, _loc4_.rectangle.w, _loc4_.rectangle.h);
            _loc8_ = _loc4_.type;
        }
        var _loc6_:SliceScalingBitmap = new SliceScalingBitmap(_loc7_.bitmapData, _loc8_, _loc5_);
        _loc6_.sourceBitmapName = param2;
        if (param3 != 0) {
            _loc6_.width = param3;
        }
        return _loc6_;
    }

    private function getConfiguration(param1:String, param2:String):Object {
        if (!this.textures[param1]) {
            throw new Error("Can\'t find set name " + param1);
        }
        if (!this.textures[param1].configuration.frames[param2 + ".png"]) {
            throw new Error("Can\'t find config for " + param2);
        }
        return this.textures[param1].configuration.frames[param2 + ".png"];
    }

    private function getBitmapUsingConfig(param1:String, param2:Object):Bitmap {
        var _loc5_:Bitmap = this.textures[param1].texture;
        var _loc4_:ByteArray = _loc5_.bitmapData.getPixels(new Rectangle(param2.frame.x, param2.frame.y, param2.frame.w, param2.frame.h));
        _loc4_.position = 0;
        var _loc3_:BitmapData = new BitmapData(param2.frame.w, param2.frame.h);
        _loc3_.setPixels(new Rectangle(0, 0, param2.frame.w, param2.frame.h), _loc4_);
        return new Bitmap(_loc3_);
    }
}
}
