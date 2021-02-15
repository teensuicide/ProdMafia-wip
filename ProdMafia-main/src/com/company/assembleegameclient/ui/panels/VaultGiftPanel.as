package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.objects.VaultGiftContainer;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.model.HUDModel;
   
   public class VaultGiftPanel extends Panel {
       
      
      private var owner:VaultGiftContainer;
      
      private var nameText:StaticTextDisplay;
      
      public function VaultGiftPanel(param1:AGameSprite, param2:VaultGiftContainer) {
         super(param1);
         var _loc3_:HUDModel = StaticInjectorContext.getInjector().getInstance(HUDModel);
         this.owner = param2;
         this.nameText = new StaticTextDisplay();
         this.nameText.setSize(18).setColor(16777215).setTextWidth(188).setWordWrap(true).setMultiLine(true).setAutoSize("center").setBold(true).setHTML(true);
         this.nameText.setStringBuilder(new LineBuilder().setParams("Gifts\n" + Number(_loc3_.giftContents.length)).setPrefix("<p align=\"center\">").setPostfix("</p>"));
         this.nameText.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText);
      }
      
      override public function draw() : void {
      }
   }
}
