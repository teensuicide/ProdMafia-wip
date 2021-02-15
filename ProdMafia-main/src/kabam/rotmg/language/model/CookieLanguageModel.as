package kabam.rotmg.language.model {
   import flash.net.SharedObject;
   import flash.utils.Dictionary;
   
   public class CookieLanguageModel implements LanguageModel {
      
      public static const DEFAULT_LOCALE:String = "en";
       
      
      private var cookie:SharedObject;
      
      private var language:String;
      
      private var availableLanguages:Dictionary;
      
      public function CookieLanguageModel() {
         this.availableLanguages = this.makeAvailableLanguages();
         super();
         try {
            this.cookie = SharedObject.getLocal("login","/");
            return;
         }
         catch(error:Error) {
            return;
         }
      }
      
      public function getLanguage() : String {
         var _loc1_:* = this.language || this.readLanguageFromCookie();
         this.language = _loc1_;
         return _loc1_;
      }
      
      public function setLanguage(param1:String) : void {
         this.language = param1;
         try {
            this.cookie.data.locale = param1;
            this.cookie.flush();
            return;
         }
         catch(error:Error) {
            return;
         }
      }
      
      public function getLanguageFamily() : String {
         return this.getLanguage().substr(0,2).toLowerCase();
      }
      
      public function getLanguageNames() : Vector.<String> {
         var _loc1_:* = undefined;
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc2_:* = this.availableLanguages;
         var _loc6_:int = 0;
         var _loc5_:* = this.availableLanguages;
         for(_loc1_ in this.availableLanguages) {
            _loc3_.push(_loc1_);
         }
         return _loc3_;
      }
      
      public function getLanguageCodeForName(param1:String) : String {
         return this.availableLanguages[param1];
      }
      
      public function getNameForLanguageCode(param1:String) : String {
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         var _loc4_:* = this.availableLanguages;
         var _loc7_:int = 0;
         var _loc6_:* = this.availableLanguages;
         for(_loc3_ in this.availableLanguages) {
            if(this.availableLanguages[_loc3_] == param1) {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
      
      private function readLanguageFromCookie() : String {
         return "en";
      }
      
      private function makeAvailableLanguages() : Dictionary {
         var _loc1_:Dictionary = new Dictionary();
         _loc1_["Languages.English"] = "en";
         _loc1_["Languages.French"] = "fr";
         _loc1_["Languages.Spanish"] = "es";
         _loc1_["Languages.Italian"] = "it";
         _loc1_["Languages.German"] = "de";
         _loc1_["Languages.Turkish"] = "tr";
         _loc1_["Languages.Russian"] = "ru";
         return _loc1_;
      }
   }
}
