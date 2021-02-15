package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   
   public class GenericArmorComparison extends SlotComparison {
      
      private static const DEFENSE_STAT:String = "21";
       
      
      private var defTags:XMLList;
      
      private var otherDefTags:XMLList;
      
      public function GenericArmorComparison() {
         super();
         comparisonStringBuilder = new AppendingLineBuilder();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _loc11_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:* = param1;
         var _loc4_:* = param2;
         var _loc9_:* = _loc10_.ActivateOnEquip;
         var _loc3_:* = new XMLList("");
         var _loc12_:* = _loc10_.ActivateOnEquip;
         var _loc13_:int = 0;
         var _loc15_:* = new XMLList("");
         this.defTags = _loc10_.ActivateOnEquip.(@stat == "21");
         var _loc6_:* = _loc4_.ActivateOnEquip;
         _loc9_ = new XMLList("");
         var _loc16_:* = _loc4_.ActivateOnEquip;
         var _loc17_:int = 0;
         _loc12_ = new XMLList("");
         this.otherDefTags = _loc4_.ActivateOnEquip.(@stat == "21");
         if(this.defTags.length() == 1 && this.otherDefTags.length() == 1) {
            _loc11_ = this.defTags.@amount;
            _loc8_ = this.otherDefTags.@amount;
         }
      }
      
      private function compareDefense(param1:int, param2:int) : String {
         var _loc3_:uint = getTextColor(param1 - param2);
         return wrapInColoredFont("+" + param1 + " Defense",_loc3_);
      }
   }
}
