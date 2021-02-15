package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.game.events.KeyInfoResponseSignal;
import com.company.assembleegameclient.objects.ForgeProperties;
import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.LineBreakDesign;
   import com.company.assembleegameclient.util.FilterUtil;
   import com.company.assembleegameclient.util.MathUtil;
import com.company.assembleegameclient.util.TextureRedrawer;
import com.company.assembleegameclient.util.TierUtil;
import com.company.util.AssetLibrary;
import com.company.util.BitmapUtil;
   import com.company.util.KeyCodes;

import flash.display.Bitmap;
import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.filters.DropShadowFilter;
   import flash.utils.Dictionary;
   import io.decagames.rotmg.ui.labels.UILabel;
   import kabam.rotmg.messaging.impl.data.StatData;
   import kabam.rotmg.messaging.impl.incoming.KeyInfoResponse;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   
   public class EquipmentToolTip extends ToolTip {
      
      private static const MAX_WIDTH:int = 230;
      
      public static var keyInfo:Dictionary = new Dictionary();
       
      
      public var titleText:TextFieldDisplayConcrete;
      
      public var player:Player;
      
      private var icon:Bitmap;
      
      private var tierText:UILabel;
      
      private var descText:TextFieldDisplayConcrete;
      
      private var line1:LineBreakDesign;
      
      private var effectsText:TextFieldDisplayConcrete;
      
      private var line2:LineBreakDesign;
      
      private var line3:LineBreakDesign;
      
      private var restrictionsText:TextFieldDisplayConcrete;
      
      private var setInfoText:TextFieldDisplayConcrete;
      
      private var isEquippable:Boolean = false;
      
      private var objectType:int;
      
      private var titleOverride:String;
      
      private var descriptionOverride:String;
      
      private var curItemXML:XML = null;
      
      private var objectXML:XML = null;
      
      private var slotTypeToTextBuilder:SlotComparisonFactory;
      
      private var restrictions:Vector.<Restriction>;
      
      private var setInfo:Vector.<Effect>;
      
      private var effects:Vector.<Effect>;
      
      private var uniqueEffects:Vector.<Effect>;
      
      private var itemSlotTypeId:int;
      
      private var invType:int;
      
      private var inventoryOwnerType:String;
      
      private var isInventoryFull:Boolean;
      
      private var playerCanUse:Boolean;
      
      private var comparisonResults:SlotComparisonResult;
      
      private var powerText:TextFieldDisplayConcrete;
      
      private var supporterPointsText:TextFieldDisplayConcrete;

      private var quickSlotAllowedText:TextFieldDisplayConcrete;
      
      private var keyInfoResponse:KeyInfoResponseSignal;
      
      private var originalObjectType:int;
      
      private var sameActivateEffect:Boolean;
      
      private var itemIDText:TextFieldDisplayConcrete;

      private var commonMaterialIcon:Bitmap,
                  rareMaterialIcon:Bitmap,
                  legendaryMaterialIcon:Bitmap;
      private var commonMaterialText:TextFieldDisplayConcrete,
                  rareMaterialText:TextFieldDisplayConcrete,
                  legendaryMaterialText:TextFieldDisplayConcrete;

      public function EquipmentToolTip(param1:int, param2:Player, param3:int, param4:String) {
         var _loc5_:Boolean = false;
         uniqueEffects = new Vector.<Effect>();
         this.objectType = param1;
         this.originalObjectType = this.objectType;
         this.player = param2;
         this.invType = param3;
         this.inventoryOwnerType = param4;
         this.isInventoryFull = !!param2?param2.isInventoryFull():false;
         this.playerCanUse = !!param2?ObjectLibrary.isUsableByPlayer(this.objectType,param2):false;
         var _loc7_:int = this.playerCanUse || this.player == null?3552822:6036765;
         var _loc6_:int = this.playerCanUse || param2 == null?10197915:10965039;
         super(_loc7_,1,_loc6_,1,true);
         var _loc8_:int = !!param2?ObjectLibrary.getMatchingSlotIndex(this.objectType,param2):-1;
         this.slotTypeToTextBuilder = new SlotComparisonFactory();
         this.objectXML = ObjectLibrary.xmlLibrary_[this.objectType];
         if(!this.objectXML) {
            this.objectXML = ObjectLibrary.xmlLibrary_[3141];
         }
         this.isEquippable = _loc8_ != -1;
         this.setInfo = new Vector.<Effect>();
         this.effects = new Vector.<Effect>();
         this.itemSlotTypeId = this.objectXML.SlotType;
         this.itemSlotTypeId = this.objectXML.SlotType;
         if(this.player) {
            if(this.isEquippable) {
               if(this.player.equipment_[_loc8_] != -1) {
                  this.curItemXML = ObjectLibrary.xmlLibrary_[this.player.equipment_[_loc8_]];
               }
            } else {
               _loc5_ = false;
               if("Tex1" in objectXML) {
                  param2.fakeTex1 = this.objectXML.Tex1;
                  _loc5_ = true;
               }
               if("Tex2" in objectXML) {
                  param2.fakeTex2 = this.objectXML.Tex2;
                  _loc5_ = true;
               }
               if(_loc5_) {
                  param2.clearTextureCache();
               }
            }
         } else {
            this.curItemXML = this.objectXML;
         }
         this.addIcon();
         this.addTitle();
         this.addDescriptionText();
         this.addTierText();
         this.handleWisMod();
         this.buildCategorySpecificText();
         this.addUniqueEffectsToList();
         this.sameActivateEffect = false;
         this.addActivateTagsToEffectsList();
         this.addForgefireReductionToEffectsList();
         this.addNumProjectiles();
         this.addProjectileTagsToEffectsList();
         this.addRateOfFire();
         this.addActivateOnEquipTagsToEffectsList();
         this.addDoseTagsToEffectsList();
         this.addMpCostTagToEffectsList();
         this.addXpBonusTagToEffectsList();
         this.addCooldown();
         this.addSetInfo();
         this.makeSetInfoText();
         this.makeEffectsList();
         this.makeLineTwo();
         this.makeRestrictionList();
         this.makeRestrictionText();
         this.makeItemPowerText();
         this.makeSupporterPointsText();
         this.makeQuickSlotText();
         this.addMaterialInfo();
      }
      
      override protected function alignUI() : void {
         this.icon.width;
         this.icon.height;
         this.titleText.x = this.icon.width + 4;
         this.titleText.y = this.icon.height / 2 - this.titleText.height / 2;
         if(this.tierText) {
            this.tierText.y = this.icon.height / 2 - this.tierText.height / 2;
            this.tierText.x = 200;
         }
         this.descText.x = 4;
         this.descText.y = this.icon.height + 2;
         this.descText.y;
         this.descText.height;
         if(contains(this.line1)) {
            this.line1.x = 8;
            this.line1.y = this.descText.y + this.descText.height + 8;
            this.line1.y;
            this.effectsText.x = 4;
            this.effectsText.y = this.line1.y + 8;
            this.effectsText.y;
            this.effectsText.height;
         } else {
            this.line1.y = this.descText.y + this.descText.height;
            this.line1.y;
            this.effectsText.y = this.line1.y;
            this.effectsText.y;
            this.effectsText.height;
         }
         if(this.setInfoText) {
            this.line3.x = 8;
            this.line3.y = this.effectsText.y + this.effectsText.height + 8;
            this.line3.y;
            this.setInfoText.x = 4;
            this.setInfoText.y = this.line3.y + 8;
            this.setInfoText.y;
            this.setInfoText.height;
            this.line2.x = 8;
            this.line2.y = this.setInfoText.y + this.setInfoText.height + 8;
         } else {
            this.line2.x = 8;
            this.line2.y = this.effectsText.y + this.effectsText.height + 8;
            this.line2.y;
         }
         var curY:uint = this.line2.y + 8;
         if(this.restrictionsText) {
            this.restrictionsText.x = 4;
            this.restrictionsText.y = curY;
            this.restrictionsText.height;
            curY = curY + this.restrictionsText.height;
         }
         if(this.powerText) {
            if(contains(this.powerText)) {
               this.powerText.x = 4;
               this.powerText.y = curY;
               this.powerText.height;
               curY = curY + this.powerText.height;
            }
         }
         if(this.quickSlotAllowedText) {
            if(contains(this.quickSlotAllowedText)) {
               this.quickSlotAllowedText.x = 4;
               this.quickSlotAllowedText.y = curY;
               this.quickSlotAllowedText.height;
               curY = curY + this.quickSlotAllowedText.height;
            }
         }
         if(this.supporterPointsText) {
            if(contains(this.supporterPointsText)) {
               this.supporterPointsText.x = 4;
               this.supporterPointsText.y = curY;
               this.supporterPointsText.height;
               curY = curY + this.supporterPointsText.height;
            }
         }

         var curX:int = 4;
         if (this.commonMaterialIcon) {
            if (contains(this.commonMaterialIcon)) {
               this.commonMaterialIcon.x = curX - 10;
               this.commonMaterialIcon.y = curY - 13;
               curX += this.commonMaterialIcon.width - 15;
            }
         }

         if (this.commonMaterialText) {
            if (contains(this.commonMaterialText)) {
               this.commonMaterialText.x = curX;
               this.commonMaterialText.y = curY;
               this.commonMaterialText.height;
               curX += this.commonMaterialText.width + 10;
            }
         }

         if (this.rareMaterialIcon) {
            if (contains(this.rareMaterialIcon)) {
               this.rareMaterialIcon.x = curX - 10;
               this.rareMaterialIcon.y = curY - 13;
               curX += this.rareMaterialIcon.width - 15;
            }
         }

         if (this.rareMaterialText) {
            if (contains(this.rareMaterialText)) {
               this.rareMaterialText.x = curX;
               this.rareMaterialText.y = curY;
               this.rareMaterialText.height;
               curX += this.rareMaterialText.width + 10;
            }
         }

         if (this.legendaryMaterialIcon) {
            if (contains(this.legendaryMaterialIcon)) {
               this.legendaryMaterialIcon.x = curX - 10;
               this.legendaryMaterialIcon.y = curY - 13;
               curX += this.legendaryMaterialIcon.width - 15;
            }
         }

         if (this.legendaryMaterialText) {
            if (contains(this.legendaryMaterialText)) {
               this.legendaryMaterialText.x = curX;
               this.legendaryMaterialText.y = curY;
               this.legendaryMaterialText.height;
            }
         }
      }
      
      private function makeItemIDText() : void {
         var _loc1_:int = this.playerCanUse || this.player == null?16777215:16549442;
         this.itemIDText = new TextFieldDisplayConcrete().setSize(12).setColor(_loc1_).setBold(true);
         this.itemIDText.setStringBuilder(new StaticStringBuilder().setString("Item ID: " + this.objectType));
         this.itemIDText.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         addChild(this.itemIDText);
      }
      
      private function addSetInfo() : void {
         if(!this.objectXML.hasOwnProperty("@setType")) {
            return;
         }
         var _loc1_:int = this.objectXML.attribute("setType");
         this.setInfo.push(new Effect("{name} ",{"name":"<b>" + this.objectXML.attribute("setName") + "</b>"}).setColor(16750848).setReplacementsColor(16750848));
         this.addSetActivateOnEquipTagsToEffectsList(_loc1_);
      }
      
      private function addSetActivateOnEquipTagsToEffectsList(param1:int) : void {
         var _loc15_:int = 0;
         var _loc16_:* = undefined;
         var _loc8_:int = 0;
         var _loc14_:* = undefined;
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc3_:* = null;
         var _loc7_:* = 0;
         var _loc12_:* = 0;
         var _loc11_:* = null;
         var _loc5_:* = null;
         var _loc10_:* = null;
         var _loc9_:int = 0;
         var _loc2_:XML = ObjectLibrary.getSetXMLFromType(param1);
         var _loc13_:* = _loc2_.Setpiece;
         var _loc19_:int = 0;
         var _loc18_:* = _loc2_.Setpiece;
         for each(_loc3_ in _loc2_.Setpiece) {
            if(_loc3_.toString() == "Equipment") {
               if(this.player != null && this.player.equipment_[int(_loc3_.@slot)] == int(_loc3_.@itemtype)) {
                  _loc9_++;
               }
            }
         }
         _loc7_ = 6835752;
         _loc12_ = 16777103;
         if(_loc2_.hasOwnProperty("ActivateOnEquip2")) {
            _loc7_ = uint(_loc9_ >= 2?16750848:6835752);
            _loc12_ = uint(_loc9_ >= 2?16777103:6842444);
            this.setInfo.push(new Effect("2 Pieces",null).setColor(_loc7_).setReplacementsColor(_loc7_));
            _loc15_ = 0;
            _loc16_ = _loc2_.ActivateOnEquip2;
            var _loc21_:int = 0;
            var _loc20_:* = _loc2_.ActivateOnEquip2;
            for each(_loc11_ in _loc2_.ActivateOnEquip2) {
               this.makeSetEffectLine(_loc11_,_loc12_);
            }
         }
         if(_loc2_.hasOwnProperty("ActivateOnEquip3")) {
            _loc7_ = uint(_loc9_ >= 3?16750848:6835752);
            _loc12_ = uint(_loc9_ >= 3?16777103:6842444);
            this.setInfo.push(new Effect("3 Pieces",null).setColor(_loc7_).setReplacementsColor(_loc7_));
            _loc8_ = 0;
            _loc14_ = _loc2_.ActivateOnEquip3;
            var _loc23_:int = 0;
            var _loc22_:* = _loc2_.ActivateOnEquip3;
            for each(_loc5_ in _loc2_.ActivateOnEquip3) {
               this.makeSetEffectLine(_loc5_,_loc12_);
            }
         }
         if(_loc2_.hasOwnProperty("ActivateOnEquipAll")) {
            _loc7_ = uint(_loc9_ >= 4?16750848:6835752);
            _loc12_ = uint(_loc9_ >= 4?16777103:6842444);
            this.setInfo.push(new Effect("Full Set",null).setColor(_loc7_).setReplacementsColor(_loc7_));
            _loc4_ = 0;
            _loc6_ = _loc2_.ActivateOnEquipAll;
            var _loc25_:int = 0;
            var _loc24_:* = _loc2_.ActivateOnEquipAll;
            for each(_loc10_ in _loc2_.ActivateOnEquipAll) {
               this.makeSetEffectLine(_loc10_,_loc12_);
            }
         }
      }
      
      private function makeSetEffectLine(param1:XML, param2:uint) : void {
         if(param1.toString() == "IncrementStat") {
            this.setInfo.push(new Effect("EquipmentToolTip.incrementStat",this.getComparedStatText(param1)).setColor(param2).setReplacementsColor(param2));
         }
      }
      
      private function makeItemPowerText() : void {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(this.objectXML.hasOwnProperty("feedPower")) {
            _loc2_ = this.objectXML.feedPower;
            _loc1_ = this.playerCanUse || this.player == null?16777215:16549442;
            this.powerText = new TextFieldDisplayConcrete().setSize(12).setColor(_loc1_).setBold(true).setTextWidth(230 - this.icon.width - 4 - 30).setWordWrap(true);
            this.powerText.setStringBuilder(new StaticStringBuilder().setString("Feed Power: " + _loc2_));
            this.powerText.filters = FilterUtil.getStandardDropShadowFilter();
            waiter.push(this.powerText.textChanged);
            addChild(this.powerText);
         }
      }
      
      private function makeSupporterPointsText() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = this.objectXML.Activate;
         var _loc6_:int = 0;
         var _loc5_:* = this.objectXML.Activate;
         for each(_loc1_ in this.objectXML.Activate) {
            _loc3_ = _loc1_.toString();
            if(_loc3_ == "GrantSupporterPoints") {
               this.supporterPointsText = new TextFieldDisplayConcrete().setSize(12).setColor(16777215).setBold(true).setTextWidth(230 - this.icon.width - 4 - 30).setWordWrap(true);
               this.supporterPointsText.setStringBuilder(new StaticStringBuilder().setString("Campaign points: " + _loc1_.@amount));
               this.supporterPointsText.filters = FilterUtil.getStandardDropShadowFilter();
               waiter.push(this.supporterPointsText.textChanged);
               addChild(this.supporterPointsText);
            }
         }
      }

      private function makeQuickSlotText() : void {
         if (this.objectXML.hasOwnProperty("QuickslotAllowed")) {
            this.quickSlotAllowedText = new TextFieldDisplayConcrete().setSize(12).setColor(16777215).setBold(true).setTextWidth(230 - this.icon.width - 4 - 30).setWordWrap(true);
            this.quickSlotAllowedText.setStringBuilder(new StaticStringBuilder().setString("Max quick slot count: " + this.objectXML.QuickslotAllowed.@maxstack));
            this.quickSlotAllowedText.filters = FilterUtil.getStandardDropShadowFilter();
            waiter.push(this.quickSlotAllowedText.textChanged);
            addChild(this.quickSlotAllowedText);
         }
      }

      private function addMaterialInfo() : void {
         var forgeProps:ForgeProperties = ObjectLibrary.forgePropsLibrary[int(this.objectXML.@type)];
         if (forgeProps && forgeProps.objType != -1) {
            if (forgeProps.commonResourceGain > 0) {
               var bmpd:BitmapData = BitmapUtil.cropToBitmapData(
                       AssetLibrary.getImage("material_common"), 4, 4, 8, 8);
               this.commonMaterialIcon = new Bitmap(TextureRedrawer.redraw(
                       bmpd, 40, false, 0));
               addChild(this.commonMaterialIcon);

               this.commonMaterialText = new TextFieldDisplayConcrete()
                       .setSize(12)
                       .setColor(0xFFFFFF)
                       .setBold(true);
               this.commonMaterialText.setStringBuilder(new StaticStringBuilder().setString(forgeProps.commonResourceGain.toString()));
               this.commonMaterialText.filters = FilterUtil.getStandardDropShadowFilter();
               waiter.push(this.commonMaterialText.textChanged);
               addChild(this.commonMaterialText);
            }

            if (forgeProps.rareResourceGain > 0) {
               var bmpd:BitmapData = BitmapUtil.cropToBitmapData(
                       AssetLibrary.getImage("material_rare"), 4, 4, 8, 8);
               this.rareMaterialIcon = new Bitmap(TextureRedrawer.redraw(
                       bmpd, 40, false, 0));
               addChild(this.rareMaterialIcon);

               this.rareMaterialText = new TextFieldDisplayConcrete()
                       .setSize(12)
                       .setColor(0xFFFFFF)
                       .setBold(true);
               this.rareMaterialText.setStringBuilder(new StaticStringBuilder().setString(forgeProps.rareResourceGain.toString()));
               this.rareMaterialText.filters = FilterUtil.getStandardDropShadowFilter();
               waiter.push(this.rareMaterialText.textChanged);
               addChild(this.rareMaterialText);
            }

            if (forgeProps.legendaryResourceGain > 0) {
               var bmpd:BitmapData = BitmapUtil.cropToBitmapData(
                       AssetLibrary.getImage("material_legendary"), 4, 4, 8, 8);
               this.legendaryMaterialIcon = new Bitmap(TextureRedrawer.redraw(
                       bmpd, 40, false, 0));
               addChild(this.legendaryMaterialIcon);

               this.legendaryMaterialText = new TextFieldDisplayConcrete()
                       .setSize(12)
                       .setColor(0xFFFFFF)
                       .setBold(true);
               this.legendaryMaterialText.setStringBuilder(new StaticStringBuilder().setString(forgeProps.legendaryResourceGain.toString()));
               this.legendaryMaterialText.filters = FilterUtil.getStandardDropShadowFilter();
               waiter.push(this.legendaryMaterialText.textChanged);
               addChild(this.legendaryMaterialText);
            }
         }
      }
      
      private function addUniqueEffectsToList() : void {
         var _loc3_:* = null;
         var _loc1_:XML = null;
         var _loc2_:XMLList = null;
         var _loc5_:XMLList = null;
         var _loc6_:String = null;
         var _loc4_:AppendingLineBuilder = null;
         if(this.objectXML.hasOwnProperty("ExtraTooltipData")) {
            _loc3_ = this.objectXML.ExtraTooltipData.EffectInfo;
            var _loc8_:int = 0;
            var _loc7_:* = _loc3_;
            for each(_loc1_ in _loc3_) {
               _loc2_ = _loc1_.attribute("name");
               _loc5_ = _loc1_.attribute("description");
               _loc6_ = _loc2_.toString() != "" && _loc5_.toString() != ""?": ":"";
               _loc4_ = new AppendingLineBuilder();
               if(_loc2_) {
                  _loc4_.pushParams(_loc2_);
               }
               if(_loc5_) {
                  _loc4_.pushParams(_loc5_,{},TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag());
               }
               _loc4_.setDelimiter(_loc6_);
               this.uniqueEffects.push(new Effect("blank",{"data":_loc4_}));
            }
         }
      }
      
      private function isEmptyEquipSlot() : Boolean {
         return this.isEquippable && this.curItemXML == null;
      }
      
      private function addIcon() : void {
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[this.objectType];
         if(!_loc1_) {
            _loc1_ = ObjectLibrary.xmlLibrary_[3141];
         }
         var _loc3_:int = 5;
         if(this.objectType == 4874 || this.objectType == 4618) {
            _loc3_ = 8;
         }
         if(_loc1_.hasOwnProperty("ScaleValue")) {
            _loc3_ = _loc1_.ScaleValue;
         }
         var _loc2_:BitmapData = ObjectLibrary.getRedrawnTextureFromType(this.objectType,60,true,true,_loc3_);
         _loc2_ = BitmapUtil.cropToBitmapData(_loc2_,4,4,_loc2_.width - 8,_loc2_.height - 8);
         this.icon = new Bitmap(_loc2_);
         addChild(this.icon);
      }
      
      private function addTierText() : void {
         this.tierText = TierUtil.getTierTag(this.objectXML,16);
         if(this.tierText) {
            addChild(this.tierText);
         }
      }
      
      private function isPet() : Boolean {
         var _loc3_:* = null;
         var _loc1_:* = this.objectXML.Activate;
         var _loc4_:* = new XMLList("");
         var _loc5_:* = this.objectXML.Activate;
         var _loc6_:int = 0;
         var _loc8_:* = new XMLList("");
         _loc3_ = this.objectXML.Activate.(text() == "PermaPet");
         return _loc3_.length() >= 1;
      }
      
      private function removeTitle() : void {
         removeChild(this.titleText);
      }
      
      private function removeDesc() : void {
         removeChild(this.descText);
      }
      
      private function addTitle() : void {
         var _loc1_:int = this.playerCanUse || this.player == null?16777215:16549442;
         this.titleText = new TextFieldDisplayConcrete().setSize(16).setColor(_loc1_).setBold(true).setTextWidth(230 - this.icon.width - 4 - 30).setWordWrap(true);
         if(this.titleOverride) {
            this.titleText.setStringBuilder(new StaticStringBuilder(this.titleOverride));
         } else {
            this.titleText.setStringBuilder(new LineBuilder().setParams(ObjectLibrary.typeToDisplayId_[this.objectType]));
         }
         this.titleText.filters = FilterUtil.getStandardDropShadowFilter();
         waiter.push(this.titleText.textChanged);
         addChild(this.titleText);
      }
      
      private function buildUniqueTooltipData() : String {
         var _loc5_:int = 0;
         var _loc4_:* = undefined;
         var _loc1_:* = undefined;
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(this.objectXML.hasOwnProperty("ExtraTooltipData")) {
            _loc3_ = this.objectXML.ExtraTooltipData.EffectInfo;
            _loc1_ = new Vector.<Effect>();
            _loc5_ = 0;
            _loc4_ = _loc3_;
            var _loc7_:int = 0;
            var _loc6_:* = _loc3_;
            for each(_loc2_ in _loc3_) {
               _loc1_.push(new Effect(_loc2_.attribute("name"),_loc2_.attribute("description")));
            }
         }
         return "";
      }
      
      private function makeEffectsList() : void {
         var _loc1_:* = null;
         if(this.effects.length != 0 || this.comparisonResults.lineBuilder != null || this.objectXML.hasOwnProperty("ExtraTooltipData")) {
            this.line1 = new LineBreakDesign(218,0);
            this.effectsText = new TextFieldDisplayConcrete().setSize(14).setColor(11776947).setTextWidth(230).setWordWrap(true).setHTML(true);
            _loc1_ = this.getEffectsStringBuilder();
            this.effectsText.setStringBuilder(_loc1_);
            this.effectsText.filters = FilterUtil.getStandardDropShadowFilter();
            if(_loc1_.hasLines()) {
               addChild(this.line1);
               addChild(this.effectsText);
               waiter.push(this.effectsText.textChanged);
            }
         }
      }
      
      private function getEffectsStringBuilder() : AppendingLineBuilder {
         var _loc1_:AppendingLineBuilder = new AppendingLineBuilder();
         this.appendEffects(this.uniqueEffects,_loc1_);
         if(this.comparisonResults.lineBuilder.hasLines()) {
            _loc1_.pushParams("blank",{"data":this.comparisonResults.lineBuilder});
         }
         this.appendEffects(this.effects,_loc1_);
         return _loc1_;
      }
      
      private function appendEffects(param1:Vector.<Effect>, param2:AppendingLineBuilder) : void {
         var _loc3_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = param1;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(_loc3_ in param1) {
            _loc6_ = "";
            _loc7_ = "";
            if(_loc3_.color_) {
               _loc6_ = "<font color=\"#" + _loc3_.color_.toString(16) + "\">";
               _loc7_ = "</font>";
            }
            param2.pushParams(_loc3_.name_,_loc3_.getValueReplacementsWithColor(),_loc6_,_loc7_);
         }
      }
      
      private function addXpBonusTagToEffectsList() : void {
         var _loc3_:int = 0;
         var _loc1_:* = 0;
         var _loc2_:int = 0;
         if(this.objectXML.hasOwnProperty("XPBonus")) {
            _loc3_ = this.objectXML.XPBonus;
            _loc1_ = uint(!!this.playerCanUse?65280:16777103);
            if(this.curItemXML != null && this.curItemXML.hasOwnProperty("XPBonus")) {
               _loc2_ = this.curItemXML.XPBonus.text();
               _loc1_ = uint(TooltipHelper.getTextColor(_loc3_ - _loc2_));
            }
            this.effects.push(new Effect("XP Bonus: {percent}",{"percent":this.objectXML.XPBonus + "%"}).setReplacementsColor(_loc1_));
         }
      }
      
      private function addMpCostTagToEffectsList() : void {
         var _loc2_:* = 0;
         var _loc1_:int = 0;
         if(this.objectXML.hasOwnProperty("MpEndCost")) {
            _loc1_ = this.objectXML.MpEndCost;
            _loc2_ = _loc1_;
            if(this.curItemXML && this.curItemXML.hasOwnProperty("MpEndCost")) {
               _loc1_ = this.curItemXML.MpEndCost;
            }
            this.effects.push(new Effect("EquipmentToolTip.mpCost",{"cost":TooltipHelper.compare(_loc2_,_loc1_,false)}));
         } else if(this.objectXML.hasOwnProperty("MpCost")) {
            _loc1_ = this.objectXML.MpCost;
            _loc2_ = _loc1_;
            if(this.curItemXML && this.curItemXML.hasOwnProperty("MpCost")) {
               _loc1_ = this.curItemXML.MpCost;
            }
            this.effects.push(new Effect("EquipmentToolTip.mpCost",{"cost":TooltipHelper.compare(_loc2_,_loc1_,false)}));
         }
      }
      
      private function addDoseTagsToEffectsList() : void {
         if(this.objectXML.hasOwnProperty("Doses")) {
            this.effects.push(new Effect("EquipmentToolTip.doses",{"dose":this.objectXML.Doses}));
         }
         if(this.objectXML.hasOwnProperty("Quantity")) {
            this.effects.push(new Effect("Quantity: {quantity}",{"quantity":this.objectXML.Quantity}));
         }
      }
      
      private function addNumProjectiles() : void {
         var _loc1_:ComPairTag = new ComPairTag(this.objectXML,this.curItemXML,"NumProjectiles",1);
         if(_loc1_.a != 1 || _loc1_.a != _loc1_.b) {
            this.effects.push(new Effect("EquipmentToolTip.shots",{"numShots":TooltipHelper.compare(_loc1_.a,_loc1_.b)}));
         }
      }

      private function addProjectileTagsToEffectsList() : void {
         var _loc1_:* = null;
         if(this.objectXML.hasOwnProperty("Projectile")) {
            _loc1_ = this.curItemXML == null?null:this.curItemXML.Projectile[0];
            this.addProjectile(this.objectXML.Projectile[0],this.objectXML.@type,_loc1_, _loc1_ ? _loc1_.@type : -1);
         }
      }

      private function addProjectile(param1:XML, parentType1:int, param2:XML = null, parentType2:int = -1) : void {
         var _loc7_:* = null;
         var _loc9_:ComPairTag = new ComPairTag(param1,param2,"MinDamage");
         var _loc3_:ComPairTag = new ComPairTag(param1,param2,"MaxDamage");
         var _loc10_:ComPairTagBool = new ComPairTagBool(param1,param2,"Boomerang");
         var _loc5_:ComPairTagBool = new ComPairTagBool(param1,param2,"Parametric");
         var range:Number = ObjectLibrary.propsLibrary_[parentType1].projectiles_[0].calcMaxRange();
         var _loc17_:Number = MathUtil.round(range,2);
         var _loc16_:Number = MathUtil.round(parentType2 > 0 ?
                 ObjectLibrary.propsLibrary_[parentType2].projectiles_[0].calcMaxRange() : range,2);
         var _loc8_:Number = (_loc3_.a + _loc9_.a) / 2;
         var _loc13_:Number = (_loc3_.b + _loc9_.b) / 2;
         var _loc14_:String = (_loc9_.a == _loc3_.a?_loc9_.a:_loc9_.a + " - " + _loc3_.a).toString();
         this.effects.push(new Effect("EquipmentToolTip.damage",{"damage":TooltipHelper.wrapInFontTag(_loc14_,"#" + TooltipHelper.getTextColor(_loc8_ - _loc13_).toString(16))}));
         this.effects.push(new Effect("EquipmentToolTip.range",{"range":TooltipHelper.compare(_loc17_,_loc16_)}));
         if(param1.hasOwnProperty("MultiHit")) {
            this.effects.push(new Effect("GeneralProjectileComparison.multiHit",{}).setColor(16777103));
         }
         if(param1.hasOwnProperty("PassesCover")) {
            this.effects.push(new Effect("GeneralProjectileComparison.passesCover",{}).setColor(16777103));
         }
         if(param1.hasOwnProperty("ArmorPiercing")) {
            this.effects.push(new Effect("GeneralProjectileComparison.armorPiercing",{}).setColor(16777103));
         }
         if(_loc5_.a) {
            this.effects.push(new Effect("Shots are parametric",{}).setColor(16777103));
         } else if(_loc10_.a) {
            this.effects.push(new Effect("Shots boomerang",{}).setColor(16777103));
         }
         if(param1.hasOwnProperty("ConditionEffect")) {
            this.effects.push(new Effect("EquipmentToolTip.shotEffect",{"effect":""}));
         }
         var _loc6_:* = param1.ConditionEffect;
         var _loc19_:int = 0;
         var _loc18_:* = param1.ConditionEffect;
         for each(_loc7_ in param1.ConditionEffect) {
            this.effects.push(new Effect("EquipmentToolTip.effectForDuration",{
               "effect":_loc7_,
               "duration":_loc7_.@duration
            }).setColor(16777103));
         }
      }
      
      private function addRateOfFire() : void {
         var _loc1_:* = null;
         var _loc2_:ComPairTag = new ComPairTag(this.objectXML,this.curItemXML,"RateOfFire",1);
         if(_loc2_.a != 1 || _loc2_.a != _loc2_.b) {
            _loc2_.a = MathUtil.round(_loc2_.a * 100,2);
            _loc2_.b = MathUtil.round(_loc2_.b * 100,2);
            _loc1_ = TooltipHelper.compare(_loc2_.a,_loc2_.b,true,"%");
            this.effects.push(new Effect("EquipmentToolTip.rateOfFire",{"data":_loc1_}));
         }
      }
      
      private function addCooldown() : void {
         var _loc1_:ComPairTag = new ComPairTag(this.objectXML,this.curItemXML,"Cooldown",0.5);
         if(_loc1_.a != 0.5 || _loc1_.a != _loc1_.b) {
            this.effects.push(new Effect("Cooldown: {cd}",{"cd":TooltipHelper.compareAndGetPlural(_loc1_.a,_loc1_.b,"second",false)}));
         }
      }

      private function addForgefireReductionToEffectsList() : void {
         var forgeProps:ForgeProperties = ObjectLibrary.forgePropsLibrary[int(this.objectXML.@type)];
         if (forgeProps && forgeProps.forgefireDismantle != 0 && forgeProps.canDismantle) {
            var repl:Object = {};
            repl["amt"] = new LineBuilder().setParams(Math.abs(forgeProps.forgefireDismantle).toString());
            this.effects.push(new Effect((forgeProps.forgefireDismantle > 0 ? "Increases" : "Reduces") +
                    " Forgefire cost by {amt} when dismantled",
                    repl).setReplacementsColor(16777103));
         }
      }
      
      private function addActivateTagsToEffectsList() : void {
         var _loc17_:* = null;
         var _loc23_:* = null;
         var _loc22_:int = 0;
         var _loc11_:int = 0;
         var _loc20_:* = null;
         var _loc5_:* = null;
         var _loc24_:int = 0;
         var _loc7_:* = null;
         var _loc27_:* = null;
         var _loc2_:* = null;
         var _loc21_:int = 0;
         var _loc25_:* = null;
         var _loc30_:* = null;
         var _loc1_:* = null;
         var _loc14_:* = null;
         var repl:* = null;
         var _loc3_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc29_:* = null;
         var _loc33_:int = 0;
         var _loc32_:* = this.objectXML.Activate;
         for each(_loc17_ in this.objectXML.Activate) {
            _loc20_ = this.comparisonResults.processedTags[_loc17_.toXMLString()];
            if(!_loc20_) {
               _loc5_ = _loc17_.toString();
               var _loc31_:* = _loc5_;
               switch(_loc31_) {
                  case "ConditionEffectAura":
                     this.effects.push(new Effect("EquipmentToolTip.partyEffect",{"effect":new AppendingLineBuilder().pushParams("EquipmentToolTip.withinSqrs",{"range":_loc17_.@range},TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag())}));
                     this.effects.push(new Effect("EquipmentToolTip.effectForDuration",{
                        "effect":_loc17_.@effect,
                        "duration":_loc17_.@duration
                     }).setColor(16777103));
                     continue;
                  case "ConditionEffectSelf":
                     this.effects.push(new Effect("EquipmentToolTip.effectOnSelf",{"effect":""}));
                     this.effects.push(new Effect("EquipmentToolTip.effectForDuration",{
                        "effect":_loc17_.@effect,
                        "duration":_loc17_.@duration
                     }));
                     continue;
                  case "StatBoostSelf":
                     this.effects.push(new Effect("{amount} {stat} for {duration} ",{
                        "amount":this.prefix(_loc17_.@amount),
                        "stat":new LineBuilder().setParams(StatData.statToName(int(_loc17_.@stat))),
                        "duration":TooltipHelper.getPlural(_loc17_.@duration,"second")
                     }));
                     continue;
                  case "Heal":
                     this.effects.push(new Effect("EquipmentToolTip.incrementStat",{
                        "statAmount":"+" + _loc17_.@amount + " ",
                        "statName":new LineBuilder().setParams("StatusBar.HealthPoints")
                     }));
                     continue;
                  case "HealNova":
                     if(_loc17_.hasOwnProperty("@damage") && int(_loc17_.@damage) > 0) {
                        this.effects.push(new Effect("{damage} damage within {range} sqrs",{
                           "damage":_loc17_.@damage,
                           "range":_loc17_.@range
                        }));
                     }
                     this.effects.push(new Effect("EquipmentToolTip.partyHeal",{"effect":new AppendingLineBuilder().pushParams("EquipmentToolTip.partyHealAmount",{
                        "amount":_loc17_.@amount,
                        "range":_loc17_.@range
                     },TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag())}));
                     this.effects.push(new Effect("{perc} less effectiveness ({hp} minimum) per ally healed",{
                        "perc":"2.5%",
                        "hp":int(_loc17_.@amount) * 0.3 + " HP"
                     }));
                     continue;
                  case "Magic":
                     this.effects.push(new Effect("EquipmentToolTip.incrementStat",{
                        "statAmount":"+" + _loc17_.@amount + " ",
                        "statName":new LineBuilder().setParams("StatusBar.ManaPoints")
                     }));
                     continue;
                  case "MagicNova":
                     this.effects.push(new Effect("EquipmentToolTip.partyFill",{"effect":new AppendingLineBuilder().pushParams("EquipmentToolTip.partyFillAmount",{
                        "amount":_loc17_.@amount,
                        "range":_loc17_.@range
                     },TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag())}));
                     continue;
                  case "Teleport":
                     this.effects.push(new Effect("blank",{"data":new LineBuilder().setParams("EquipmentToolTip.teleportToTarget")}));
                     continue;
                  case "BulletNova":
                     this.getSpell(_loc17_,null);
                     continue;
                  case "BulletCreate":
                     this.getBulletCreate(_loc17_,null);
                     continue;
                  case "VampireBlast":
                     this.getSkull(_loc17_,null);
                     continue;
                  case "Trap":
                     this.getTrap(_loc17_,null);
                     continue;
                  case "StasisBlast":
                     this.effects.push(new Effect("EquipmentToolTip.stasisGroup",{"stasis":new AppendingLineBuilder().pushParams("EquipmentToolTip.secsCount",{"duration":_loc17_.@duration},TooltipHelper.getOpenTag(16777103),TooltipHelper.getCloseTag())}));
                     continue;
                  case "EffectBlast":
                     this.effects.push(new Effect(
                             "{effect} on group: {duration} seconds", {
                                "effect": _loc17_.@condEffect,
                                "duration": _loc17_.@condDuration}));
                     continue;
                  case "Decoy":
                     this.getDecoy(_loc17_,null);
                     continue;
                  case "Lightning":
                     this.getLightning(_loc17_,null);
                     continue;
                  case "PoisonGrenade":
                     this.getPoison(_loc17_,null);
                     continue;
                  case "RemoveNegativeConditions":
                     this.effects.push(new Effect("EquipmentToolTip.removesNegative",{}).setColor(16777103));
                     continue;
                  case "RemoveNegativeConditionsSelf":
                     this.effects.push(new Effect("EquipmentToolTip.removesNegative",{}).setColor(16777103));
                     continue;
                  case "GenericActivate":
                     if(!("@ignoreOnTooltip" in _loc17_)) {
                        _loc24_ = 16777103;
                        if(this.curItemXML != null) {
                           _loc7_ = this.getEffectTag(this.curItemXML,_loc17_.@effect);
                           if(_loc7_ != null) {
                              _loc3_ = _loc17_.@range;
                              _loc12_ = _loc7_.@range;
                              _loc8_ = _loc17_.@duration;
                              _loc19_ = _loc7_.@duration;
                              _loc18_ = _loc3_ - _loc12_ + (_loc8_ - _loc19_);
                              if(_loc18_ > 0) {
                                 _loc24_ = 65280;
                              } else if(_loc18_ < 0) {
                                 _loc24_ = 16711680;
                              }
                           }
                        }
                        _loc27_ = {
                           "range":_loc17_.@range,
                           "effect":_loc17_.@effect,
                           "duration":_loc17_.@duration
                        };
                        _loc2_ = "Within {range} sqrs {effect} for {duration} seconds";
                        if(_loc17_.@target != "enemy") {
                           this.effects.push(new Effect("EquipmentToolTip.partyEffect",{"effect":LineBuilder.returnStringReplace(_loc2_,_loc27_)}).setReplacementsColor(_loc24_));
                        } else {
                           this.effects.push(new Effect("EquipmentToolTip.enemyEffect",{"effect":LineBuilder.returnStringReplace(_loc2_,_loc27_)}).setReplacementsColor(_loc24_));
                        }
                     }
                     continue;
                  case "StatBoostAura":
                     _loc21_ = 16777103;
                     if(this.curItemXML != null) {
                        _loc25_ = this.getStatTag(this.curItemXML,_loc17_.@stat);
                        if(_loc25_ != null) {
                           _loc10_ = _loc17_.@range;
                           _loc6_ = _loc25_.@range;
                           _loc15_ = _loc17_.@duration;
                           _loc26_ = _loc25_.@duration;
                           _loc13_ = _loc17_.@amount;
                           _loc9_ = _loc25_.@amount;
                           _loc16_ = _loc10_ - _loc6_ + (_loc15_ - _loc26_) + (_loc13_ - _loc9_);
                           if(_loc16_ > 0) {
                              _loc21_ = 65280;
                           } else if(_loc16_ < 0) {
                              _loc21_ = 16711680;
                           }
                        }
                     }
                     _loc22_ = _loc17_.@stat;
                     _loc30_ = LineBuilder.getLocalizedString2(StatData.statToName(_loc22_));
                     _loc1_ = {
                        "range":_loc17_.@range,
                        "stat":_loc30_,
                        "amount":_loc17_.@amount,
                        "duration":_loc17_.@duration
                     };
                     _loc14_ = "Within {range} sqrs increase {stat} by {amount} for {duration} seconds";
                     this.effects.push(new Effect("EquipmentToolTip.partyEffect",{"effect":LineBuilder.returnStringReplace(_loc14_,_loc1_)}).setReplacementsColor(_loc21_));
                     continue;
                  case "IncrementStat":
                     _loc22_ = _loc17_.@stat;
                     _loc11_ = _loc17_.@amount;
                     repl = {};
                     if(_loc22_ != 1 && _loc22_ != 4) {
                        _loc23_ = "EquipmentToolTip.permanentlyIncreases";
                        repl["statName"] = new LineBuilder().setParams(StatData.statToName(_loc22_));
                        this.effects.push(new Effect(_loc23_,repl).setColor(16777103));
                     } else {
                        _loc23_ = "blank";
                        _loc29_ = new AppendingLineBuilder().setDelimiter(" ");
                        _loc29_.pushParams("blank",{"data":new StaticStringBuilder("+" + _loc11_)});
                        _loc29_.pushParams(StatData.statToName(_loc22_));
                        repl["data"] = _loc29_;
                        this.effects.push(new Effect(_loc23_,repl));
                     }
                     continue;
                  case "UnlockForgeBlueprint":
                     repl = {};
                     var items:String = _loc17_.@id;
                     items = items.replace(/,/g,  ", ");
                     repl["items"] = new LineBuilder().setParams(items);
                     this.effects.push(new Effect("Unlocks the following items: {items}",
                             repl).setReplacementsColor(16777103));
                     continue;
                  case "BoostForgeEnergy":
                     repl = {};
                     repl["amt"] = new LineBuilder().setParams(_loc17_.@amount);
                     this.effects.push(new Effect("Recharges up to {amt} Forgefire",
                             repl).setReplacementsColor(16777103));
                     continue;
                  case "BoostRange":
                     continue;
                  default:
                     continue;
               }
            } else {
               continue;
            }
         }
      }
      
      private function getSpell(param1:XML, param2:XML = null) : void {
         var _loc3_:ComPair = new ComPair(param1,param2,"numShots",20);
         var _loc4_:String = this.colorUntiered("Spell: ");
         _loc4_ = _loc4_ + "{numShots} Shots";
         this.effects.push(new Effect(_loc4_,{"numShots":TooltipHelper.compare(_loc3_.a,_loc3_.b)}));
      }
      
      private function getBulletCreate(param1:XML, param2:XML = null) : void {
         var _loc6_:ComPair = new ComPair(param1,param2,"numShots",3);
         var _loc7_:ComPair = new ComPair(param1,param2,"offsetAngle",90);
         var _loc4_:ComPair = new ComPair(param1,param2,"minDistance",0);
         var _loc3_:ComPair = new ComPair(param1,param2,"maxDistance",4.4);
         var _loc5_:String = this.colorUntiered("Wakizashi: ") + "{numShots} shots at {angle}\n";
         if(_loc4_.a) {
            _loc5_ = _loc5_ + "Min Cast Range: {minDistance}\n";
         }
         _loc5_ = _loc5_ + "Max Cast Range: {maxDistance}";
         this.effects.push(new Effect(_loc5_,{
            "numShots":TooltipHelper.compare(_loc6_.a,_loc6_.b),
            "angle":TooltipHelper.getPlural(_loc7_.a,"degree"),
            "minDistance":TooltipHelper.compareAndGetPlural(_loc4_.a,_loc4_.b,"square",false),
            "maxDistance":TooltipHelper.compareAndGetPlural(_loc3_.a,_loc3_.b,"square")
         }));
      }
      
      private function getSkull(param1:XML, param2:XML = null) : void {
         var _loc11_:int = this.player != null?this.player.wisdom:10;
         var _loc6_:int = this.GetIntArgument(param1,"wisPerRad",10);
         var _loc13_:Number = this.GetFloatArgument(param1,"incrRad",0.5);
         var _loc10_:int = this.GetIntArgument(param1,"wisDamageBase",0);
         var _loc18_:int = this.GetIntArgument(param1,"wisMin",50);
         var _loc8_:int = Math.max(0,_loc11_ - _loc18_);
         var _loc14_:int = _loc10_ / 10 * _loc8_;
         var _loc15_:Number = MathUtil.round(int(_loc8_ / _loc6_) * _loc13_,2);
         var _loc9_:ComPair = new ComPair(param1,param2,"totalDamage");
         _loc9_.add(_loc14_);
         var _loc17_:ComPair = new ComPair(param1,param2,"radius");
         var _loc16_:ComPair = new ComPair(param1,param2,"healRange",5);
         _loc16_.add(_loc15_);
         var _loc5_:ComPair = new ComPair(param1,param2,"heal");
         var _loc4_:ComPair = new ComPair(param1,param2,"ignoreDef",0);
         var _loc12_:int = this.GetIntArgument(param1,"hitsForSelfPuri",-1);
         var _loc7_:int = this.GetIntArgument(param1,"hitsForGroupPuri",-1);
         var _loc3_:String = this.colorUntiered("Skull: ");
         _loc3_ = _loc3_ + ("{damage}" + this.colorWisBonus(_loc14_) + " damage\n");
         _loc3_ = _loc3_ + "within {radius} squares\n";
         if(_loc5_.a) {
            _loc3_ = _loc3_ + "Steals {heal} HP";
         }
         if(_loc5_.a && Number(_loc4_.a)) {
            _loc3_ = _loc3_ + " and ignores {ignoreDef} defense";
         } else if(_loc4_.a) {
            _loc3_ = _loc3_ + "Ignores {ignoreDef} defense";
         }
         if(_loc5_.a) {
            _loc3_ = _loc3_ + ("\nHeals allies within {healRange}" + this.colorWisBonus(_loc15_) + " squares");
         }
         if(_loc12_ != -1) {
            _loc3_ = _loc3_ + "\n{hitsSelf}: Removes negative conditions on self";
         }
         if(_loc12_ != -1) {
            _loc3_ = _loc3_ + "\n{hitsGroup}: Removes negative conditions on group";
         }
         this.effects.push(new Effect(_loc3_,{
            "damage":TooltipHelper.compare(_loc9_.a,_loc9_.b),
            "radius":TooltipHelper.compare(_loc17_.a,_loc17_.b),
            "heal":TooltipHelper.compare(_loc5_.a,_loc5_.b),
            "ignoreDef":TooltipHelper.compare(_loc4_.a,_loc4_.b),
            "healRange":TooltipHelper.compare(MathUtil.round(_loc16_.a,2),MathUtil.round(_loc16_.b,2)),
            "hitsSelf":TooltipHelper.getPlural(_loc12_,"Hit"),
            "hitsGroup":TooltipHelper.getPlural(_loc7_,"Hit")
         }));
         this.AddConditionToEffects(param1,param2,"Nothing",2.5);
      }
      
      private function getTrap(param1:XML, param2:XML = null) : void {
         var _loc3_:ComPair = new ComPair(param1,param2,"totalDamage");
         var _loc9_:ComPair = new ComPair(param1,param2,"radius");
         var _loc10_:ComPair = new ComPair(param1,param2,"duration",20);
         var _loc7_:ComPair = new ComPair(param1,param2,"throwTime",1);
         var _loc4_:ComPair = new ComPair(param1,param2,"sensitivity",0.5);
         var _loc5_:Number = MathUtil.round(_loc9_.a * _loc4_.a,2);
         var _loc6_:Number = MathUtil.round(_loc9_.b * _loc4_.b,2);
         var _loc8_:String = this.colorUntiered("Trap: ");
         _loc8_ = _loc8_ + "{damage} damage within {radius} squares";
         this.effects.push(new Effect(_loc8_,{
            "damage":TooltipHelper.compare(_loc3_.a,_loc3_.b),
            "radius":TooltipHelper.compare(_loc9_.a,_loc9_.b)
         }));
         this.AddConditionToEffects(param1,param2,"Slowed",5);
         this.effects.push(new Effect("{throwTime} to arm for {duration} ",{
            "throwTime":TooltipHelper.compareAndGetPlural(_loc7_.a,_loc7_.b,"second",false),
            "duration":TooltipHelper.compareAndGetPlural(_loc10_.a,_loc10_.b,"second")
         }));
         this.effects.push(new Effect("Triggers within {triggerRadius} squares",{"triggerRadius":TooltipHelper.compare(_loc5_,_loc6_)}));
      }
      
      private function getLightning(param1:XML, param2:XML = null) : void {
         var _loc12_:Boolean = false;
         var _loc5_:* = null;
         var _loc7_:int = this.player != null?this.player.wisdom:10;
         var _loc3_:ComPair = new ComPair(param1,param2,"decrDamage",0);
         var _loc9_:int = this.GetIntArgument(param1,"wisPerTarget",10);
         var _loc13_:int = this.GetIntArgument(param1,"wisDamageBase",_loc3_.a);
         var _loc8_:int = this.GetIntArgument(param1,"wisMin",50);
         var _loc4_:int = Math.max(0,_loc7_ - _loc8_);
         var _loc10_:int = _loc4_ / _loc9_;
         var _loc15_:int = _loc13_ / 10 * _loc4_;
         var _loc14_:ComPair = new ComPair(param1,param2,"maxTargets");
         _loc14_.add(_loc10_);
         var _loc6_:ComPair = new ComPair(param1,param2,"totalDamage");
         _loc6_.add(_loc15_);
         var _loc11_:String = this.colorUntiered("Lightning: ");
         _loc11_ = _loc11_ + ("{targets}" + this.colorWisBonus(_loc10_) + " targets\n");
         _loc11_ = _loc11_ + ("{damage}" + this.colorWisBonus(_loc15_) + " damage");
         if(_loc3_.a) {
            if(_loc3_.a < 0) {
               _loc12_ = true;
            }
            _loc5_ = "reduced";
            if(_loc12_) {
               _loc5_ = TooltipHelper.wrapInFontTag("increased","#" + (16777103).toString(16));
            }
            _loc11_ = _loc11_ + (", " + _loc5_ + " by \n{decrDamage} for each subsequent target");
         }
         this.effects.push(new Effect(_loc11_,{
            "targets":TooltipHelper.compare(_loc14_.a,_loc14_.b),
            "damage":TooltipHelper.compare(_loc6_.a,_loc6_.b),
            "decrDamage":TooltipHelper.compare(_loc3_.a,_loc3_.b,false,"",_loc12_)
         }));
         this.AddConditionToEffects(param1,param2,"Nothing",5);
      }
      
      private function getDecoy(param1:XML, param2:XML = null) : void {
         var _loc8_:ComPair = new ComPair(param1,param2,"duration");
         var _loc9_:ComPair = new ComPair(param1,param2,"angleOffset",0);
         var _loc3_:ComPair = new ComPair(param1,param2,"speed",1);
         var _loc7_:ComPair = new ComPair(param1,param2,"distance",8);
         var _loc10_:Number = MathUtil.round(_loc7_.a / (_loc3_.a * 5),2);
         var _loc6_:Number = MathUtil.round(_loc7_.b / (_loc3_.b * 5),2);
         var _loc4_:ComPair = new ComPair(param1,param2,"numShots",0);
         var _loc5_:* = this.colorUntiered("Decoy: ");
         _loc5_ = _loc5_ + "{duration}";
         if(_loc9_.a) {
            _loc5_ = _loc5_ + " at {angleOffset}";
         }
         _loc5_ = _loc5_ + "\n";
         if(_loc3_.a == 0) {
            _loc5_ = _loc5_ + "Decoy does not move";
         } else {
            _loc5_ = _loc5_ + "{distance} in {travelTime}";
         }
         if(_loc4_.a) {
            _loc5_ = _loc5_ + "\nShots: {numShots}";
         }
         this.effects.push(new Effect(_loc5_,{
            "duration":TooltipHelper.compareAndGetPlural(_loc8_.a,_loc8_.b,"second"),
            "angleOffset":TooltipHelper.compareAndGetPlural(_loc9_.a,_loc9_.b,"degree"),
            "distance":TooltipHelper.compareAndGetPlural(_loc7_.a,_loc7_.b,"square"),
            "travelTime":TooltipHelper.compareAndGetPlural(_loc10_,_loc6_,"second"),
            "numShots":TooltipHelper.compare(_loc4_.a,_loc4_.b)
         }));
      }
      
      private function getPoison(param1:XML, param2:XML = null) : void {
         var _loc8_:ComPair = new ComPair(param1,param2,"totalDamage");
         var _loc9_:ComPair = new ComPair(param1,param2,"radius");
         var _loc3_:ComPair = new ComPair(param1,param2,"duration");
         var _loc7_:ComPair = new ComPair(param1,param2,"throwTime",1);
         var _loc10_:ComPair = new ComPair(param1,param2,"impactDamage",0);
         var _loc6_:Number = _loc8_.a - _loc10_.a;
         var _loc4_:Number = _loc8_.b - _loc10_.b;
         var _loc5_:* = this.colorUntiered("Poison: ");
         _loc5_ = _loc5_ + "{totalDamage} damage";
         if(_loc10_.a) {
            _loc5_ = _loc5_ + " ({impactDamage} on impact)";
         }
         _loc5_ = _loc5_ + " within {radius}";
         _loc5_ = _loc5_ + " over {duration}";
         this.effects.push(new Effect(_loc5_,{
            "totalDamage":TooltipHelper.compare(_loc8_.a,_loc8_.b,true,"",false,!this.sameActivateEffect),
            "radius":TooltipHelper.compareAndGetPlural(_loc9_.a,_loc9_.b,"square",true,!this.sameActivateEffect),
            "impactDamage":TooltipHelper.compare(_loc10_.a,_loc10_.b,true,"",false,!this.sameActivateEffect),
            "duration":TooltipHelper.compareAndGetPlural(_loc3_.a,_loc3_.b,"second",false,!this.sameActivateEffect)
         }));
         this.AddConditionToEffects(param1,param2,"Nothing",5);
         this.sameActivateEffect = true;
      }
      
      private function AddConditionToEffects(param1:XML, param2:XML, param3:String = "Nothing", param4:Number = 5) : void {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:String = !!param1.hasOwnProperty("@condEffect")?param1.@condEffect:param3;
         if(_loc6_ != "Nothing") {
            _loc5_ = new ComPair(param1,param2,"condDuration",param4);
            if(param2) {
               _loc7_ = !!param2.hasOwnProperty("@condEffect")?param2.@condEffect:param3;
               if(_loc7_ == "Nothing") {
                  _loc5_.b = 0;
               }
            }
            this.effects.push(new Effect("Inflicts {condition} for {duration} ",{
               "condition":_loc6_,
               "duration":TooltipHelper.compareAndGetPlural(_loc5_.a,_loc5_.b,"second")
            }));
         }
      }
      
      private function GetIntArgument(param1:XML, param2:String, param3:int = 0) : int {
         return !!param1.hasOwnProperty("@" + param2)?int(param1[param2]):int(param3);
      }
      
      private function GetFloatArgument(param1:XML, param2:String, param3:Number = 0) : Number {
         return !!param1.hasOwnProperty("@" + param2)?Number(param1[param2]):Number(param3);
      }
      
      private function GetStringArgument(param1:XML, param2:String, param3:String = "") : String {
         return !!param1.hasOwnProperty("@" + param2)?param1[param2]:param3;
      }
      
      private function colorWisBonus(param1:Number) : String {
         if(param1) {
            return TooltipHelper.wrapInFontTag(" (+" + param1 + ")","#" + (4219875).toString(16));
         }
         return "";
      }
      
      private function colorUntiered(param1:String) : String {
         var _loc2_:Boolean = this.objectXML.hasOwnProperty("Tier");
         var _loc3_:Boolean = this.objectXML.hasOwnProperty("@setType");
         if(_loc3_) {
            return TooltipHelper.wrapInFontTag(param1,"#" + (16750848).toString(16));
         }
         if(!_loc2_) {
            return TooltipHelper.wrapInFontTag(param1,"#" + (9055202).toString(16));
         }
         return param1;
      }
      
      private function getEffectTag(param1:XML, param2:String) : XML {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = param1.Activate;
         var _loc5_:* = new XMLList("");
         var _loc10_:* = param1.Activate;
         var _loc11_:int = 0;
         var _loc13_:* = new XMLList("");
         _loc4_ = param1.Activate.(text() == "GenericActivate");
         var _loc6_:* = _loc4_;
         var _loc15_:int = 0;
         var _loc14_:* = _loc4_;
         for each(_loc8_ in _loc4_) {
            if(_loc8_.@effect == param2) {
               return _loc8_;
            }
         }
         return null;
      }
      
      private function getStatTag(param1:XML, param2:String) : XML {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc9_:* = param1.Activate;
         var _loc5_:* = new XMLList("");
         var _loc10_:* = param1.Activate;
         var _loc11_:int = 0;
         var _loc13_:* = new XMLList("");
         _loc4_ = param1.Activate.(text() == "StatBoostAura");
         var _loc6_:* = _loc4_;
         var _loc15_:int = 0;
         var _loc14_:* = _loc4_;
         for each(_loc8_ in _loc4_) {
            if(_loc8_.@stat == param2) {
               return _loc8_;
            }
         }
         return null;
      }
      
      private function addActivateOnEquipTagsToEffectsList() : void {
         var _loc3_:* = null;
         var _loc1_:Boolean = true;
         var _loc2_:* = this.objectXML.ActivateOnEquip;
         var _loc6_:int = 0;
         var _loc5_:* = this.objectXML.ActivateOnEquip;
         for each(_loc3_ in this.objectXML.ActivateOnEquip) {
            if(_loc1_) {
               this.effects.push(new Effect("EquipmentToolTip.onEquip",""));
               _loc1_ = false;
            }
            if(_loc3_.toString() == "IncrementStat") {
               this.effects.push(new Effect("EquipmentToolTip.incrementStat",this.getComparedStatText(_loc3_)).setReplacementsColor(this.getComparedStatColor(_loc3_)));
            }
         }
      }
      
      private function getComparedStatText(param1:XML) : Object {
         var _loc2_:int = param1.@stat;
         var _loc3_:int = param1.@amount;
         return {
            "statAmount":this.prefix(_loc3_) + " ",
            "statName":new LineBuilder().setParams(StatData.statToName(_loc2_))
         };
      }
      
      private function prefix(param1:int) : String {
         var _loc2_:String = param1 > -1?"+":"";
         return _loc2_ + param1;
      }
      
      private function getComparedStatColor(param1:XML) : uint {
         var _loc7_:* = undefined;
         var _loc3_:int = 0;
         var _loc5_:* = undefined;
         var _loc8_:XML = null;
         var _loc2_:int = 0;
         var _loc11_:* = param1;
         var _loc4_:int = _loc11_.@stat;
         var _loc10_:int = _loc11_.@amount;
         var _loc6_:uint = !!this.playerCanUse?65280:16777103;
         var _loc9_:* = null;
         if(this.curItemXML != null) {
            _loc7_ = this.curItemXML.ActivateOnEquip;
            _loc3_ = 0;
            _loc5_ = new XMLList("");
            var _loc12_:* = this.curItemXML.ActivateOnEquip;
            var _loc13_:int = 0;
            var _loc15_:* = new XMLList("");
            _loc9_ = this.curItemXML.ActivateOnEquip.(@stat == _loc4_);
         }
         if(_loc9_ != null && _loc9_.length() == 1) {
            _loc8_ = XML(_loc9_[0]);
            _loc2_ = _loc8_.@amount;
            _loc6_ = TooltipHelper.getTextColor(_loc10_ - _loc2_);
         }
         if(_loc10_ < 0) {
            _loc6_ = 16711680;
         }
         return _loc6_;
      }
      
      private function getComparedStatColorOLD(param1:XML) : uint {
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:* = undefined;
         var _loc10_:* = null;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc3_:int = param1.@stat;
         var _loc9_:int = param1.@amount;
         var _loc8_:uint = !!this.playerCanUse?65280:16777103;
         if(this.curItemXML != null) {
            _loc5_ = this.curItemXML.ActivateOnEquip;
            _loc6_ = 0;
            _loc4_ = new XMLList("");
            var _loc11_:* = this.curItemXML.ActivateOnEquip;
            var _loc12_:int = 0;
            var _loc14_:* = new XMLList("");
            _loc7_ = this.curItemXML.ActivateOnEquip.(@stat == _loc3_);
         }
         if(_loc7_ != null && _loc7_.length() == 1) {
            _loc10_ = XML(_loc7_[0]);
            _loc2_ = _loc10_.@amount;
            _loc8_ = TooltipHelper.getTextColor(_loc9_ - _loc2_);
         }
         if(_loc9_ < 0) {
            _loc8_ = 16711680;
         }
         return _loc8_;
      }
      
      private function addEquipmentItemRestrictions() : void {
         if(this.objectXML.hasOwnProperty("PetFood")) {
            this.restrictions.push(new Restriction("Used to feed your pet in the pet yard",11776947,false));
         } else if(this.objectXML.hasOwnProperty("Treasure") == false) {
            this.restrictions.push(new Restriction("EquipmentToolTip.equippedToUse",11776947,false));
            if(this.isInventoryFull || this.inventoryOwnerType == "CURRENT_PLAYER") {
               this.restrictions.push(new Restriction("EquipmentToolTip.doubleClickEquip",11776947,false));
            } else {
               this.restrictions.push(new Restriction("EquipmentToolTip.doubleClickTake",11776947,false));
            }
         }
      }
      
      private function addAbilityItemRestrictions() : void {
         this.restrictions.push(new Restriction("EquipmentToolTip.keyCodeToUse",16777215,false));
      }
      
      private function addConsumableItemRestrictions() : void {
         this.restrictions.push(new Restriction("EquipmentToolTip.consumedWithUse",11776947,false));
         if(this.isInventoryFull || this.inventoryOwnerType == "CURRENT_PLAYER") {
            this.restrictions.push(new Restriction("EquipmentToolTip.doubleClickOrShiftClickToUse",16777215,false));
         } else {
            this.restrictions.push(new Restriction("EquipmentToolTip.doubleClickTakeShiftClickUse",16777215,false));
         }
      }
      
      private function addReusableItemRestrictions() : void {
         this.restrictions.push(new Restriction("EquipmentToolTip.usedMultipleTimes",11776947,false));
         this.restrictions.push(new Restriction("EquipmentToolTip.doubleClickOrShiftClickToUse",16777215,false));
      }
      
      private function makeRestrictionList() : void {
         var _loc2_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:* = null;
         this.restrictions = new Vector.<Restriction>();
         if(this.objectXML.hasOwnProperty("VaultItem") && this.invType != -1 && this.invType != ObjectLibrary.idToType_["Vault Chest"]) {
            this.restrictions.push(new Restriction("EquipmentToolTip.storeVaultItem",16549442,true));
         }
         if(this.objectXML.hasOwnProperty("Soulbound")) {
            this.restrictions.push(new Restriction("Item.Soulbound",11776947,false));
         }
         if(this.playerCanUse) {
            if(this.objectXML.hasOwnProperty("Usable")) {
               this.addAbilityItemRestrictions();
               this.addEquipmentItemRestrictions();
            } else if(this.objectXML.hasOwnProperty("Consumable")) {
               if(this.objectXML.hasOwnProperty("Potion")) {
                  this.restrictions.push(new Restriction("Potion",11776947,false));
               }
               this.addConsumableItemRestrictions();
            } else if(this.objectXML.hasOwnProperty("InvUse")) {
               this.addReusableItemRestrictions();
            } else {
               this.addEquipmentItemRestrictions();
            }
         } else if(this.player != null) {
            this.restrictions.push(new Restriction("EquipmentToolTip.notUsableBy",16549442,true));
         }
         var _loc3_:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
         if(_loc3_ != null) {
            this.restrictions.push(new Restriction("EquipmentToolTip.usableBy",11776947,false));
         }
         var _loc4_:* = this.objectXML.EquipRequirement;
         var _loc9_:int = 0;
         var _loc8_:* = this.objectXML.EquipRequirement;
         for each(_loc1_ in this.objectXML.EquipRequirement) {
            _loc2_ = ObjectLibrary.playerMeetsRequirement(_loc1_,this.player);
            if(_loc1_.toString() == "Stat") {
               _loc6_ = _loc1_.@stat;
               _loc7_ = _loc1_.@value;
               this.restrictions.push(new Restriction("Requires " + StatData.statToName(_loc6_) + " of " + _loc7_,!!_loc2_?11776947:16549442,!_loc2_));
            }
         }
      }
      
      private function makeLineTwo() : void {
         this.line2 = new LineBreakDesign(218,0);
         addChild(this.line2);
      }
      
      private function makeLineThree() : void {
         this.line3 = new LineBreakDesign(218,0);
         addChild(this.line3);
      }
      
      private function makeRestrictionText() : void {
         if(this.restrictions.length != 0) {
            this.restrictionsText = new TextFieldDisplayConcrete().setSize(14).setColor(11776947).setTextWidth(226).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
            this.restrictionsText.setStringBuilder(this.buildRestrictionsLineBuilder());
            this.restrictionsText.filters = FilterUtil.getStandardDropShadowFilter();
            waiter.push(this.restrictionsText.textChanged);
            addChild(this.restrictionsText);
         }
      }
      
      private function makeSetInfoText() : void {
         if(this.setInfo.length != 0) {
            this.setInfoText = new TextFieldDisplayConcrete().setSize(14).setColor(11776947).setTextWidth(226).setIndent(-10).setLeftMargin(10).setWordWrap(true).setHTML(true);
            this.setInfoText.setStringBuilder(this.getSetBonusStringBuilder());
            this.setInfoText.filters = FilterUtil.getStandardDropShadowFilter();
            waiter.push(this.setInfoText.textChanged);
            addChild(this.setInfoText);
            this.makeLineThree();
         }
      }
      
      private function getSetBonusStringBuilder() : AppendingLineBuilder {
         var _loc1_:AppendingLineBuilder = new AppendingLineBuilder();
         this.appendEffects(this.setInfo,_loc1_);
         return _loc1_;
      }
      
      private function buildRestrictionsLineBuilder() : StringBuilder {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc3_:AppendingLineBuilder = new AppendingLineBuilder();
         var _loc4_:* = this.restrictions;
         var _loc9_:int = 0;
         var _loc8_:* = this.restrictions;
         for each(_loc1_ in this.restrictions) {
            _loc2_ = !!_loc1_.bold_?"<b>":"";
            _loc2_ = _loc2_ + ("<font color=\"#" + _loc1_.color_.toString(16) + "\">");
            _loc6_ = "</font>";
            _loc6_ = _loc6_.concat(!!_loc1_.bold_?"</b>":"");
            _loc7_ = !!this.player?ObjectLibrary.typeToDisplayId_[this.player.objectType_]:"";
            _loc3_.pushParams(_loc1_.text_,{
               "unUsableClass":_loc7_,
               "usableClasses":this.getUsableClasses(),
               "keyCode":KeyCodes.CharCodeStrings[Parameters.data.useSpecial]
            },_loc2_,_loc6_);
         }
         return _loc3_;
      }
      
      private function getUsableClasses() : StringBuilder {
         var _loc2_:* = null;
         var _loc3_:Vector.<String> = ObjectLibrary.usableBy(this.objectType);
         var _loc1_:AppendingLineBuilder = new AppendingLineBuilder();
         _loc1_.setDelimiter(", ");
         var _loc4_:* = _loc3_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc3_;
         for each(_loc2_ in _loc3_) {
            _loc1_.pushParams(_loc2_);
         }
         return _loc1_;
      }
      
      private function addDescriptionText() : void {
         this.descText = new TextFieldDisplayConcrete().setSize(14).setColor(11776947).setTextWidth(230).setWordWrap(true);
         if(this.descriptionOverride) {
            this.descText.setStringBuilder(new StaticStringBuilder(this.descriptionOverride));
         } else {
            this.descText.setStringBuilder(new LineBuilder().setParams(this.objectXML.Description));
         }
         this.descText.filters = FilterUtil.getStandardDropShadowFilter();
         waiter.push(this.descText.textChanged);
         addChild(this.descText);
      }
      
      private function buildCategorySpecificText() : void {
         if(this.curItemXML != null) {
            this.comparisonResults = this.slotTypeToTextBuilder.getComparisonResults(this.objectXML,this.curItemXML);
         } else {
            this.comparisonResults = new SlotComparisonResult();
         }
      }
      
      private function handleWisMod() : void {
         var _loc5_:* = undefined;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc7_:String = null;
         if(this.player == null) {
            return;
         }
         var _loc1_:Number = this.player.wisdom;
         if(_loc1_ < 30) {
            return;
         }
         var _loc4_:Vector.<XML> = new Vector.<XML>();
         if(this.curItemXML != null) {
            this.curItemXML = this.curItemXML.copy();
            _loc4_.push(this.curItemXML);
         }
         if(this.objectXML != null) {
            this.objectXML = this.objectXML.copy();
            _loc4_.push(this.objectXML);
         }
         var _loc12_:int = 0;
         var _loc11_:* = _loc4_;
         for each(_loc2_ in _loc4_) {
            var _loc10_:int = 0;
            var _loc9_:* = _loc2_.Activate;
            for each(_loc6_ in _loc2_.Activate) {
               _loc3_ = _loc6_.toString();
               if(_loc6_.@effect != "Stasis") {
                  _loc7_ = _loc6_.@useWisMod;
                  if(!(_loc7_ == "" || _loc7_ == "false" || _loc7_ == "0" || _loc6_.@effect == "Stasis")) {
                     _loc5_ = _loc3_;
                     var _loc8_:* = _loc5_;
                     switch(_loc8_) {
                        case "HealNova":
                           _loc6_.@amount = this.modifyWisModStat(_loc6_.@amount,0);
                           _loc6_.@range = this.modifyWisModStat(_loc6_.@range);
                           _loc6_.@damage = this.modifyWisModStat(_loc6_.@damage,0);
                           continue;
                        case "ConditionEffectAura":
                           _loc6_.@duration = this.modifyWisModStat(_loc6_.@duration);
                           _loc6_.@range = this.modifyWisModStat(_loc6_.@range);
                           continue;
                        case "ConditionEffectSelf":
                           _loc6_.@duration = this.modifyWisModStat(_loc6_.@duration);
                           continue;
                        case "StatBoostAura":
                           _loc6_.@amount = this.modifyWisModStat(_loc6_.@amount,0);
                           _loc6_.@duration = this.modifyWisModStat(_loc6_.@duration);
                           _loc6_.@range = this.modifyWisModStat(_loc6_.@range);
                           continue;
                        case "GenericActivate":
                           _loc6_.@duration = this.modifyWisModStat(_loc6_.@duration);
                           _loc6_.@range = this.modifyWisModStat(_loc6_.@range);
                           continue;
                        default:
                           continue;
                     }
                  } else {
                     continue;
                  }
               } else {
                  continue;
               }
            }
         }
      }
      
      private function modifyWisModStat(param1:String, param2:Number = 1) : String {
         var _loc7_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:Number = NaN;
         var _loc3_:* = "-1";
         var _loc6_:Number = this.player.wisdom;
         if(_loc6_ < 30) {
            _loc3_ = param1;
         } else {
            _loc7_ = parseInt(param1);
            _loc5_ = _loc7_ < 0?-1:1;
            _loc4_ = _loc7_ * _loc6_ / 150 + _loc7_ * _loc5_;
            _loc4_ = Math.floor(_loc4_ * Math.pow(10,param2)) / Math.pow(10,param2);
            if(_loc4_ - int(_loc4_) * _loc5_ >= 1 / Math.pow(10,param2) * _loc5_) {
               _loc3_ = _loc4_.toFixed(1);
            } else {
               _loc3_ = _loc4_.toFixed(0);
            }
         }
         return _loc3_;
      }
   }
}

