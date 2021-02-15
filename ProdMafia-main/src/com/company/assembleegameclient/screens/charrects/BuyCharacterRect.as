package com.company.assembleegameclient.screens.charrects {
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.assets.services.IconFactory;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class BuyCharacterRect extends CharacterRect {
      
      public static const BUY_CHARACTER_RECT_CLASS_NAME_TEXT:String = "BuyCharacterRect.classNameText";
       
      
      private var model:PlayerModel;
      
      public function BuyCharacterRect(param1:PlayerModel) {
         super();
         this.model = param1;
         super.color = 2039583;
         super.overColor = 4342338;
         className = new LineBuilder().setParams("BuyCharacterRect.classNameText",{"nth":param1.getMaxCharacters() + 1});
         super.init();
         this.makeIcon();
         this.makeTagline();
         this.makePriceText();
         this.makeCoin();
      }
      
      private function makeCoin() : void {
         var _loc2_:BitmapData = IconFactory.makeCoin();
         var _loc1_:Bitmap = new Bitmap(_loc2_);
         _loc1_.x = 376;
         _loc1_.y = (59 - _loc1_.height) * 0.5 - 1;
         selectContainer.addChild(_loc1_);
      }
      
      private function makePriceText() : void {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setAutoSize("right");
         _loc1_.setStringBuilder(new StaticStringBuilder(this.model.getNextCharSlotPrice().toString()));
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         _loc1_.x = 376;
         _loc1_.y = 19;
         selectContainer.addChild(_loc1_);
      }
      
      private function makeTagline() : void {
         var _loc2_:int = 100 - this.model.getNextCharSlotPrice() / 10;
         var _loc1_:String = String(_loc2_);
         if(_loc2_ != 0) {
            makeTaglineText(new LineBuilder().setParams("BuyCharacterRect.taglineText",{"percentage":_loc1_}));
         }
      }
      
      private function makeIcon() : void {
         var _loc1_:* = null;
         _loc1_ = this.buildIcon();
         _loc1_.x = 13;
         _loc1_.y = (59 - _loc1_.height) * 0.5;
         addChild(_loc1_);
      }
      
      private function buildIcon() : Shape {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(3880246);
         _loc1_.graphics.lineStyle(1,4603457);
         _loc1_.graphics.drawCircle(19,19,19);
         _loc1_.graphics.lineStyle();
         _loc1_.graphics.endFill();
         _loc1_.graphics.beginFill(2039583);
         _loc1_.graphics.drawRect(11,17,16,4);
         _loc1_.graphics.endFill();
         _loc1_.graphics.beginFill(2039583);
         _loc1_.graphics.drawRect(17,11,4,16);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
   }
}
