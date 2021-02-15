package kabam.rotmg.account.web {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.util.GUID;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import kabam.rotmg.account.core.Account;
   
   public class WebAccount implements Account {
      
      public static const NETWORK_NAME:String = "rotmg";
      
      private static const WEB_USER_ID:String = "";
      
      public static const NETWORK_NAME_EXALT:String = "Unity";
      
      public static const WEB_PLAY_PLATFORM_NAME:String = "rotmg";
      
      public static const WEB_PLAY_PLATFORM_NAME_EXALT:String = "Unity";
       
      
      public var signedRequest:String;
      
      public var kabamId:String;
      
      private var userId:String = "";
      
      private var password:String;
      
      private var secret:String = "";
      
      private var token:String = "";
      
      private var entryTag:String = "";
      
      private var isVerifiedEmail:Boolean;
      
      private var platformToken:String;
      
      private var _userDisplayName:String = "";
      
      private var _rememberMe:Boolean = true;
      
      private var _paymentProvider:String = "";
      
      private var _paymentData:String = "";
      
      private var _creationDate:Date;
      
      public function WebAccount() {
         super();
         try {
            this.entryTag = ExternalInterface.call("rotmg.UrlLib.getParam","entrypt");
            return;
         }
         catch(error:Error) {
            return;
         }
      }
      
      public function get userDisplayName() : String {
         return this._userDisplayName;
      }
      
      public function set userDisplayName(param1:String) : void {
         this._userDisplayName = param1;
      }
      
      public function get rememberMe() : Boolean {
         return this._rememberMe;
      }
      
      public function set rememberMe(param1:Boolean) : void {
         this._rememberMe = param1;
      }
      
      public function get paymentProvider() : String {
         return this._paymentProvider;
      }
      
      public function set paymentProvider(param1:String) : void {
         this._paymentProvider = param1;
      }
      
      public function get paymentData() : String {
         return this._paymentData;
      }
      
      public function set paymentData(param1:String) : void {
         this._paymentData = param1;
      }
      
      public function get creationDate() : Date {
         return this._creationDate;
      }
      
      public function set creationDate(param1:Date) : void {
         this._creationDate = param1;
      }
      
      public function getUserName() : String {
         return this.userId;
      }
      
      public function getUserId() : String {
         var _loc1_:* = this.userId || GUID.create();
         this.userId = _loc1_;
         return _loc1_;
      }
      
      public function getPassword() : String {
         return this.password || "";
      }
      
      public function getToken() : String {
         return "";
      }
      
      public function getCredentials() : Object {
         if(this.getSecret() != "") {
            return {
               "guid":this.getUserId(),
               "secret":this.getSecret()
            };
         }
         return {
            "guid":this.getUserId(),
            "password":this.getPassword()
         };
      }
      
      public function getVaults() : Object {
         return {"muleDump":"true"};
      }
      
      public function isRegistered() : Boolean {
         return this.getPassword() != "" || this.getSecret() != "" || this.getToken() != "";
      }
      
      public function updateUser(param1:String, param2:String, param3:String, param4:String) : void {
         var _loc5_:* = null;
         this.userId = param1;
         this.password = param2;
         this.secret = param4;
         this.token = param3;
         try {
            if(this._rememberMe) {
               _loc5_ = SharedObject.getLocal("login","/");
               _loc5_.data["GUID"] = param1;
               _loc5_.data["Token"] = param3;
               _loc5_.data["Password"] = param2;
               _loc5_.data["Secret"] = param4;
               _loc5_.flush();
            }
            return;
         }
         catch(error:Error) {
            return;
         }
      }
      
      public function clear() : void {
         this._rememberMe = true;
         this.updateUser(GUID.create(),null,null,null);
         Parameters.data.charIdUseMap = {};
         Parameters.save();
      }
      
      public function reportIntStat(param1:String, param2:int) : void {
      }
      
      public function getRequestPrefix() : String {
         return "/credits";
      }
      
      public function gameNetworkUserId() : String {
         return "";
      }
      
      public function gameNetwork() : String {
         return "Unity";
      }
      
      public function playPlatform() : String {
         return "Unity";
      }
      
      public function getEntryTag() : String {
         return this.entryTag || "";
      }
      
      public function getSecret() : String {
         return this.secret || "";
      }
      
      public function verify(param1:Boolean) : void {
         this.isVerifiedEmail = param1;
      }
      
      public function isVerified() : Boolean {
         return this.isVerifiedEmail;
      }
      
      public function getPlatformToken() : String {
         return this.platformToken || "";
      }
      
      public function setPlatformToken(param1:String) : void {
         this.platformToken = param1;
      }
      
      public function getMoneyAccessToken() : String {
         return this.signedRequest;
      }
      
      public function getMoneyUserId() : String {
         return this.kabamId;
      }
   }
}
