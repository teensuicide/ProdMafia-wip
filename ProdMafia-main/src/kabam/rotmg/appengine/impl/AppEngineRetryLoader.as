package kabam.rotmg.appengine.impl {
import com.company.assembleegameclient.parameters.Parameters;

import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import kabam.rotmg.appengine.api.RetryLoader;
   import org.osflash.signals.OnceSignal;
   
   public class AppEngineRetryLoader implements RetryLoader {
       
      
      private const _complete:OnceSignal = new OnceSignal(Boolean);
      
      private var maxRetries:int;
      
      private var dataFormat:String;
      
      private var url:String;
      
      private var params:Object;
      
      private var urlRequest:URLRequest;
      
      private var urlLoader:URLLoader;
      
      private var retriesLeft:int;
      
      private var inProgress:Boolean;
      
      private var fromLauncher:Boolean;
      
      public function AppEngineRetryLoader() {
         super();
         this.inProgress = false;
         this.maxRetries = 0;
         this.dataFormat = "text";
      }
      
      public function get complete() : OnceSignal {
         return this._complete;
      }
      
      public function isInProgress() : Boolean {
         return this.inProgress;
      }
      
      public function setDataFormat(param1:String) : void {
         this.dataFormat = param1;
      }
      
      public function setMaxRetries(param1:int) : void {
         this.maxRetries = param1;
      }
      
      public function sendRequest(param1:String, param2:Object, param3:Boolean = false) : void {
         this.url = param1;
         this.params = param2;
         this.fromLauncher = param3;
         this.retriesLeft = this.maxRetries;
         this.inProgress = true;
         this.internalSendRequest();
      }
      
      private function internalSendRequest() : void {
         this.cancelPendingRequest();
         this.urlRequest = this.makeUrlRequest();
         this.urlLoader = this.makeUrlLoader();
         this.urlLoader.load(this.urlRequest);
      }
      
      private function makeUrlRequest() : URLRequest {
         var _loc2_:Array = [new URLRequestHeader("Accept","*/*")];
         if(Capabilities.playerType == "Desktop") {
            _loc2_.push(new URLRequestHeader("Referer",null));
            if(this.fromLauncher) {
               _loc2_.push(new URLRequestHeader("User-Agent","UnityPlayer/" + Parameters.UNITY_LAUNCHER_VERSION + " (UnityWebRequest/1.0, libcurl/7.52.0-DEV)"));
               _loc2_.push(new URLRequestHeader("X-Unity-Version",Parameters.UNITY_LAUNCHER_VERSION));
            } else {
               _loc2_.push(new URLRequestHeader("User-Agent","UnityPlayer/" + Parameters.UNITY_GAME_VERSION
                       + " (UnityWebRequest/1.0, libcurl/7.52.0-DEV)"));
               _loc2_.push(new URLRequestHeader("X-Unity-Version",Parameters.UNITY_GAME_VERSION));
            }
         }
         var _loc1_:URLRequest = new URLRequest(this.url);
         _loc1_.method = "POST";
         _loc1_.data = this.makeUrlVariables(this.url);
         _loc1_.requestHeaders = _loc2_;
         return _loc1_;
      }

      private function makeUrlVariables(url:String) : URLVariables {
         var objName:* = null;
         var _loc3_:URLVariables = new URLVariables();
         var _loc2_:String = "";
         for (objName in this.params) {
            if(!this.fromLauncher &&
                    url.indexOf("app/init") == -1 &&
                    url.indexOf("account/verify") == -1 &&
                    url.indexOf("char/list") == -1 &&
                    url.indexOf("account/getOwnedPetSkins") == -1 &&
                    (objName == "guid" || objName == "password")) {
               _loc2_ = _loc2_ + ((_loc2_.length > 0?"&":"") + objName + "=" + this.params[objName]);
            }
            _loc3_[objName] = this.params[objName];
         }
         if(_loc2_.length > 0) {
            _loc3_[""] = _loc2_;
         }
         return _loc3_;
      }
      
      private function makeUrlLoader() : URLLoader {
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.dataFormat = this.dataFormat;
         _loc1_.addEventListener("ioError",this.onIOError);
         _loc1_.addEventListener("securityError",this.onSecurityError);
         _loc1_.addEventListener("complete",this.onComplete);
         return _loc1_;
      }
      
      private function retryOrReportError(param1:String) : void {
         var _loc2_:Number = this.retriesLeft;
         this.retriesLeft--;
         if(_loc2_ > 0) {
            this.internalSendRequest();
         } else {
            this.cleanUpAndComplete(false,param1);
         }
      }
      
      private function handleTextResponse(param1:String) : void {
         if(param1.substring(0,7) == "<Error>") {
            this.retryOrReportError(param1);
         } else if(param1.substring(0,12) == "<FatalError>") {
            this.cleanUpAndComplete(false,param1);
         } else {
            this.cleanUpAndComplete(true,param1);
         }
      }
      
      private function cleanUpAndComplete(param1:Boolean, param2:*) : void {
         if(!param1 && param2 is String) {
            param2 = this.parseXML(param2);
         }
         this.cancelPendingRequest();
         this._complete.dispatch(param1,param2);
      }
      
      private function parseXML(param1:String) : String {
         var _loc2_:Array = param1.match("<.*>(.*)</.*>");
         return _loc2_ && _loc2_.length > 1?_loc2_[1]:param1;
      }
      
      private function cancelPendingRequest() : void {
         if(this.urlLoader) {
            this.urlLoader.removeEventListener("ioError",this.onIOError);
            this.urlLoader.removeEventListener("securityError",this.onSecurityError);
            this.urlLoader.removeEventListener("complete",this.onComplete);
            this.closeLoader();
            this.urlLoader = null;
         }
      }
      
      private function closeLoader() : void {
         try {
            this.urlLoader.close();
            return;
         }
         catch(e:Error) {
            return;
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void {
         this.inProgress = false;
         var _loc2_:String = this.urlLoader.data;
         if(_loc2_.length == 0) {
            _loc2_ = "Unable to contact server";
         }
         this.retryOrReportError(_loc2_);
      }
      
      private function onSecurityError(param1:SecurityErrorEvent) : void {
         this.inProgress = false;
         this.cleanUpAndComplete(false,"Security Error");
      }
      
      private function onComplete(param1:Event) : void {
         this.inProgress = false;
         if(this.dataFormat == "text") {
            this.handleTextResponse(this.urlLoader.data);
         } else {
            this.cleanUpAndComplete(true,ByteArray(this.urlLoader.data));
         }
      }
   }
}
