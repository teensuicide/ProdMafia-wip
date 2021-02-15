package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
   import kabam.rotmg.text.model.TextKey;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   
   public class SealComparison extends SlotComparison {
       
      
      private var healingTag:XML;
      
      private var damageTag:XML;
      
      private var otherHealingTag:XML;
      
      private var otherDamageTag:XML;
      
      public function SealComparison() {
         super();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc3_:* = null;
         var _loc8_:* = param1;
         var _loc7_:* = param2;
         comparisonStringBuilder = new AppendingLineBuilder();
         this.healingTag = this.getEffectTag(_loc8_,"Healing");
         this.damageTag = this.getEffectTag(_loc8_,"Damaging");
         this.otherHealingTag = this.getEffectTag(_loc7_,"Healing");
         this.otherDamageTag = this.getEffectTag(_loc7_,"Damaging");
         if(this.canCompare()) {
            this.handleHealingText();
            this.handleDamagingText();
            if(_loc8_.@id == "Seal of Blasphemous Prayer") {
               _loc5_ = _loc8_.Activate;
               _loc6_ = 0;
               _loc4_ = new XMLList("");
               var _loc9_:* = _loc8_.Activate;
               var _loc10_:int = 0;
               var _loc12_:* = new XMLList("");
               _loc3_ = _loc8_.Activate.(text() == "ConditionEffectSelf")[0];
               comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
               comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
                  "effect":TextKey.wrapForTokenResolution("activeEffect.Invulnerable"),
                  "duration":_loc3_.@duration
               },TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
               processedTags[_loc3_.toXMLString()] = true;
            }
         }
      }
      
      private function canCompare() : Boolean {
         return this.healingTag != null && this.damageTag != null && this.otherHealingTag != null && this.otherDamageTag != null;
      }
      
      private function getEffectTag(param1:XML, param2:String) : XML {
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc8_:* = param1;
         var _loc4_:* = param2;
         var _loc9_:* = _loc8_.Activate;
         var _loc3_:* = new XMLList("");
         var _loc12_:* = _loc8_.Activate;
         var _loc13_:int = 0;
         var _loc15_:* = new XMLList("");
         _loc10_ = _loc8_.Activate.(text() == "ConditionEffectAura");
         var _loc6_:* = _loc10_;
         var _loc17_:int = 0;
         var _loc16_:* = _loc10_;
         for each(_loc11_ in _loc10_) {
            if(_loc11_.@effect == _loc4_) {
               return _loc11_;
            }
         }
         return null;
      }
      
      private function handleHealingText() : void {
         var _loc5_:int = this.healingTag.@duration;
         var _loc1_:int = this.otherHealingTag.@duration;
         var _loc3_:Number = this.healingTag.@range;
         var _loc2_:Number = this.otherHealingTag.@range;
         var _loc4_:Number = 0.5 * _loc5_ * 0.5 * _loc3_;
         var _loc8_:Number = 0.5 * _loc1_ * 0.5 * _loc2_;
         var _loc7_:uint = getTextColor(_loc4_ - _loc8_);
         var _loc6_:AppendingLineBuilder = new AppendingLineBuilder();
         _loc6_.pushParams("EquipmentToolTip.withinSqrs",{"range":this.healingTag.@range},TooltipHelper.getOpenTag(_loc7_),TooltipHelper.getCloseTag());
         _loc6_.pushParams("EquipmentToolTip.effectForDuration",{
            "effect":TextKey.wrapForTokenResolution("activeEffect.Healing"),
            "duration":_loc5_.toString()
         },TooltipHelper.getOpenTag(_loc7_),TooltipHelper.getCloseTag());
         comparisonStringBuilder.pushParams("EquipmentToolTip.partyEffect",{"effect":_loc6_});
         processedTags[this.healingTag.toXMLString()] = true;
      }
      
      private function handleDamagingText() : void {
         var _loc5_:int = this.damageTag.@duration;
         var _loc1_:int = this.otherDamageTag.@duration;
         var _loc3_:Number = this.damageTag.@range;
         var _loc2_:Number = this.otherDamageTag.@range;
         var _loc4_:Number = 0.5 * _loc5_ * 0.5 * _loc3_;
         var _loc8_:Number = 0.5 * _loc1_ * 0.5 * _loc2_;
         var _loc7_:uint = getTextColor(_loc4_ - _loc8_);
         var _loc6_:AppendingLineBuilder = new AppendingLineBuilder();
         _loc6_.pushParams("EquipmentToolTip.withinSqrs",{"range":this.damageTag.@range},TooltipHelper.getOpenTag(_loc7_),TooltipHelper.getCloseTag());
         _loc6_.pushParams("EquipmentToolTip.effectForDuration",{
            "effect":TextKey.wrapForTokenResolution("activeEffect.Damaging"),
            "duration":_loc5_.toString()
         },TooltipHelper.getOpenTag(_loc7_),TooltipHelper.getCloseTag());
         comparisonStringBuilder.pushParams("EquipmentToolTip.partyEffect",{"effect":_loc6_});
         processedTags[this.damageTag.toXMLString()] = true;
      }
   }
}
