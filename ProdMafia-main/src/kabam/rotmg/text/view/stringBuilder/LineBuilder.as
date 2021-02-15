package kabam.rotmg.text.view.stringBuilder {
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.language.model.StringMap;
   
   public class LineBuilder implements StringBuilder {
       
      
      public var key:String;
      
      public var tokens:Object;
      
      private var postfix:String = "";
      
      private var prefix:String = "";
      
      private var map:StringMap;
      
      public function LineBuilder() {
         super();
      }
      
      public static function fromJSON(param1:String) : LineBuilder {
         var _loc2_:Object = JSON.parse(param1);
         return new LineBuilder().setParams(_loc2_.key,_loc2_.tokens);
      }
      
      public static function getLocalizedStringFromKey(param1:String, param2:Object = null) : String {
         var _loc4_:LineBuilder = new LineBuilder();
         _loc4_.setParams(param1,param2);
         var _loc3_:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
         _loc4_.setStringMap(_loc3_);
         return _loc4_.getString() == ""?param1:_loc4_.getString();
      }
      
      public static function getLocalizedStringFromJSON(param1:String) : String {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.charAt(0) == "{") {
            _loc2_ = LineBuilder.fromJSON(param1);
            _loc3_ = StaticInjectorContext.getInjector().getInstance(StringMap);
            _loc2_.setStringMap(_loc3_);
            return _loc2_.getString();
         }
         return param1;
      }
      
      public static function returnStringReplace(param1:String, param2:Object = null, param3:String = "", param4:String = "") : String {
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = null;
         var _loc6_:String = stripCurlyBrackets(param1);
         var _loc7_:* = param2;
         var _loc12_:int = 0;
         var _loc11_:* = param2;
         for(_loc8_ in param2) {
            _loc10_ = param2[_loc8_];
            _loc9_ = "{" + _loc8_ + "}";
            while(_loc6_.indexOf(_loc9_) != -1) {
               _loc6_ = _loc6_.replace(_loc9_,_loc10_);
            }
         }
         _loc6_ = _loc6_.replace(/\\n/g,"\n");
         return param3 + _loc6_ + param4;
      }
      
      public static function getLocalizedString2(param1:String, param2:Object = null) : String {
         var _loc4_:LineBuilder = new LineBuilder();
         _loc4_.setParams(param1,param2);
         var _loc3_:StringMap = StaticInjectorContext.getInjector().getInstance(StringMap);
         _loc4_.setStringMap(_loc3_);
         return _loc4_.getString();
      }
      
      private static function stripCurlyBrackets(param1:String) : String {
         var _loc2_:Boolean = param1 != null && param1.charAt(0) == "{" && param1.charAt(param1.length - 1) == "}";
         return !!_loc2_?param1.substr(1,param1.length - 2):param1;
      }
      
      public function toJson() : String {
         return JSON.stringify({
            "key":this.key,
            "tokens":this.tokens
         });
      }
      
      public function setParams(param1:String, param2:Object = null) : LineBuilder {
         this.key = param1 || "";
         this.tokens = param2;
         return this;
      }
      
      public function setPrefix(param1:String) : LineBuilder {
         this.prefix = param1;
         return this;
      }
      
      public function setPostfix(param1:String) : LineBuilder {
         this.postfix = param1;
         return this;
      }
      
      public function setStringMap(param1:StringMap) : void {
         this.map = param1;
      }
      
      public function getString() : String {
         var _loc3_:* = undefined;
         var _loc2_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:String = stripCurlyBrackets(this.key);
         var _loc1_:String = this.map.getValue(_loc7_) || "";
         var _loc4_:* = this.tokens;
         var _loc9_:int = 0;
         var _loc8_:* = this.tokens;
         for(_loc3_ in this.tokens) {
            _loc6_ = this.tokens[_loc3_];
            if(_loc6_.charAt(0) == "{" && _loc6_.charAt(_loc6_.length - 1) == "}") {
               _loc6_ = this.map.getValue(_loc6_.substr(1,_loc6_.length - 2));
            }
            _loc2_ = "{" + _loc3_ + "}";
            while(_loc1_.indexOf(_loc2_) != -1) {
               _loc1_ = _loc1_.replace(_loc2_,_loc6_);
            }
         }
         _loc1_ = _loc1_.replace(/\\n/g,"\n");
         return this.prefix + _loc1_ + this.postfix;
      }
   }
}