class ComPair {
    
   
   public var a:Number = 0;
   
   public var b:Number = 0;
   
   function ComPair(param1:XML, param2:XML, param3:String, param4:Number = 0) {
      super();
      var _loc5_:* = !!param1.hasOwnProperty("@" + param3)?param1.attribute(param3):param4;
      this.b = _loc5_;
      this.a = _loc5_;
      if(param2) {
         this.b = !!param2.hasOwnProperty("@" + param3)?param2.attribute(param3):param4;
      }
   }
   
   public function add(param1:Number) : void {
      this.a = this.a + param1;
      this.b = this.b + param1;
   }
}

class ComPairTag {
    
   
   public var a:Number;
   
   public var b:Number;
   
   function ComPairTag(param1:XML, param2:XML, param3:String, param4:Number = 0) {
      super();
      var _loc5_:* = !!param1.hasOwnProperty(param3)?param1[param3]:param4;
      this.b = _loc5_;
      this.a = _loc5_;
      if(param2) {
         this.b = !!param2.hasOwnProperty(param3)?param2[param3]:param4;
      }
   }
   
   public function add(param1:Number) : void {
      this.a = this.a + param1;
      this.b = this.b + param1;
   }
}

class ComPairTagBool {
    
   
   public var a:Boolean;
   
