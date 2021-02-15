package com.company.assembleegameclient.screens.charrects {
   import com.company.rotmg.graphics.StarGraphic;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   
   public class CharacterRect extends Sprite {
      
      public static const WIDTH:int = 419;
      
      public static const HEIGHT:int = 59;
       
      
      public var color:uint;
      
      public var overColor:uint;
      
      public var selectContainer:Sprite;
      
      protected var taglineIcon:Sprite;
      
      protected var taglineText:TextFieldDisplayConcrete;
      
      protected var classNameText:TextFieldDisplayConcrete;
      
      protected var className:StringBuilder;
      
      private var box:Shape;
      
      private var seasonalOverlay:Shape;
      
      public function CharacterRect() {
         box = new Shape();
         seasonalOverlay = new Shape();
         super();
      }
      
      protected static function makeDropShadowFilter() : Array {
         return [new DropShadowFilter(0,0,0,1,8,8)];
      }
      
      public function init() : void {
         tabChildren = false;
         this.makeBox();
         this.makeSeasonalOverlay();
         this.makeContainer();
         this.makeClassNameText();
         this.addEventListeners();
      }
      
      public function makeBox() : void {
         this.drawBox(false);
         addChild(this.box);
      }
      
      public function setSeasonalOverlay(param1:Boolean) : void {
         this.seasonalOverlay.visible = param1;
      }
      
      public function makeContainer() : void {
         this.selectContainer = new Sprite();
         this.selectContainer.mouseChildren = false;
         this.selectContainer.buttonMode = true;
         this.selectContainer.graphics.beginFill(16711935,0);
         this.selectContainer.graphics.drawRect(0,0,419,59);
         addChild(this.selectContainer);
      }
      
      protected function makeTaglineIcon() : void {
         this.taglineIcon = new StarGraphic();
         this.taglineIcon.transform.colorTransform = new ColorTransform(0.701960784313725,0.701960784313725,0.701960784313725);
         this.taglineIcon.scaleX = 1.2;
         this.taglineIcon.scaleY = 1.2;
         this.taglineIcon.x = 66;
         this.taglineIcon.y = 30;
         this.taglineIcon.filters = [new DropShadowFilter(0,0,0)];
         this.selectContainer.addChild(this.taglineIcon);
      }
      
      protected function makeClassNameText() : void {
         this.classNameText = new TextFieldDisplayConcrete().setSize(18).setColor(16777215);
         this.classNameText.setBold(true);
         this.classNameText.setStringBuilder(this.className);
         this.classNameText.filters = makeDropShadowFilter();
         this.classNameText.x = 66;
         this.classNameText.y = 4;
         this.selectContainer.addChild(this.classNameText);
      }
      
      protected function makeTaglineText(param1:StringBuilder) : void {
         this.taglineText = new TextFieldDisplayConcrete().setSize(14).setColor(11776947);
         this.taglineText.setStringBuilder(param1);
         this.taglineText.filters = makeDropShadowFilter();
         this.taglineText.x = 68;
         this.taglineText.y = 30;
         this.selectContainer.addChild(this.taglineText);
      }
      
      private function addEventListeners() : void {
         addEventListener("mouseOver",this.onMouseOver,false,0,true);
         addEventListener("rollOut",this.onRollOut,false,0,true);
      }
      
      private function makeSeasonalOverlay() : void {
         this.seasonalOverlay.graphics.beginFill(6423144,0.6);
         this.seasonalOverlay.graphics.drawRect(0,0,419,59);
         this.seasonalOverlay.graphics.endFill();
         this.seasonalOverlay.visible = false;
         addChild(this.seasonalOverlay);
      }
      
      private function drawBox(param1:Boolean) : void {
         this.box.graphics.clear();
         this.box.graphics.beginFill(!!param1?this.overColor:uint(this.color));
         this.box.graphics.drawRect(0,0,419,59);
         this.box.graphics.endFill();
      }
      
      protected function onMouseOver(param1:MouseEvent) : void {
         this.drawBox(true);
      }
      
      protected function onRollOut(param1:MouseEvent) : void {
         this.drawBox(false);
      }
   }
}
