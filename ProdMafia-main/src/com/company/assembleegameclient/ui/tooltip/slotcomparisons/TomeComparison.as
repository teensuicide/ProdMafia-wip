package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
   import kabam.rotmg.text.model.TextKey;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class TomeComparison extends SlotComparison {
       
      
      public function TomeComparison() {
         super();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _loc15_:* = undefined;
         var _loc23_:int = 0;
         var _loc21_:* = undefined;
         var _loc19_:int = 0;
         var _loc9_:* = null;
         var _loc7_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc3_:* = null;
         var _loc10_:* = null;
         var _loc12_:* = null;
         var _loc14_:* = param1;
         var _loc5_:* = param2;
         var _loc8_:* = _loc14_.Activate;
         var _loc4_:* = new XMLList("");
         var _loc24_:* = _loc14_.Activate;
         var _loc25_:int = 0;
         var _loc27_:* = new XMLList("");
         _loc10_ = _loc14_.Activate.(text() == "HealNova");
         var _loc13_:* = _loc5_.Activate;
         _loc8_ = new XMLList("");
         var _loc28_:* = _loc5_.Activate;
         var _loc29_:int = 0;
         _loc24_ = new XMLList("");
         _loc12_ = _loc5_.Activate.(text() == "HealNova");
         comparisonStringBuilder = new AppendingLineBuilder();
         if(_loc10_.length() == 1 && _loc12_.length() == 1) {
            if("@damage" in _loc10_ && int(_loc10_.@damage) > 0) {
               comparisonStringBuilder.pushParams(TooltipHelper.wrapInFontTag("{damage} damage within {range} sqrs","#" + (16777103).toString(16)),{
                  "damage":_loc10_.@damage,
                  "range":_loc10_.@range
               });
            }
            _loc7_ = _loc10_.@range;
            _loc18_ = _loc12_.@range;
            _loc22_ = _loc10_.@amount;
            _loc11_ = _loc12_.@amount;
            _loc17_ = 0.5 * _loc7_ + 0.5 * _loc22_;
            _loc20_ = 0.5 * _loc18_ + 0.5 * _loc11_;
            _loc3_ = new LineBuilder().setParams("EquipmentToolTip.partyHealAmount",{
               "amount":_loc22_.toString(),
               "range":_loc7_.toString()
            }).setPrefix(TooltipHelper.getOpenTag(getTextColor(_loc17_ - _loc20_))).setPostfix(TooltipHelper.getCloseTag());
            comparisonStringBuilder.pushParams("EquipmentToolTip.partyHeal",{"effect":_loc3_});
            processedTags[_loc10_.toXMLString()] = true;
         }
         if(_loc14_.@id == "Tome of Purification") {
            _loc15_ = _loc14_.Activate;
            _loc23_ = 0;
            _loc4_ = new XMLList("");
            var _loc30_:* = _loc14_.Activate;
            var _loc31_:int = 0;
            _loc27_ = new XMLList("");
            _loc9_ = _loc14_.Activate.(text() == "RemoveNegativeConditions")[0];
            comparisonStringBuilder.pushParams("EquipmentToolTip.removesNegative",{},TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
            processedTags[_loc9_.toXMLString()] = true;
         } else if(_loc14_.@id == "Tome of Holy Protection") {
            _loc21_ = _loc14_.Activate;
            _loc19_ = 0;
            _loc13_ = new XMLList("");
            var _loc32_:* = _loc14_.Activate;
            var _loc33_:int = 0;
            _loc28_ = new XMLList("");
            _loc9_ = _loc14_.Activate.(text() == "ConditionEffectSelf")[0];
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
               "effect":TextKey.wrapForTokenResolution("activeEffect.Armored"),
               "duration":_loc9_.@duration
            },TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
            processedTags[_loc9_.toXMLString()] = true;
         }
      }
   }
}
