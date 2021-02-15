package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
   import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
   import kabam.rotmg.text.model.TextKey;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   
   public class HelmetComparison extends SlotComparison {
       
      
      private var berserk:XML;
      
      private var speedy:XML;
      
      private var otherBerserk:XML;
      
      private var otherSpeedy:XML;
      
      private var armored:XML;
      
      private var otherArmored:XML;
      
      public function HelmetComparison() {
         super();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         this.extractDataFromXML(param1,param2);
         comparisonStringBuilder = new AppendingLineBuilder();
         this.handleBerserk();
         this.handleSpeedy();
         this.handleArmored();
      }
      
      private function extractDataFromXML(param1:XML, param2:XML) : void {
         this.berserk = this.getAuraTagByType(param1,"Berserk");
         this.speedy = this.getSelfTagByType(param1,"Speedy");
         this.armored = this.getSelfTagByType(param1,"Armored");
         this.otherBerserk = this.getAuraTagByType(param2,"Berserk");
         this.otherSpeedy = this.getSelfTagByType(param2,"Speedy");
         this.otherArmored = this.getSelfTagByType(param2,"Armored");
      }
      
      private function getAuraTagByType(param1:XML, param2:String) : XML {
         var _loc4_:* = null;
         var _loc10_:* = null;
         var _loc8_:* = param1;
         var _loc11_:* = param2;
         var _loc9_:* = _loc8_.Activate;
         var _loc3_:* = new XMLList("");
         var _loc12_:* = _loc8_.Activate;
         var _loc13_:int = 0;
         var _loc15_:* = new XMLList("");
         _loc4_ = _loc8_.Activate.(text() == "ConditionEffectAura");
         var _loc6_:* = _loc4_;
         var _loc17_:int = 0;
         var _loc16_:* = _loc4_;
         for each(_loc10_ in _loc4_) {
            if(_loc10_.@effect == _loc11_) {
               return _loc10_;
            }
         }
         return null;
      }
      
      private function getSelfTagByType(param1:XML, param2:String) : XML {
         var _loc4_:* = null;
         var _loc10_:* = null;
         var _loc8_:* = param1;
         var _loc11_:* = param2;
         var _loc9_:* = _loc8_.Activate;
         var _loc3_:* = new XMLList("");
         var _loc12_:* = _loc8_.Activate;
         var _loc13_:int = 0;
         var _loc15_:* = new XMLList("");
         _loc4_ = _loc8_.Activate.(text() == "ConditionEffectSelf");
         var _loc6_:* = _loc4_;
         var _loc17_:int = 0;
         var _loc16_:* = _loc4_;
         for each(_loc10_ in _loc4_) {
            if(_loc10_.@effect == _loc11_) {
               return _loc10_;
            }
         }
         return null;
      }
      
      private function handleBerserk() : void {
         if(this.berserk == null || this.otherBerserk == null) {
            return;
         }
         var _loc5_:Number = this.berserk.@range;
         var _loc1_:Number = this.otherBerserk.@range;
         var _loc3_:Number = this.berserk.@duration;
         var _loc2_:Number = this.otherBerserk.@duration;
         var _loc4_:Number = 0.5 * _loc5_ + 0.5 * _loc3_;
         var _loc8_:Number = 0.5 * _loc1_ + 0.5 * _loc2_;
         var _loc7_:uint = getTextColor(_loc4_ - _loc8_);
         var _loc6_:AppendingLineBuilder = new AppendingLineBuilder();
         _loc6_.pushParams("EquipmentToolTip.withinSqrs",{"range":_loc5_.toString()},TooltipHelper.getOpenTag(_loc7_),TooltipHelper.getCloseTag());
         _loc6_.pushParams("EquipmentToolTip.effectForDuration",{
            "effect":TextKey.wrapForTokenResolution("activeEffect.Berserk"),
            "duration":_loc3_.toString()
         },TooltipHelper.getOpenTag(_loc7_),TooltipHelper.getCloseTag());
         comparisonStringBuilder.pushParams("EquipmentToolTip.partyEffect",{"effect":_loc6_});
         processedTags[this.berserk.toXMLString()] = true;
      }
      
      private function handleSpeedy() : void {
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         if(this.speedy != null && this.otherSpeedy != null) {
            _loc2_ = this.speedy.@duration;
            _loc1_ = this.otherSpeedy.@duration;
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
               "effect":TextKey.wrapForTokenResolution("activeEffect.Speedy"),
               "duration":_loc2_.toString()
            },TooltipHelper.getOpenTag(getTextColor(_loc2_ - _loc1_)),TooltipHelper.getCloseTag());
            processedTags[this.speedy.toXMLString()] = true;
         } else if(this.speedy != null && this.otherSpeedy == null) {
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
               "effect":TextKey.wrapForTokenResolution("activeEffect.Speedy"),
               "duration":this.speedy.@duration
            },TooltipHelper.getOpenTag(65280),TooltipHelper.getCloseTag());
            processedTags[this.speedy.toXMLString()] = true;
         }
      }
      
      private function handleArmored() : void {
         if(this.armored != null) {
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectOnSelf",{"effect":""});
            comparisonStringBuilder.pushParams("EquipmentToolTip.effectForDuration",{
               "effect":TextKey.wrapForTokenResolution("activeEffect.Armored"),
               "duration":this.armored.@duration
            },TooltipHelper.getOpenTag(9055202),TooltipHelper.getCloseTag());
            processedTags[this.armored.toXMLString()] = true;
         }
      }
   }
}
