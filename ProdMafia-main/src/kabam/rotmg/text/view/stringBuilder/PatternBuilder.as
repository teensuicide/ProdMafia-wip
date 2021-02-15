package kabam.rotmg.text.view.stringBuilder {
   import kabam.rotmg.language.model.StringMap;
   
   public class PatternBuilder implements StringBuilder {
       
      
      private const PATTERN:RegExp = /(\{([^\{]+?)\})/gi;
      
      private var pattern:String = "";
      
      private var keys:Array;
      
      private var provider:StringMap;
      
      public function PatternBuilder() {
         super();
      }
      
      public function setPattern(param1:String) : PatternBuilder {
         this.pattern = param1;
         return this;
      }
      
      public function setStringMap(param1:StringMap) : void {
         this.provider = param1;
      }
      
      public function getString() : String {
         var _loc1_:* = null;
         this.keys = this.pattern.match(this.PATTERN);
         var _loc3_:String = this.pattern;
         var _loc2_:* = this.keys;
         var _loc6_:int = 0;
         var _loc5_:* = this.keys;
         for each(_loc1_ in this.keys) {
            _loc3_ = _loc3_.replace(_loc1_,this.provider.getValue(_loc1_.substr(1,_loc1_.length - 2)));
         }
         return _loc3_.replace(/\\n/g,"\n");
      }
   }
}
