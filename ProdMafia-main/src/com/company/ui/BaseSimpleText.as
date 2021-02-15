package com.company.ui {
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   
   public class BaseSimpleText extends TextField {
       
      
      public var inputWidth_:int;
      
      public var inputHeight_:int;
      
      public var actualWidth_:int;
      
      public var actualHeight_:int;
      
      public function BaseSimpleText(param1:int, param2:uint, param3:Boolean = false, param4:int = 0, param5:int = 0, param6:Boolean = false) {
         super();
         this.inputWidth_ = param4;
         if(this.inputWidth_ != 0) {
            width = param4;
         }
         this.inputHeight_ = param5;
         if(this.inputHeight_ != 0) {
            height = param5;
         }
         this.embedFonts = true;
         var _loc7_:TextFormat = new TextFormat();
         _loc7_.font = "Myriad Pro";
         _loc7_.bold = param6;
         _loc7_.size = param1;
         _loc7_.color = param2;
         this.defaultTextFormat = _loc7_;
         if(param3) {
            this.selectable = true;
            this.mouseEnabled = true;
            this.type = "input";
            this.border = true;
            this.borderColor = param2;
            this.addEventListener("change",this.onChange,false,0,true);
         } else {
            this.selectable = false;
            this.mouseEnabled = false;
         }
         this.setTextFormat(_loc7_);
      }
      
      public function setFont(param1:String) : void {
         var _loc2_:TextFormat = this.defaultTextFormat;
         _loc2_.font = param1;
         this.applyFormat(_loc2_);
      }
      
      public function setSize(param1:int) : void {
         var _loc2_:TextFormat = this.defaultTextFormat;
         _loc2_.size = param1;
         this.applyFormat(_loc2_);
      }
      
      public function setColor(param1:uint) : void {
         var _loc2_:TextFormat = this.defaultTextFormat;
         _loc2_.color = param1;
         this.applyFormat(_loc2_);
      }
      
      public function setBold(param1:Boolean) : void {
         var _loc2_:TextFormat = this.defaultTextFormat;
         _loc2_.bold = param1;
         this.applyFormat(_loc2_);
      }
      
      public function setAlignment(param1:String) : void {
         var _loc2_:TextFormat = this.defaultTextFormat;
         _loc2_.align = param1;
         this.applyFormat(_loc2_);
      }
      
      public function setText(param1:String) : void {
         this.text = param1;
      }
      
      public function setMultiLine(param1:Boolean) : void {
         this.wordWrap = param1;
      }
      
      public function updateMetrics() : void {
         var _loc3_:int = 0;
         var _loc4_:TextLineMetrics = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.actualWidth_ = 0;
         this.actualHeight_ = 0;
         _loc3_ = 0;
         while(_loc3_ < this.numLines) {
            _loc4_ = this.getLineMetrics(_loc3_);
            _loc1_ = _loc4_.width + 4;
            _loc2_ = _loc4_.height + 4;
            if(_loc1_ > this.actualWidth_) {
               this.actualWidth_ = _loc1_;
            }
            this.actualHeight_ = this.actualHeight_ + _loc2_;
            _loc3_++;
         }
         this.width = this.inputWidth_ == 0?this.actualWidth_:int(this.inputWidth_);
         this.height = this.inputHeight_ == 0?this.actualHeight_:int(this.inputHeight_);
      }
      
      public function useTextDimensions() : void {
         this.width = this.inputWidth_ == 0?this.textWidth + 4:this.inputWidth_;
         this.height = this.inputHeight_ == 0?this.textHeight + 4:this.inputHeight_;
      }
      
      private function applyFormat(param1:TextFormat) : void {
         this.defaultTextFormat = param1;
         this.setTextFormat(param1);
      }
      
      private function onChange(param1:Event) : void {
         this.updateMetrics();
      }
   }
}
