package com.company.assembleegameclient.ui.language {
   import com.company.assembleegameclient.screens.TitleMenuOption;
   import com.company.rotmg.graphics.ScreenGraphic;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.components.ScreenBase;
   import kabam.rotmg.ui.view.components.dropdown.LocalizedDropDown;
   import org.osflash.signals.Signal;
   
   public class LanguageOptionOverlay extends ScreenBase {
       
      
      public var languageSelected:Signal;
      
      public var back:Signal;
      
      private var title_:TextFieldDisplayConcrete;
      
      private var continueButton_:TitleMenuOption;
      
      private var languageDropDownLabel:TextFieldDisplayConcrete;
      
      private var languageDropDown:LocalizedDropDown;
      
      public function LanguageOptionOverlay() {
         languageSelected = new Signal(String);
         back = new Signal();
         this.title_ = this.makeTitle();
         this.continueButton_ = this.makeContinueButton();
         this.languageDropDownLabel = this.makeDropDownLabel();
         super();
         addChild(this.makeLine());
         addChild(this.title_);
         addChild(new ScreenGraphic());
         addChild(this.continueButton_);
      }
      
      public function setLanguageDropdown(param1:Vector.<String>) : void {
         this.languageDropDown = new LocalizedDropDown(param1);
         this.languageDropDown.y = 100;
         this.languageDropDown.addEventListener("change",this.onLanguageSelected);
         addChild(this.languageDropDown);
         this.languageDropDownLabel.textChanged.addOnce(this.positionDropdownLabel);
         addChild(this.languageDropDownLabel);
         this.languageDropDownLabel.y = this.languageDropDown.y + this.languageDropDown.getClosedHeight() / 2;
      }
      
      public function setSelected(param1:String) : void {
      }
      
      public function clear() : void {
         if(this.languageDropDown && contains(this.languageDropDown)) {
            removeChild(this.languageDropDown);
         }
      }
      
      private function positionDropdownLabel() : void {
         this.languageDropDown.x = 400 - (this.languageDropDown.width + this.languageDropDownLabel.width + 10) / 2;
         this.languageDropDownLabel.x = this.languageDropDown.x + this.languageDropDown.width + 10;
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(36).setColor(16777215);
         _loc1_.setBold(true);
         _loc1_.setStringBuilder(new LineBuilder().setParams("LanguagesScreen.title"));
         _loc1_.setAutoSize("center");
         _loc1_.filters = [new DropShadowFilter(0,0,0)];
         _loc1_.x = 400 - _loc1_.width / 2;
         _loc1_.y = 16;
         return _loc1_;
      }
      
      private function makeContinueButton() : TitleMenuOption {
         var _loc1_:* = null;
         _loc1_ = new TitleMenuOption("Options.continueButton",36,false);
         _loc1_.setAutoSize("center");
         _loc1_.setVerticalAlign("middle");
         _loc1_.addEventListener("click",this.onContinueClick);
         _loc1_.x = 400;
         _loc1_.y = 550;
         return _loc1_;
      }
      
      private function makeDropDownLabel() : TextFieldDisplayConcrete {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(16).setColor(11776947).setBold(true);
         _loc1_.setVerticalAlign("middle");
         _loc1_.filters = [new DropShadowFilter(0,0,0,0.5,12,12)];
         _loc1_.setStringBuilder(new LineBuilder().setParams("LanguagesScreen.option"));
         return _loc1_;
      }
      
      private function makeLine() : Shape {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.lineStyle(1,6184542);
         _loc1_.graphics.moveTo(0,70);
         _loc1_.graphics.lineTo(800,70);
         _loc1_.graphics.lineStyle();
         return _loc1_;
      }
      
      private function onContinueClick(param1:MouseEvent) : void {
         this.back.dispatch();
      }
      
      private function onLanguageSelected(param1:Event) : void {
         this.languageSelected.dispatch(this.languageDropDown.getValue());
      }
   }
}
