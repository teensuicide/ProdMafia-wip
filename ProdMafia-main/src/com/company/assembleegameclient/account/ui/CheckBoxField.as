package com.company.assembleegameclient.account.ui {
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   
   public class CheckBoxField extends Sprite {
      
      private static const BOX_SIZE:int = 20;
       
      
      public var checkBox_:Sprite;
      
      public var text_:TextFieldDisplayConcrete;
      
      public var errorText_:TextFieldDisplayConcrete;
      
      private var checked_:Boolean;
      
      private var hasError:Boolean;
      
      public function CheckBoxField(param1:String, param2:Boolean, param3:uint = 16, param4:uint = 11776947) {
         super();
         this.checked_ = param2;
         this.checkBox_ = new Sprite();
         this.checkBox_.x = 2;
         this.checkBox_.y = 2;
         this.redrawCheckBox();
         this.checkBox_.addEventListener("click",this.onClick);
         addChild(this.checkBox_);
         this.text_ = new TextFieldDisplayConcrete().setSize(param3).setColor(param4);
         this.text_.setTextWidth(243);
         this.text_.x = this.checkBox_.x + 20 + 8;
         this.text_.setBold(true);
         this.text_.setMultiLine(true);
         this.text_.setWordWrap(true);
         this.text_.setHTML(true);
         this.text_.setStringBuilder(new LineBuilder().setParams(param1));
         this.text_.mouseEnabled = true;
         this.text_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.text_);
         this.errorText_ = new TextFieldDisplayConcrete().setSize(12).setColor(16549442);
         this.errorText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.errorText_);
         this.text_.textChanged.addOnce(this.onTextChanged);
      }
      
      public function isChecked() : Boolean {
         return this.checked_;
      }
      
      public function setChecked() : void {
         this.checked_ = true;
         this.redrawCheckBox();
      }
      
      public function setUnchecked() : void {
         this.checked_ = false;
         this.redrawCheckBox();
      }
      
      public function setError(param1:String) : void {
         this.errorText_.setStringBuilder(new LineBuilder().setParams(param1));
      }
      
      public function setTextStringBuilder(param1:StringBuilder) : void {
         this.text_.setStringBuilder(param1);
      }
      
      public function setErrorHighlight(param1:Boolean) : void {
         this.hasError = param1;
         this.redrawCheckBox();
      }
      
      private function onTextChanged() : void {
         this.errorText_.x = this.text_.x;
         this.errorText_.y = this.text_.y + 20;
      }
      
      private function redrawCheckBox() : void {
         var _loc1_:* = NaN;
         var _loc2_:Graphics = this.checkBox_.graphics;
         _loc2_.clear();
         _loc2_.beginFill(3355443,1);
         _loc2_.drawRect(0,0,20,20);
         _loc2_.endFill();
         if(this.checked_) {
            _loc2_.lineStyle(4,11776947,1,false,"normal","round","round");
            _loc2_.moveTo(2,2);
            _loc2_.lineTo(18,18);
            _loc2_.moveTo(2,18);
            _loc2_.lineTo(18,2);
            _loc2_.lineStyle();
            this.hasError = false;
         }
         if(this.hasError) {
            _loc1_ = 16549442;
         } else {
            _loc1_ = 4539717;
         }
         _loc2_.lineStyle(2,_loc1_,1,false,"normal","round","round");
         _loc2_.drawRect(0,0,20,20);
         _loc2_.lineStyle();
      }
      
      private function onClick(param1:MouseEvent) : void {
         this.errorText_.setStringBuilder(new StaticStringBuilder(""));
         this.checked_ = !this.checked_;
         this.redrawCheckBox();
      }
   }
}
