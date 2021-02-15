package kabam.rotmg.text.view.stringBuilder {
   import kabam.rotmg.language.model.StringMap;
   
   public class TemplateBuilder implements StringBuilder {
       
      
      private var template:String;
      
      private var tokens:Object;
      
      private var postfix:String = "";
      
      private var prefix:String = "";
      
      private var provider:StringMap;
      
      public function TemplateBuilder() {
         super();
      }
      
      public function setTemplate(param1:String, param2:Object = null) : TemplateBuilder {
         this.template = param1;
         this.tokens = param2;
         return this;
      }
      
      public function setPrefix(param1:String) : TemplateBuilder {
         this.prefix = param1;
         return this;
      }
      
      public function setPostfix(param1:String) : TemplateBuilder {
         this.postfix = param1;
         return this;
      }
      
      public function setStringMap(param1:StringMap) : void {
         this.provider = param1;
      }
      
      public function getString() : String {
         var _loc1_:* = undefined;
         var _loc3_:* = null;
         var _loc2_:String = this.template;
         var _loc4_:* = this.tokens;
         var _loc7_:int = 0;
         var _loc6_:* = this.tokens;
         for(_loc1_ in this.tokens) {
            _loc3_ = this.tokens[_loc1_];
            if(_loc3_.charAt(0) == "{" && _loc3_.charAt(_loc3_.length - 1) == "}") {
               _loc3_ = this.provider.getValue(_loc3_.substr(1,_loc3_.length - 2));
            }
            _loc2_ = _loc2_.replace("{" + _loc1_ + "}",_loc3_);
         }
         _loc2_ = _loc2_.replace(/\\n/g,"\n");
         return this.prefix + _loc2_ + this.postfix;
      }
   }
}
