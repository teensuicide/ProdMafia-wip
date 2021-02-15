package com.company.assembleegameclient.map.serialization {
import com.company.assembleegameclient.map.GroundLibrary;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.BasicObject;
import com.company.assembleegameclient.objects.GameObject;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.util.IntPoint;
import com.hurlant.util.Base64;

import flash.utils.ByteArray;

import kabam.lib.json.JsonParser;
import kabam.rotmg.core.StaticInjectorContext;

public class MapDecoder {


    private static function get json():JsonParser {
        return StaticInjectorContext.getInjector().getInstance(JsonParser);
    }

    public static function decodeMap(_arg_1:String):Map {
        var _local2:Object = json.parse(_arg_1);
        var _local3:Map = new Map(null);
        _local3.setProps(_local2["width"], _local2["height"], _local2["name"], _local2["back"], false, false);
        _local3.initialize();
        writeMapInternal(_local2, _local3, 0, 0);
        return _local3;
    }

    public static function writeMap(_arg_1:String, _arg_2:Map, _arg_3:int, _arg_4:int):void {
        var _local5:Object = json.parse(_arg_1);
        writeMapInternal(_local5, _arg_2, _arg_3, _arg_4);
    }

    public static function getSize(_arg_1:String):IntPoint {
        var _local2:Object = json.parse(_arg_1);
        return new IntPoint(_local2["width"], _local2["height"]);
    }

    public static function getGameObject(_arg_1:Object):GameObject {
        var _local2:int = ObjectLibrary.idToType_[_arg_1["id"]];
        var _local4:XML = ObjectLibrary.xmlLibrary_[_local2];
        var _local3:GameObject = ObjectLibrary.getObjectFromType(_local2);
        _local3.size_ = "size" in _arg_1 ? _arg_1["size"] : _local3.props_.getSize();
        return _local3;
    }

    private static function writeMapInternal(_arg_1:Object, _arg_2:Map, _arg_3:int, _arg_4:int):void {
        var _local6:* = 0;
        var _local5:* = 0;
        var _local8:* = null;
        var _local7:* = null;
        var _local15:int = 0;
        var _local12:* = null;
        var _local14:* = null;
        var _local13:ByteArray = Base64.decodeToByteArray(_arg_1["data"]);
        _local13.uncompress();
        var _local11:Array = _arg_1["dict"];
        _local6 = _arg_4;
        var _local9:uint = _arg_4 + _arg_1["height"];
        var _local10:uint = _arg_3 + _arg_1["width"];
        while (_local6 < _local9) {
            _local5 = _arg_3;
            while (_local5 < _local10) {
                _local8 = _local11[_local13.readShort()];
                if (!(_local5 < 0 || _local5 >= _arg_2.mapWidth || _local6 < 0 || _local6 >= _arg_2.mapHeight)) {
                    if ("ground" in _local8) {
                        _local15 = GroundLibrary.idToType_[_local8["ground"]];
                        _arg_2.setGroundTile(_local5, _local6, _local15);
                    }
                    _local7 = _local8["objs"];
                    if (_local7) {
                        var _local17:int = 0;
                        var _local16:* = _local7;
                        for each(_local12 in _local7) {
                            _local14 = getGameObject(_local12);
                            _local14.objectId_ = BasicObject.getNextFakeObjectId();
                            _arg_2.addObj(_local14, _local5 + 0.5, _local6 + 0.5);
                        }
                    }
                }
                _local5++;
            }
            _local6++;
        }
    }

    public function MapDecoder() {
        super();
    }
}
}
