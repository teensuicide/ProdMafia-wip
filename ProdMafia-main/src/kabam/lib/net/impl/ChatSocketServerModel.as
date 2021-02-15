package kabam.lib.net.impl {
public class ChatSocketServerModel {


    private const CONNECTION_DELAY:int = 1000;

    public function ChatSocketServerModel() {
        super();
    }

    private var _chatToken:String;

    public function get chatToken():String {
        return this._chatToken;
    }

    public function set chatToken(_arg_1:String):void {
        this._chatToken = _arg_1;
    }

    private var _port:int;

    public function get port():int {
        return this._port;
    }

    public function set port(_arg_1:int):void {
        this._port = _arg_1;
    }

    private var _server:String;

    public function get server():String {
        return this._server;
    }

    public function set server(_arg_1:String):void {
        this._server = _arg_1;
    }

    private var _connectDelayMS:int;

    public function get connectDelayMS():int {
        return this._connectDelayMS == 0 ? 1000 : this._connectDelayMS;
    }

    public function set connectDelayMS(_arg_1:int):void {
        this._connectDelayMS = _arg_1;
    }

}
}
