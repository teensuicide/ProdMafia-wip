package com.company.assembleegameclient.objects {
public class ForgeProperties {
   public var objType:int = -1;
   public var objId:String;
   public var canDismantle:Boolean;
   public var canCraft:Boolean;
   public var description:String;
   public var commonResourceGain:int, rareResourceGain:int, legendaryResourceGain:int;
   public var commonResourceReq:int, rareResourceReq:int, legendaryResourceReq:int;
   public var requiredItem:int = -1, reqItemCount:int;
   public var forgefireCost:int;
   public var forgefireDismantle:int;
   public var blueprintRequired:Boolean;
   public var isIngredient:Boolean;

   public function ForgeProperties(xml:XML) {
      super();

      this.objType = xml.@type;
      this.objId = xml.@id;
      this.canDismantle = "CanDismantle" in xml;
      this.canCraft = "CanCraft" in xml;
      this.description = "Description" in xml ? xml.Description : "";
      var resourceGain:Boolean = "DismantleRequirements" in xml;
      if (resourceGain) {
         this.commonResourceGain = xml.DismantleRequirements.@common;
         this.rareResourceGain = xml.DismantleRequirements.@rare;
         this.legendaryResourceGain = xml.DismantleRequirements.@legendary;
      }

      var resourceReq:Boolean = "CraftRequirements" in xml;
      if (resourceReq) {
         this.commonResourceReq = xml.CraftRequirements.@common;
         this.rareResourceReq = xml.CraftRequirements.@rare;
         this.legendaryResourceReq = xml.CraftRequirements.@legendary;
      }

      var reqItem:Boolean = "RequiredItem" in xml;
      if (reqItem) {
         this.requiredItem = xml.RequiredItem;
         this.reqItemCount = xml.RequiredItem.@quantity;
      }

      this.forgefireCost = "ForgefireCost" in xml ? xml.ForgefireCost : 0;
      this.forgefireDismantle = "ForgefireDismantle" in xml ? xml.ForgefireDismantle : 0;
      this.blueprintRequired = "BlueprintRequired" in xml;
      this.isIngredient = "Ingredient" in xml;
   }
}
}