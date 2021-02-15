package com.company.assembleegameclient.objects {
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import flash.display.BitmapData;
   
   public class GuildMerchant extends SellableObject implements IInteractiveObject {
       
      
      public var description_:String;
      
      public function GuildMerchant(param1:XML) {
         super(param1);
         price_ = param1.Price;
         currency_ = 2;
         this.description_ = param1.Description;
         guildRankReq_ = 30;
      }
      
      override public function soldObjectName() : String {
         return ObjectLibrary.typeToDisplayId_[objectType_];
      }
      
      override public function soldObjectInternalName() : String {
         var _loc1_:XML = ObjectLibrary.xmlLibrary_[objectType_];
         return _loc1_.@id.toString();
      }
      
      override public function getTooltip() : ToolTip {
         return new TextToolTip(3552822,10197915,this.soldObjectName(),this.description_,200);
      }
      
      override public function getSellableType() : int {
         return objectType_;
      }
      
      override public function getIcon() : BitmapData {
         return ObjectLibrary.getRedrawnTextureFromType(objectType_,80,true);
      }
   }
}
