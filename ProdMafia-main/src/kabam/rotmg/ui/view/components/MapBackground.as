package kabam.rotmg.ui.view.components {
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.map.serialization.MapDecoder;
import com.company.util.IntPoint;

import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.getTimer;

public class MapBackground extends Sprite {

    private static const BORDER:int = 10;

    private static const RECTANGLE:Rectangle = new Rectangle(-400, -300, 800, 10 * 60);

    private static const ANGLE:Number = 5.49778714378214;

    private static const TO_MILLISECONDS:Number = 0.001;

    private static const EMBEDDED_BACKGROUNDMAP:Class = MapBackground_EMBEDDED_BACKGROUNDMAP;

    private static var backgroundMap:Map;

    private static var mapSize:IntPoint;

    private static var xVal:Number;

    private static var yVal:Number;

    private static var camera:Camera;

    public function MapBackground() {
        super();
        addEventListener("addedToStage", this.onAddedToStage);
        addEventListener("removedFromStage", this.onRemovedFromStage);
    }
    private var lastUpdate:int;
    private var time:Number;

    private function makeMap():Map {
        var _local3:ByteArray = new EMBEDDED_BACKGROUNDMAP();
        var _local2:String = _local3.readUTFBytes(_local3.length);
        mapSize = MapDecoder.getSize(_local2);
        xVal = 10;
        yVal = 10 + int((mapSize.y_ - 20) * Math.random());
        camera = new Camera();
        var _local1:Map = new Map(null);
        _local1.setProps(mapSize.x_ + 20, mapSize.y_, "Background Map", 1, false, false);
        _local1.initialize();
        MapDecoder.writeMap(_local2, _local1, 0, 0);
        MapDecoder.writeMap(_local2, _local1, mapSize.x_, 0);
        return _local1;
    }

    private function onAddedToStage(_arg_1:Event):void {
        backgroundMap = backgroundMap || this.makeMap();
        addChildAt(backgroundMap || this.makeMap(), 0);
        addEventListener("enterFrame", this.onEnterFrame);
        this.lastUpdate = getTimer();
    }

    private function onRemovedFromStage(_arg_1:Event):void {
        removeEventListener("enterFrame", this.onEnterFrame);
    }

    private function onEnterFrame(_arg_1:Event):void {
        this.time = getTimer();
        xVal = xVal + (this.time - this.lastUpdate) * 0.001;
        if (xVal > mapSize.x_ + 10) {
            xVal = xVal - mapSize.x_;
        }
        camera.configure(xVal, yVal, 12, 5.49778714378214, RECTANGLE);
        backgroundMap.draw(camera, this.time);
        this.lastUpdate = this.time;
    }
}
}
