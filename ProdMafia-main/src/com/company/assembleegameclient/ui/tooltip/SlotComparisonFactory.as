package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.CloakComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GeneralProjectileComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.GenericArmorComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.HelmetComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.OrbComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SealComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.SlotComparison;
   import com.company.assembleegameclient.ui.tooltip.slotcomparisons.TomeComparison;
   
   public class SlotComparisonFactory {
       
      
      private var hash:Object;
      
      public function SlotComparisonFactory() {
         super();
         var _loc2_:GeneralProjectileComparison = new GeneralProjectileComparison();
         var _loc1_:GenericArmorComparison = new GenericArmorComparison();
         this.hash = {};
         this.hash[4] = new TomeComparison();
         this.hash[6] = _loc1_;
         this.hash[7] = _loc1_;
         this.hash[12] = new SealComparison();
         this.hash[13] = new CloakComparison();
         this.hash[14] = _loc1_;
         this.hash[16] = new HelmetComparison();
         this.hash[21] = new OrbComparison();
      }
      
      public function getComparisonResults(param1:XML, param2:XML) : SlotComparisonResult {
         var _loc5_:int = param1.SlotType;
         var _loc4_:SlotComparison = this.hash[_loc5_];
         var _loc3_:SlotComparisonResult = new SlotComparisonResult();
         if(_loc4_ != null) {
            _loc4_.compare(param1,param2);
            _loc3_.lineBuilder = _loc4_.comparisonStringBuilder;
            _loc3_.processedTags = _loc4_.processedTags;
         }
         return _loc3_;
      }
   }
}
