package com.company.assembleegameclient.appengine {
import flash.display.BitmapData;
import flash.utils.ByteArray;

import ion.utils.png.PNGDecoder;

import kabam.rotmg.appengine.api.RetryLoader;
import kabam.rotmg.appengine.impl.AppEngineRetryLoader;
import kabam.rotmg.core.StaticInjectorContext;

import org.swiftsuspenders.Injector;

import robotlegs.bender.framework.api.ILogger;

public class RemoteTexture {

    private static const URL_PATTERN:String = "https://{DOMAIN}/picture/get";

    private static const ERROR_PATTERN:String = "Remote Texture Error: {ERROR} (id:{ID}, instance:{INSTANCE})";

    private static const START_TIME:int = new Date().getTime();

    public function RemoteTexture(_arg_1:String, _arg_2:String, _arg_3:Function) {
        super();
        this.id_ = _arg_1;
        this.instance_ = _arg_2;
        this.callback_ = _arg_3;
        var _local4:Injector = StaticInjectorContext.getInjector();
        this.logger = _local4.getInstance(ILogger);
    }
    public var id_:String;
    public var instance_:String;
    public var callback_:Function;
    private var logger:ILogger;

    public function run():void {
        var _local4:String = this.instance_ == "testing" ? "rotmghrdtesting.appspot.com" : "realmofthemadgodhrd.appspot.com";
        var _local2:String = "https://{DOMAIN}/picture/get".replace("{DOMAIN}", _local4);
        var _local1:* = {};
        _local1.id = this.id_;
        _local1.time = START_TIME;
        var _local3:RetryLoader = new AppEngineRetryLoader();
        _local3.setDataFormat("binary");
        _local3.complete.addOnce(this.onComplete);
        _local3.sendRequest(_local2, _local1);
    }

    public function makeTexture(_arg_1:ByteArray):void {
        var _local2:BitmapData = PNGDecoder.decodeImage(_arg_1);
        this.callback_(_local2);
    }

    public function reportError(_arg_1:String):void {
        _arg_1 = "Remote Texture Error: {ERROR} (id:{ID}, instance:{INSTANCE})".replace("{ERROR}", _arg_1).replace("{ID}", this.id_).replace("{INSTANCE}", this.instance_);
        this.logger.warn("RemoteTexture.reportError: {0}", [_arg_1]);
        var _local2:BitmapData = new BitmapData(1, 1, true, 0);
        this.callback_(_local2);
    }

    private function onComplete(_arg_1:Boolean, _arg_2:*):void {
        if (_arg_1) {
            this.makeTexture(_arg_2);
        } else {
            this.reportError(_arg_2);
        }
    }
}
}
