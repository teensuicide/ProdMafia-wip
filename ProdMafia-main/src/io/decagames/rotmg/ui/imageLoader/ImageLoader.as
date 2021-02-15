package io.decagames.rotmg.ui.imageLoader {
import flash.display.Loader;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;

public class ImageLoader {


    public function ImageLoader() {
        super();
    }
    private var _callBack:Function;

    private var _loader:Loader;

    public function get loader():Loader {
        return this._loader;
    }

    public function loadImage(param1:String, param2:Function):void {
        var _loc4_:* = param1;
        var _loc3_:* = param2;
        this._callBack = _loc3_;
        this._loader = new Loader();
        this._loader.contentLoaderInfo.addEventListener("complete", _loc3_);
        this._loader.contentLoaderInfo.addEventListener("ioError", onIOError);
        this._loader.contentLoaderInfo.addEventListener("securityError", onSecurityEventError);
        try {
            this._loader.load(new URLRequest(_loc4_));

        } catch (error:SecurityError) {

        }
    }

    public function removeLoaderListeners():void {
        if (this._loader && this._loader.contentLoaderInfo) {
            this._loader.contentLoaderInfo.removeEventListener("complete", this._callBack);
            this._loader.contentLoaderInfo.removeEventListener("ioError", onIOError);
            this._loader.contentLoaderInfo.removeEventListener("securityError", onSecurityEventError);
        }
    }

    private static function onIOError(param1:IOErrorEvent):void {
    }

    private static function onSecurityEventError(param1:SecurityErrorEvent):void {
    }
}
}
