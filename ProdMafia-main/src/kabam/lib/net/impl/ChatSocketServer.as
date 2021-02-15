package kabam.lib.net.impl {
import com.hurlant.crypto.symmetric.ICipher;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.events.TimerEvent;
import flash.net.Socket;
import flash.utils.ByteArray;
import flash.utils.Timer;

import kabam.lib.net.api.MessageProvider;

import org.osflash.signals.Signal;

public class ChatSocketServer {

    public static const MESSAGE_LENGTH_SIZE_IN_BYTES:int = 4;


    public const chatConnected:Signal = new Signal();

    public const chatClosed:Signal = new Signal();

    public const chatError:Signal = new Signal(String);

    private const unsentPlaceholder:Message = new Message(0);

    private const data:ByteArray = new ByteArray();

    public function ChatSocketServer() {
        head = unsentPlaceholder;
        tail = unsentPlaceholder;
        super();
    }
    [Inject]
    public var messages:MessageProvider;
    [Inject]
    public var chatSocket:Socket;
    [Inject]
    public var chatSocketServerModel:ChatSocketServerModel;
    public var delayTimer:Timer;
    private var head:Message;
    private var tail:Message;
    private var messageLen:int = -1;
    private var outgoingCipher:ICipher;
    private var incomingCipher:ICipher;
    private var server:String;
    private var port:int;

    private var _isConnecting:Boolean;

    public function set isConnecting(_arg_1:Boolean):void {
        this._isConnecting = _arg_1;
    }

    public function setOutgoingCipher(_arg_1:ICipher):ChatSocketServer {
        this.outgoingCipher = _arg_1;
        return this;
    }

    public function setIncomingCipher(_arg_1:ICipher):ChatSocketServer {
        this.incomingCipher = _arg_1;
        return this;
    }

    public function connect(_arg_1:String, _arg_2:int):void {
        this.server = _arg_1;
        this.port = _arg_2;
        if (!this.chatSocket.hasEventListener("connect")) {
            this.addListeners();
        }
        this.messageLen = -1;
        if (this.chatSocketServerModel.connectDelayMS) {
            this.connectWithDelay();
        } else {
            this.chatSocket.connect(_arg_1, _arg_2);
        }
    }

    public function dispose():void {
        if (this.delayTimer) {
            this.delayTimer.stop();
            this.delayTimer.removeEventListener("timerComplete", this.onTimerComplete);
        }
        this.removeListeners();
        if (this.chatSocket) {
            this.chatSocket.close();
            this.chatSocket = null;
        }
    }

    public function chatDisconnect():void {
        if (this.chatSocket) {
            this.chatSocket.close();
            this.removeListeners();
        }
        this.chatClosed.dispatch();
    }

    public function sendMessage(_arg_1:Message):void {
        this.tail.next = _arg_1;
        this.tail = _arg_1;
    }

    public function isChatConnected():Boolean {
        return this.chatSocket.connected;
    }

    private function addListeners():void {
        this.chatSocket.addEventListener("connect", this.onConnect);
        this.chatSocket.addEventListener("close", this.onClose);
        this.chatSocket.addEventListener("socketData", this.onSocketData);
        this.chatSocket.addEventListener("ioError", this.onIOError);
        this.chatSocket.addEventListener("securityError", this.onSecurityError);
    }

    private function connectWithDelay():void {
        this.delayTimer = new Timer(this.chatSocketServerModel.connectDelayMS, 1);
        this.delayTimer.addEventListener("timerComplete", this.onTimerComplete);
        this.delayTimer.start();
    }

    private function removeListeners():void {
        this.chatSocket.removeEventListener("connect", this.onConnect);
        this.chatSocket.removeEventListener("close", this.onClose);
        this.chatSocket.removeEventListener("socketData", this.onSocketData);
        this.chatSocket.removeEventListener("ioError", this.onIOError);
        this.chatSocket.removeEventListener("securityError", this.onSecurityError);
    }

    private function sendPendingMessages():void {
        var _local1:Message = this.head.next;
        var _local2:* = _local1;
        while (_local2) {
            this.data.clear();
            _local2.writeToOutput(this.data);
            this.data.position = 0;
            if (this.outgoingCipher != null) {
                this.outgoingCipher.encrypt(this.data);
                this.data.position = 0;
            }
            this.chatSocket.writeInt(this.data.bytesAvailable + 5);
            this.chatSocket.writeByte(_local2.id);
            this.chatSocket.writeBytes(this.data);
            _local2.consume();
            _local2 = _local2.next;
        }
        this.chatSocket.flush();
        this.unsentPlaceholder.next = null;
        this.unsentPlaceholder.prev = null;
        var _local3:* = this.unsentPlaceholder;
        this.tail = _local3;
        this.head = _local3;
    }

    private function logErrorAndClose(_arg_1:String, _arg_2:Array = null):void {
        this.chatError.dispatch(this.parseString(_arg_1, _arg_2));
        this.chatDisconnect();
    }

    private function parseString(_arg_1:String, _arg_2:Array):String {
        var _local3:int = 0;
        var _local4:int = _arg_2.length;
        while (_local3 < _local4) {
            _arg_1 = _arg_1.replace("{" + _local3 + "}", _arg_2[_local3]);
            _local3++;
        }
        return _arg_1;
    }

    private function onTimerComplete(_arg_1:TimerEvent):void {
        this.delayTimer.removeEventListener("timerComplete", this.onTimerComplete);
        this.chatSocket.connect(this.server, this.port);
    }

    private function onConnect(_arg_1:Event):void {
        this.sendPendingMessages();
        this.chatConnected.dispatch();
    }

    private function onClose(_arg_1:Event):void {
        if (!this._isConnecting) {
            this.chatClosed.dispatch();
        }
    }

    private function onIOError(_arg_1:IOErrorEvent):void {
        var _local2:String = this.parseString("Socket-Server IO Error: {0}", [_arg_1.text]);
        this.chatError.dispatch(_local2);
        this.chatClosed.dispatch();
    }

    private function onSecurityError(_arg_1:SecurityErrorEvent):void {
        var _local2:String = this.parseString("Socket-Server Security: {0}. Please open port 2050 in your firewall and/or router settings and try again", [_arg_1.text]);
        this.chatError.dispatch(_local2);
        this.chatClosed.dispatch();
    }

    private function onSocketData(_arg_1:ProgressEvent = null):void {
        var _local5:* = 0;
        var _local4:* = null;
        var _local2:* = null;
        var _local3:* = _arg_1;
        for (; !(this.chatSocket == null || !this.chatSocket.connected); _local4.consume()) {
            if (this.messageLen == -1) {
                if (this.chatSocket.bytesAvailable >= 4) {
                    try {
                        this.messageLen = this.chatSocket.readInt();
                    } catch (e:Error) {
                        var _local6:String = parseString("Socket-Server Data Error: {0}: {1}", [e.name, e.message]);
                        chatError.dispatch(null);
                        messageLen = -1;
                        return;
                    }
                }
                break;
            }
            if (this.chatSocket.bytesAvailable >= this.messageLen - 4) {
                _local5 = uint(this.chatSocket.readUnsignedByte());
                _local4 = this.messages.require(_local5);
                _local2 = new ByteArray();
                if (this.messageLen - 5 > 0) {
                    this.chatSocket.readBytes(_local2, 0, this.messageLen - 5);
                }
                _local2.position = 0;
                if (this.incomingCipher != null) {
                    this.incomingCipher.decrypt(_local2);
                    _local2.position = 0;
                }
                this.messageLen = -1;
                if (_local4 == null) {
                    this.logErrorAndClose("Socket-Server Protocol Error: Unknown message");
                    return;
                }
                try {
                    _local4.parseFromInput(_local2);
                    continue;
                } catch (error:Error) {
                    logErrorAndClose("Socket-Server Protocol Error: {0}", [error.toString()]);
                    return;
                }
                _local4.consume();
                continue;
            }
            break;
        }
    }
}
}
