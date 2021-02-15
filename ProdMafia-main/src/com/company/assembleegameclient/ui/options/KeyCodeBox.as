package com.company.assembleegameclient.ui.options {
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.KeyCodes;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   
   public class KeyCodeBox extends Sprite {
      
      public static const WIDTH:int = 80;
      
      public static const HEIGHT:int = 32;
       
      
      public var keyCode_:uint;
      
      public var selected_:Boolean;
      
      public var inputMode_:Boolean;
      
      private var char_:TextFieldDisplayConcrete = null;
      
      public function KeyCodeBox(param1:uint, param2:uint = 16777215) {
         super();
         this.keyCode_ = param1;
         this.selected_ = false;
         this.inputMode_ = false;
         this.char_ = new TextFieldDisplayConcrete().setSize(16).setColor(param2);
         this.char_.setBold(true);
         this.char_.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         this.char_.setAutoSize("center").setVerticalAlign("middle");
         addChild(this.char_);
         this.drawBackground();
         this.setNormalMode();
         addEventListener("mouseOver",this.onMouseOver);
         addEventListener("rollOut",this.onRollOut);
      }
      
      public function value() : uint {
         return this.keyCode_;
      }
      
      public function setKeyCode(param1:uint) : void {
         if(param1 == this.keyCode_) {
            return;
         }
         this.keyCode_ = param1;
         this.setTextToKey();
         dispatchEvent(new Event("change",true));
      }
      
      public function setTextToKey() : void {
         this.setText(new StaticStringBuilder(KeyCodes.CharCodeStrings[this.keyCode_]));
      }
      
      private function drawBackground() : void {
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         _loc1_.lineStyle(2,this.selected_ || this.inputMode_?11776947:4473924);
         _loc1_.beginFill(3355443);
         _loc1_.drawRect(0,0,80,32);
         _loc1_.endFill();
         _loc1_.lineStyle();
      }
      
      private function setText(param1:StringBuilder) : void {
         this.char_.setStringBuilder(param1);
         this.char_.x = 40;
         this.char_.y = 16;
         this.drawBackground();
      }
      
      private function setNormalMode() : void {
         this.inputMode_ = false;
         removeEventListener("enterFrame",this.onInputEnterFrame);
         if(stage != null) {
            removeEventListener("keyDown",this.onInputKeyDown);
            stage.removeEventListener("mouseDown",this.onInputMouseDown,true);
         }
         this.setTextToKey();
         addEventListener("click",this.onNormalClick);
      }
      
      private function setInputMode() : void {
         if(stage == null) {
            return;
         }
         stage.stageFocusRect = false;
         stage.focus = this;
         this.inputMode_ = true;
         removeEventListener("click",this.onNormalClick);
         addEventListener("enterFrame",this.onInputEnterFrame);
         addEventListener("keyDown",this.onInputKeyDown);
         stage.addEventListener("mouseDown",this.onInputMouseDown,true);
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.selected_ = true;
         this.drawBackground();
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this.selected_ = false;
         this.drawBackground();
      }
      
      private function onNormalClick(param1:MouseEvent) : void {
         this.setInputMode();
      }
      
      private function onInputEnterFrame(param1:Event) : void {
         var _loc2_:* = TimeUtil.getTrueTime() / 400 % 2 == 0;
         if(_loc2_) {
            this.setText(new StaticStringBuilder(""));
         } else {
            this.setText(new LineBuilder().setParams("KeyCodeBox.hitKey"));
         }
      }
      
      private function onInputKeyDown(param1:KeyboardEvent) : void {
         param1.stopImmediatePropagation();
         this.keyCode_ = param1.keyCode;
         this.setNormalMode();
         dispatchEvent(new Event("change",true));
      }
      
      private function onInputMouseDown(param1:MouseEvent) : void {
         this.setNormalMode();
      }
   }
}
