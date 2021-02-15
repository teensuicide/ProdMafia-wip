package kabam.rotmg.legends.model {
   public class LegendsModel {
       
      
      private const map:Object = {};
      
      private var timespan:Timespan;
      
      public function LegendsModel() {
         timespan = Timespan.WEEK;
         super();
      }
      
      public function getTimespan() : Timespan {
         return this.timespan;
      }
      
      public function setTimespan(param1:Timespan) : void {
         this.timespan = param1;
      }
      
      public function hasLegendList() : Boolean {
         return this.map[this.timespan.getId()] != null;
      }
      
      public function getLegendList() : Vector.<Legend> {
         return this.map[this.timespan.getId()];
      }
      
      public function setLegendList(param1:Vector.<Legend>) : void {
         this.map[this.timespan.getId()] = param1;
      }
      
      public function clear() : void {
         var _loc3_:* = undefined;
         var _loc1_:* = this.map;
         var _loc5_:int = 0;
         var _loc4_:* = this.map;
         for(_loc3_ in this.map) {
            this.dispose(this.map[_loc3_]);
            delete this.map[_loc3_];
         }
      }
      
      private function dispose(param1:Vector.<Legend>) : void {
         var _loc2_:* = null;
         var _loc3_:* = param1;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(_loc2_ in param1) {
            _loc2_.character && this.removeLegendCharacter(_loc2_);
         }
      }
      
      private function removeLegendCharacter(param1:Legend) : void {
         param1.character.dispose();
         param1.character = null;
      }
   }
}
