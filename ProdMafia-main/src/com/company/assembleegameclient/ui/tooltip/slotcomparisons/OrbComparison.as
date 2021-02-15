package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
   import kabam.rotmg.text.model.TextKey;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class OrbComparison extends SlotComparison {
       
      
      public function OrbComparison() {
         super();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:* = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         _loc4_ = this.getStasisBlastTag(param1);
         _loc3_ = this.getStasisBlastTag(param2);
         comparisonStringBuilder = new AppendingLineBuilder();
         if(_loc4_ != null && _loc3_ != null) {
            _loc5_ = _loc4_.@duration;
            _loc7_ = _loc3_.@duration;
            _loc6_ = uint(getTextColor(_loc5_ - _loc7_));
            comparisonStringBuilder.pushParams("EquipmentToolTip.stasisGroup",{"stasis":new LineBuilder().setParams("EquipmentToolTip.secsCount",{"duration":_loc5_}).setPrefix(TooltipHelper.getOpenTag(_loc6_)).setPostfix(TooltipHelper.getCloseTag())});
            processedTags[_loc4_.toXMLString()] = true;
            this.handleExceptions(param1);
         }
      }
      
      private function getStasisBlastTag(param1:XML) : XML {
         var _loc3_:* = null;
         var _loc2_:* = param1;
         var _loc5_:* = _loc2_.Activate;
         var _loc4_:* = new XMLList("");
         var _loc7_:* = _loc2_.Activate;
         var _loc8_:int = 0;
         var _loc10_:* = new XMLList("");
         _loc3_ = _loc2_.Activate.(text() == "StasisBlast");
         return _loc3_.length() == 1?_loc3_[0]:null;
      }
      
      private function handleExceptions(param1:XML) : void {
         var _loc9_:* = undefined;
         var _loc10_:int = 0;
         var _loc8_:* = undefined;
         var _loc3_:* = undefined;
         var _loc7_:int = 0;
         var _loc6_:* = undefined;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc12_:* = null;
         var _loc11_:* = param1;
         if(_loc11_.@id == "Orb of Conflict") {
            _loc9_ = _loc11_.Activate;
            _loc10_ = 0;
            _loc8_ = new XMLList("");
            var _loc13_:* = _loc11_.Activate;
            var _loc14_:int = 0;
            var _loc16_:* = new XMLList("");
            _loc4_ = _loc11_.Activate.(text() == "ConditionEffectSelf");
            _loc3_ = _loc4_;
            _loc7_ = 0;
            _loc9_ = new XMLList("");
            var _loc17_:* = _loc4_;
            var _loc18_:int = 0;
            _loc13_ = new XMLList("");
            _loc2_ = _loc4_.(@effect == "Speedy")[0];
            _loc6_ = _loc4_;
            _loc5_ = 0;
            _loc8_ = new XMLList("");
            var _loc19_:* = _loc4_;
            var _loc20_:int = 0;
            _loc16_ = new XMLList("");
            _loc12_ = _loc4_.(@effect == "Damaging")[0];
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
               "effect":TextKey.wrapForTokenResolution("activeEffect.Speedy"),
               "duration":_loc2_.@duration
            },TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
               "effect":TextKey.wrapForTokenResolution("activeEffect.Damaging"),
               "duration":_loc12_.@duration
            },TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
            processedTags[_loc2_.toXMLString()] = true;
            processedTags[_loc12_.toXMLString()] = true;
         }
      }
   }
}