   public var b:Boolean;
   
   function ComPairTagBool(param1:XML, param2:XML, param3:String, param4:Boolean = false) {
      super();
      if(param1) {
         this.a = !!param1.hasOwnProperty(param3)?true:Boolean(param4);
      }
      if(param2) {
         this.b = !!param2.hasOwnProperty(param3)?true:Boolean(param4);
      }
   }
}

import kabam.rotmg.text.view.stringBuilder.AppendingLineBuilder;
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

class Effect {
    
   
   public var name_:String;
   
   public var valueReplacements_:Object;
   
   public var replacementColor_:uint = 16777103;
   
   public var color_:uint = 11776947;
   
   function Effect(param1:String, param2:Object) {
      super();
      this.name_ = param1;
      this.valueReplacements_ = param2;
   }
   
   public function setColor(param1:uint) : Effect {
      this.color_ = param1;
      return this;
   }
   
   public function setReplacementsColor(param1:uint) : Effect {
      this.replacementColor_ = param1;
      return this;
   }
   
   public function getValueReplacementsWithColor() : Object {
      var _loc6_:* = null;
      var _loc7_:* = null;
      var _loc3_:* = {};
      var _loc1_:* = "";
      var _loc2_:* = "";
      if(this.replacementColor_) {
         _loc1_ = "</font><font color=\"#" + this.replacementColor_.toString(16) + "\">";
         _loc2_ = "</font><font color=\"#" + this.color_.toString(16) + "\">";
      }
      var _loc4_:* = this.valueReplacements_;
      var _loc9_:int = 0;
      var _loc8_:* = this.valueReplacements_;
      for(_loc6_ in this.valueReplacements_) {
         if(this.valueReplacements_[_loc6_] is AppendingLineBuilder) {
            _loc3_[_loc6_] = this.valueReplacements_[_loc6_];
         } else if(this.valueReplacements_[_loc6_] is LineBuilder) {
            _loc7_ = this.valueReplacements_[_loc6_] as LineBuilder;
            _loc7_.setPrefix(_loc1_).setPostfix(_loc2_);
            _loc3_[_loc6_] = _loc7_;
         } else {
            _loc3_[_loc6_] = _loc1_ + this.valueReplacements_[_loc6_] + _loc2_;
         }
      }
      return _loc3_;
   }
}

class Restriction {
    
   
   public var text_:String;
   
   public var color_:uint;
   
   public var bold_:Boolean;
   
   function Restriction(param1:String, param2:uint, param3:Boolean) {
      super();
      this.text_ = param1;
      this.color_ = param2;
      this.bold_ = param3;
   }
}
