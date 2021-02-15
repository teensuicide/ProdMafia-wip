package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class ClickableTextBase extends Sprite {
       
      
      public var text_:TextFieldDisplayConcrete;
      
      public var defaultColor_:uint = 16777215;
      
      public function ClickableTextBase(param1:int, param2:Boolean, param3:String) {
         super();
         var _loc5_:* = 16777215;
         var _loc4_:* = param3;
         if(_loc4_.indexOf("#") == 0 && _loc4_.length >= 8) {
            _loc5_ = parseInt(_loc4_.substring(1,7),16);
            _loc4_ = _loc4_.substring(8);
            this.defaultColor_ = _loc5_;
         }
         this.text_ = this.makeText().setSize(param1).setColor(_loc5_);
         this.text_.setBold(param2);
         this.text_.setStringBuilder(new LineBuilder().setParams(_loc4_));
         addChild(this.text_);
         this.text_.filters = [new DropShadowFilter(0,0,0)];
         addEventListener("mouseOver",this.onMouseOver,false,0,true);
         addEventListener("mouseOut",this.onMouseOut,false,0,true);
         addEventListener("click",this.onMouseClick,false,0,true);
      }
      
      public function removeOnHoverEvents() : void {
         removeEventListener("mouseOver",this.onMouseOver);
         removeEventListener("mouseOut",this.onMouseOut);
      }
      
      public function setAutoSize(param1:String) : void {
         this.text_.setAutoSize(param1);
      }
      
      public function makeStatic(param1:String) : void {
         this.text_.setStringBuilder(new LineBuilder().setParams(param1));
         this.setDefaultColor(11776947);
         mouseEnabled = false;
         mouseChildren = false;
      }
      
      public function setColor(param1:uint) : void {
         this.text_.setColor(param1);
      }
      
      public function setDefaultColor(param1:uint) : void {
         this.defaultColor_ = param1;
         this.setColor(this.defaultColor_);
      }
      
      protected function makeText() : TextFieldDisplayConcrete {
         return new TextFieldDisplayConcrete();
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.setColor(16768133);
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.setColor(this.defaultColor_);
      }
      
      private function onMouseClick(param1:MouseEvent) : void {
         SoundEffectLibrary.play("button_click");
      }
   }
}
