package com.company.assembleegameclient.account.ui {
   import com.company.ui.BaseSimpleText;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class TextInputField extends Sprite {
      
      public static const BACKGROUND_COLOR:uint = 3355443;
      
      public static const ERROR_BORDER_COLOR:uint = 16549442;
      
      public static const NORMAL_BORDER_COLOR:uint = 4539717;
       
      
      public var nameText_:TextFieldDisplayConcrete;
      
      public var inputText_:BaseSimpleText;
      
      public var errorText_:TextFieldDisplayConcrete;
      
      private var textInputFieldWidth:int = 0;
      
      public function TextInputField(param1:String, param2:Boolean = false, param3:Number = 238, param4:Number = 30, param5:Number = 18, param6:int = -1, param7:Boolean = false) {
         super();
         this.tabEnabled = false;
         this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(11776947);
         this.inputText_ = new BaseSimpleText(param5,11776947,true,param3,param4);
         if(param1 != "") {
            this.nameText_.setBold(true);
            this.nameText_.setStringBuilder(new LineBuilder().setParams(param1));
            this.nameText_.filters = [new DropShadowFilter(0,0,0)];
            addChild(this.nameText_);
            this.inputText_.y = 30;
         } else {
            this.inputText_.y = 0;
         }
         if(this.textInputFieldWidth != 0) {
            this.nameText_.setTextWidth(this.textInputFieldWidth);
            this.nameText_.setMultiLine(true);
            this.nameText_.setWordWrap(true);
            this.nameText_.textChanged.add(this.textFieldWasCreatedHandler);
         }
         this.nameText_.setBold(true);
         this.nameText_.setStringBuilder(new LineBuilder().setParams(param1));
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText_);
         this.inputText_ = new BaseSimpleText(20,11776947,true,238,30);
         this.inputText_.y = 30;
         this.inputText_.x = 6;
         this.inputText_.border = false;
         this.inputText_.displayAsPassword = param2;
         this.inputText_.updateMetrics();
         this.inputText_.setMultiLine(param7);
         if(param6 > 1) {
            this.inputText_.maxChars = param6;
         }
         addChild(this.inputText_);
         graphics.lineStyle(2,4539717,1,false,"normal","round","round");
         graphics.beginFill(3355443,1);
         graphics.drawRect(0,this.inputText_.y,param3,param4);
         graphics.endFill();
         graphics.lineStyle();
         this.drawInputBorders(false);
         this.inputText_.addEventListener("change",this.onInputChange);
         this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
         this.errorText_.setMultiLine(true);
         this.errorText_.y = this.inputText_.y + param4 + 1;
         this.errorText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.errorText_);
      }
      
      override public function get height() : Number {
         return this.errorText_.y + this.errorText_.height + 10;
      }
      
      public function text() : String {
         return this.inputText_.text;
      }
      
      public function clearText() : void {
         this.inputText_.text = "";
      }
      
      public function setErrorHighlight(param1:Boolean) : void {
         this.drawInputBorders(param1);
      }
      
      public function setError(param1:String, param2:Object = null) : void {
         this.errorText_.setStringBuilder(new LineBuilder().setParams(param1,param2));
         this.inputText_.addEventListener("change",this.onClearError);
      }
      
      public function clearError() : void {
         this.errorText_.setStringBuilder(new StaticStringBuilder(""));
      }
      
      private function drawInputBorders(param1:Boolean) : void {
         var _loc2_:uint = !!param1?16549442:4539717;
         graphics.clear();
         graphics.lineStyle(2,_loc2_,1,false,"normal","round","round");
         graphics.beginFill(3355443,1);
         graphics.drawRect(0,this.inputText_.y,238,30);
         graphics.endFill();
         graphics.lineStyle();
      }
      
      private function textFieldWasCreatedHandler() : void {
         if(this.textInputFieldWidth != 0) {
            this.inputText_.y = this.nameText_.getTextHeight() + 8;
            this.drawInputBorders(false);
         }
      }
      
      public function onInputChange(param1:Event) : void {
         this.errorText_.setStringBuilder(new StaticStringBuilder(""));
      }
      
      public function onClearError(param1:Event) : void {
         this.inputText_.removeEventListener("change",this.onClearError);
         this.clearError();
      }
   }
}
