package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
   import kabam.rotmg.text.model.TextKey;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   
   public class CloakComparison extends SlotComparison {
       
      
      public function CloakComparison() {
         super();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:* = null;
         var _loc5_:* = null;
         _loc4_ = this.getInvisibleTag(param1);
         _loc5_ = this.getInvisibleTag(param2);
         comparisonStringBuilder = new AppendingLineBuilder();
         if(_loc4_ != null && _loc5_ != null) {
            _loc3_ = _loc4_.@duration;
            _loc6_ = _loc5_.@duration;
            this.appendDurationText(_loc3_,_loc6_);
            processedTags[_loc4_.toXMLString()] = true;
         }
         this.handleExceptions(param1);
      }
      
      private function handleExceptions(param1:XML) : void {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:* = null;
         var _loc2_:* = param1;
         if(_loc2_.@id == "Cloak of the Planewalker") {
            comparisonStringBuilder.pushParams("EquipmentToolTip.teleportToTarget",{},TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
            _loc5_ = _loc2_.Activate;
            _loc6_ = 0;
            _loc4_ = new XMLList("");
            var _loc7_:* = _loc2_.Activate;
            var _loc8_:int = 0;
            var _loc10_:* = new XMLList("");
            _loc3_ = XML(_loc2_.Activate.(text() == "Teleport"))[0];
            processedTags[_loc3_.toXMLString()] = true;
         }
      }
      
      private function getInvisibleTag(param1:XML) : XML {
         var _loc8_:* = undefined;
         var _loc3_:int = 0;
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = param1;
         var _loc11_:* = _loc2_.Activate;
         var _loc7_:* = new XMLList("");
         var _loc12_:* = _loc2_.Activate;
         var _loc13_:int = 0;
         var _loc15_:* = new XMLList("");
         _loc10_ = _loc2_.Activate.(text() == "ConditionEffectSelf");
         var _loc6_:* = _loc10_;
         var _loc19_:int = 0;
         var _loc18_:* = _loc10_;
         for each(_loc4_ in _loc10_) {
            _loc8_ = _loc4_;
            _loc3_ = 0;
            _loc11_ = new XMLList("");
            var _loc16_:* = _loc4_;
            var _loc17_:int = 0;
            _loc12_ = new XMLList("");
            if(_loc4_.(@effect == "Invisible")) {
               return _loc4_;
            }
         }
         return null;
      }
      
      private function appendDurationText(param1:Number, param2:Number) : void {
         var _loc3_:uint = getTextColor(param1 - param2);
         comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
         comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
            "effect":TextKey.wrapForTokenResolution("activeEffect.Invisible"),
            "duration":param1.toString()
         },TooltipHelper.getOpenTag(_loc3_),TooltipHelper.getCloseTag());
      }
   }
}
