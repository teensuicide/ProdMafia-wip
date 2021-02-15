package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import flash.utils.Dictionary;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   
   public class SlotComparison {
      
      static const BETTER_COLOR:uint = 65280;
      
      static const WORSE_COLOR:uint = 16711680;
      
      static const NO_DIFF_COLOR:uint = 16777103;
      
      static const LABEL_COLOR:uint = 11776947;
      
      static const UNTIERED_COLOR:uint = 9055202;
       
      
      public var processedTags:Dictionary;
      
      public var processedActivateOnEquipTags:AppendingLineBuilder;
      
      public var comparisonStringBuilder:AppendingLineBuilder;
      
      public function SlotComparison() {
         super();
      }
      
      public function compare(param1:XML, param2:XML) : void {
         this.resetFields();
         this.compareSlots(param1,param2);
      }
      
      protected function compareSlots(param1:XML, param2:XML) : void {
      }
      
      protected function getTextColor(param1:Number) : uint {
         if(param1 < 0) {
            return 16711680;
         }
         if(param1 > 0) {
            return 65280;
         }
         return 16777103;
      }
      
      protected function wrapInColoredFont(param1:String, param2:uint = 16777103) : String {
         return "<font color=\"#" + param2.toString(16) + "\">" + param1 + "</font>";
      }
      
      protected function getMpCostText(param1:String) : String {
         return this.wrapInColoredFont("MP Cost: ",11776947) + this.wrapInColoredFont(param1,16777103) + "\n";
      }
      
      private function resetFields() : void {
         this.processedTags = new Dictionary();
         this.processedActivateOnEquipTags = new AppendingLineBuilder();
      }
   }
}
