package com.company.assembleegameclient.ui.tooltip.slotcomparisons {
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.ui.tooltip.TooltipHelper;
import com.company.assembleegameclient.util.MathUtil;

import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   
   public class GeneralProjectileComparison extends SlotComparison {
       
      
      private var itemXML:XML;
      
      private var curItemXML:XML;
      
      private var projXML:XML;
      
      private var otherProjXML:XML;
      
      public function GeneralProjectileComparison() {
         super();
      }
      
      override protected function compareSlots(param1:XML, param2:XML) : void {
         this.itemXML = param1;
         this.curItemXML = param2;
         comparisonStringBuilder = new AppendingLineBuilder();
         if("NumProjectiles" in param1) {
            this.addNumProjectileText();
            processedTags[param1.NumProjectiles.toXMLString()] = true;
         }
         if("Projectile" in param1) {
            this.addProjectileText();
            processedTags[param1.Projectile.toXMLString()] = true;
         }
         this.buildRateOfFireText();
      }

      private function addProjectileText() : void {
         this.addDamageText();
         var range:Number = ObjectLibrary.propsLibrary_[this.projXML.@type].projectiles[0].calcMaxRange();
         var _loc2_:Number = MathUtil.round(range,2);
         var _loc1_:Number = MathUtil.round(this.otherProjXML ?
                 ObjectLibrary.propsLibrary_[this.otherProjXML.@type].projectiles[0].calcMaxRange() : range,2);
         var _loc3_:String = _loc2_.toFixed(2);
         comparisonStringBuilder.pushParams("EquipmentToolTip.range",{"range":wrapInColoredFont(_loc3_,getTextColor(_loc2_ - _loc1_))});
         if("MultiHit" in this.projXML) {
            comparisonStringBuilder.pushParams("GeneralProjectileComparison.multiHit",{},TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag());
         }
         if("PassesCover" in this.projXML) {
            comparisonStringBuilder.pushParams("GeneralProjectileComparison.passesCover",{},TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag());
         }
         if("ArmorPiercing" in this.projXML) {
            comparisonStringBuilder.pushParams("GeneralProjectileComparison.armorPiercing",{},TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag());
         }
      }
      
      private function addNumProjectileText() : void {
         var _loc2_:int = this.itemXML.NumProjectiles;
         var _loc1_:int = this.curItemXML.NumProjectiles;
         var _loc3_:uint = getTextColor(_loc2_ - _loc1_);
         comparisonStringBuilder.pushParams("EquipmentToolTip.shots",{"numShots":wrapInColoredFont(_loc2_.toString(),_loc3_)});
      }
      
      private function addDamageText() : void {
         this.projXML = XML(this.itemXML.Projectile);
         var _loc4_:int = this.projXML.MinDamage;
         var _loc1_:int = this.projXML.MaxDamage;
         var _loc3_:Number = (_loc1_ + _loc4_) / 2;
         this.otherProjXML = XML(this.curItemXML.Projectile);
         var _loc2_:int = this.otherProjXML.MinDamage;
         var _loc5_:int = this.otherProjXML.MaxDamage;
         var _loc7_:Number = (_loc5_ + _loc2_) / 2;
         var _loc6_:String = (_loc4_ == _loc1_?_loc4_:_loc4_ + " - " + _loc1_).toString();
         comparisonStringBuilder.pushParams("EquipmentToolTip.damage",{"damage":wrapInColoredFont(_loc6_,getTextColor(_loc3_ - _loc7_))});
      }
      
      private function buildRateOfFireText() : void {
         if(this.itemXML.RateOfFire.length() == 0 || this.curItemXML.RateOfFire.length() == 0) {
            return;
         }
         var _loc4_:Number = this.curItemXML.RateOfFire[0];
         var _loc1_:Number = this.itemXML.RateOfFire[0];
         var _loc3_:int = _loc1_ / _loc4_ * 100;
         var _loc5_:int = _loc3_ - 100;
         if(_loc5_ == 0) {
            return;
         }
         var _loc2_:uint = getTextColor(_loc5_);
         var _loc6_:String = _loc5_.toString();
         if(_loc5_ > 0) {
            _loc6_ = "+" + _loc6_;
         }
         _loc6_ = wrapInColoredFont(_loc6_ + "%",_loc2_);
         comparisonStringBuilder.pushParams("EquipmentToolTip.rateOfFire",{"data":_loc6_});
      }
   }
}
