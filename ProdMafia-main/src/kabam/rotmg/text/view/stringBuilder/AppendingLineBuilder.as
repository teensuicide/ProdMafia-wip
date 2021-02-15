package kabam.rotmg.text.view.stringBuilder {
   import kabam.rotmg.language.model.StringMap;
   
   public class AppendingLineBuilder implements StringBuilder {
       
      
      private var delimiter:String = "\n";
      
      private var provider:StringMap;
      
      private var temper:Vector.<String>;
      
      private var data:Vector.<LineData>;
      
      public function AppendingLineBuilder() {
         temper = new Vector.<String>();
         data = new Vector.<LineData>();
         super();
      }
      
      public function pushParams(param1:String, param2:Object = null, param3:String = "", param4:String = "") : AppendingLineBuilder {
         this.data.push(new LineData().setKey(param1).setTokens(param2).setOpeningTags(param3).setClosingTags(param4));
         return this;
      }
      
      public function setDelimiter(param1:String) : AppendingLineBuilder {
         this.delimiter = param1;
         return this;
      }
      
      public function setStringMap(param1:StringMap) : void {
         this.provider = param1;
      }
      
      public function getString() : String {
         temper.length = 0;
         var _loc3_:int = 0;
         var _loc2_:* = this.data;
         for each(var _loc1_ in this.data) {
            temper.push(_loc1_.getString(this.provider));
         }
         return temper.join(this.delimiter);
      }
      
      public function hasLines() : Boolean {
         return this.data.length != 0;
      }
      
      public function clear() : void {
         this.data = new Vector.<LineData>();
      }
   }
}

import kabam.rotmg.language.model.StringMap;
import kabam.rotmg.text.model.TextKey;
import kabam.rotmg.text.view.stringBuilder.StringBuilder;

class LineData {
    
   
   public var key:String;
   
   public var tokens:Object;
   
   public var openingHTMLTags:String = "";
   
   public var closingHTMLTags:String = "";
   
   function LineData() {
      super();
   }
   
   public function setKey(param1:String) : LineData {
      this.key = param1;
      return this;
   }
   
   public function setTokens(param1:Object) : LineData {
      this.tokens = param1;
      return this;
   }
   
   public function setOpeningTags(param1:String) : LineData {
      this.openingHTMLTags = param1;
      return this;
   }
   
   public function setClosingTags(param1:String) : LineData {
      this.closingHTMLTags = param1;
      return this;
   }
   
   public function getString(param1:StringMap) : String {
      var _loc3_:* = null;
      var _loc5_:* = null;
      var _loc6_:* = null;
      var _loc4_:* = null;
      var _loc2_:String = this.openingHTMLTags;
      _loc3_ = param1.getValue(TextKey.stripCurlyBrackets(this.key));
      if(_loc3_ == null) {
         _loc3_ = this.key;
      }
      _loc2_ = _loc2_.concat(_loc3_);
      var _loc8_:int = 0;
      var _loc7_:* = this.tokens;
      for(_loc5_ in this.tokens) {
         if(this.tokens[_loc5_] is StringBuilder) {
            _loc6_ = StringBuilder(this.tokens[_loc5_]);
            _loc6_.setStringMap(param1);
            _loc2_ = _loc2_.replace("{" + _loc5_ + "}",_loc6_.getString());
         } else {
            _loc4_ = this.tokens[_loc5_].toString();
            if(_loc4_.length > 0 && _loc4_.charAt(0) == "{" && _loc4_.charAt(_loc4_.length - 1) == "}") {
               _loc4_ = param1.getValue(_loc4_.substr(1,_loc4_.length - 2));
            }
            _loc2_ = _loc2_.replace("{" + _loc5_ + "}",_loc4_);
         }
      }
      _loc2_ = _loc2_.replace(/\\n/g,"\n");
      return _loc2_.concat(this.closingHTMLTags);
   }
}
