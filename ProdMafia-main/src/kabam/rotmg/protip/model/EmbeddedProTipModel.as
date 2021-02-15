package kabam.rotmg.protip.model {
   public class EmbeddedProTipModel implements IProTipModel {
      
      public static var protipsXML:Class = EmbeddedProTipModel_protipsXML;
       
      
      private var tips:Vector.<String>;
      
      private var indices:Vector.<int>;
      
      private var index:int;
      
      private var count:int;
      
      public function EmbeddedProTipModel() {
         super();
         this.index = 0;
         this.makeTipsVector();
         this.count = this.tips.length;
         this.makeRandomizedIndexVector();
      }
      
      public function getTip() : String {
         var _loc1_:Number = this.index;
         this.index++;
         var _loc2_:int = this.indices[_loc1_ % this.count];
         return this.tips[_loc2_];
      }
      
      private function makeTipsVector() : void {
         var _loc1_:* = null;
         var _loc3_:XML = XML(new protipsXML());
         this.tips = new Vector.<String>(0);
         var _loc2_:* = _loc3_.Protip;
         var _loc6_:int = 0;
         var _loc5_:* = _loc3_.Protip;
         for each(_loc1_ in _loc3_.Protip) {
            this.tips.push(_loc1_.toString());
         }
         this.count = this.tips.length;
      }
      
      private function makeRandomizedIndexVector() : void {
         var _loc1_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>(0);
         while(_loc1_ < this.count) {
            _loc2_.push(_loc1_);
            _loc1_++;
         }
         this.indices = new Vector.<int>(0);
         while(_loc1_ > 0) {
            _loc1_--;
            this.indices.push(_loc2_.splice(Math.floor(Math.random() * _loc1_),1)[0]);
         }
         this.indices.fixed = true;
      }
   }
}
