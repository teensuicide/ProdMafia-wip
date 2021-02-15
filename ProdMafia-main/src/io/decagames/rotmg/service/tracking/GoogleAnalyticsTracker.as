package io.decagames.rotmg.service.tracking {
   import flash.crypto.generateRandomBytes;
   import flash.display.Loader;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GoogleAnalyticsTracker {
      
      public static const VERSION:String = "1";
       
      
      private var trackingURL:String = "https://www.google-analytics.com/collect";
      
      private var account:String;
      
      private var logger:ILogger;
      
      private var clientID:String;
      
      private var _debug:Boolean = false;
      
      public function GoogleAnalyticsTracker(param1:String, param2:ILogger, param3:String, param4:Boolean = false) {
         super();
         this.account = param1;
         this.logger = param2;
         this._debug = param4;
         if(param4) {
            this.trackingURL = "http://www.google-analytics.com/debug/collect";
         }
         this.clientID = this.getClientID();
      }
      
      public function get debug() : Boolean {
         return this._debug;
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = "", param4:Number = NaN) : void {
         this.triggerEvent("&t=event&ec=" + param1 + "&ea=" + param2 + (param3 != ""?"&el=" + param3:"") + (!!isNaN(param4)?"":"&ev=" + param4));
      }
      
      public function trackPageView(param1:String) : void {
         this.triggerEvent("&t=pageview&dp=" + param1);
      }
      
      private function getClientID() : String {
         var _loc1_:* = null;
         var _loc2_:SharedObject = SharedObject.getLocal("_ga2");
         if(!_loc2_.data.clientid) {
            this.logger.debug("CID not found, generate Client ID");
            _loc1_ = this._generateUUID();
            _loc2_.data.clientid = _loc1_;
            try {
               _loc2_.flush(1024);
            }
            catch(e:Error) {
               logger.debug("Could not write SharedObject to disk: " + e.message);
            }
         } else {
            this.logger.debug("CID found, restore from SharedObject: " + _loc2_.data.clientid);
            _loc1_ = _loc2_.data.clientid;
         }
         return _loc1_;
      }
      
      private function _generateUUID() : String {
         var randomBytes:ByteArray = generateRandomBytes(16);
         randomBytes[6] = randomBytes[6] & 15;
         randomBytes[6] = randomBytes[6] | 64;
         randomBytes[8] = randomBytes[8] & 63;
         randomBytes[8] = randomBytes[8] | 128;
         var toHex:Function = function(param1:uint):String {
            var _loc2_:String = param1.toString(16);
            return _loc2_.length > 1?_loc2_:"0" + _loc2_;
         };
         var str:String = "";
         var l:uint = randomBytes.length;
         randomBytes.position = 0;
         var i:uint = 0;
         while(i < l) {
            var b:uint = randomBytes[i];
            str = str + toHex(b);
            i = Number(i) + 1;
         }
         var uuid:String = "";
         uuid = uuid + str.substr(0,8);
         uuid = uuid + "-";
         uuid = uuid + str.substr(8,4);
         uuid = uuid + "-";
         uuid = uuid + str.substr(12,4);
         uuid = uuid + "-";
         uuid = uuid + str.substr(16,4);
         uuid = uuid + "-";
         uuid = uuid + str.substr(20,12);
         return uuid;
      }
      
      private function prepareURL(param1:String) : String {
         return this.trackingURL + "?v=" + "1" + "&tid=" + this.account + "&cid=" + this.clientID + param1;
      }
      
      private function triggerEvent(param1:String) : void {
         var _loc3_:* = null;
         var _loc2_:* = null;
         param1 = this.prepareURL(param1);
         if(this._debug) {
            this.logger.debug("DEBUGGING GA:" + param1);
            return;
         }
         try {
            _loc3_ = new Loader();
            _loc2_ = new URLRequest(param1);
            _loc3_.load(_loc2_);
            return;
         }
         catch(e:Error) {
            logger.error("Tracking Error:" + e.message + ", " + e.name + ", " + e.getStackTrace());
            return;
         }
      }
   }
}
