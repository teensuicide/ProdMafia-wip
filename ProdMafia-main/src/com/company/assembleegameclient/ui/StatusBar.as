package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import org.osflash.signals.Signal;
   
   public class StatusBar extends Sprite {
      
      public static var barTextSignal:Signal = new Signal(int);
       
      
      public const DEFAULT_FILTER:DropShadowFilter = new DropShadowFilter(0,0,0);
      
      public var w_:int;
      
      public var h_:int;
      
      public var color_:uint;
      
      public var backColor_:uint;
      
      public var pulseBackColor:uint;
      
      public var textColor_:uint;
      
      public var val_:int = -1;
      
      public var max_:int = -1;
      
      public var boost_:int = -1;
      
      public var exalted:int = 0;
      
      public var maxMax_:int = -1;
      
      public var level_:int = 0;
      
      public var multiplierIcon:Sprite;
      
      public var mouseOver_:Boolean = false;
      
      public var quest:GameObject = null;
      
      private var labelText_:TextFieldDisplayConcrete;
      
      private var labelTextStringBuilder_:LineBuilder;
      
      private var rightLabelText_:TextFieldDisplayConcrete;
      
      private var rightLabelTextStringBuilder_:LineBuilder;
      
      private var valueText_:TextFieldDisplayConcrete;
      
      private var valueTextStringBuilder_:StaticStringBuilder;
      
      private var boostText_:TextFieldDisplayConcrete;
      
      private var exaltValText:TextFieldDisplayConcrete;
      
      private var multiplierText:TextFieldDisplayConcrete;
      
      private var colorSprite:Sprite;
      
      private var defaultForegroundColor:Number;
      
      private var defaultBackgroundColor:Number;
      
      private var isPulsing:Boolean = false;
      
      private var forceNumText_:Boolean = false;
      
      private var isProgressBar_:Boolean = false;
      
      private var repetitions:int;
      
      private var direction:int = -1;
      
      private var speed:Number = 0.1;
      
      public function StatusBar(param1:int, param2:int, param3:uint, param4:uint, param5:String = null, param6:Boolean = false, param7:GameObject = null, param8:Boolean = false, param9:Boolean = false) {
         colorSprite = new Sprite();
         super();
         this.isProgressBar_ = param9;
         addChild(this.colorSprite);
         this.w_ = param1;
         this.h_ = param2;
         this.forceNumText_ = param6;
         var _loc10_:* = param3;
         this.color_ = _loc10_;
         this.defaultForegroundColor = _loc10_;
         _loc10_ = param4;
         this.backColor_ = _loc10_;
         this.defaultBackgroundColor = _loc10_;
         this.textColor_ = 16777215;
         if(param5 && param5.length != 0) {
            this.labelText_ = new TextFieldDisplayConcrete().setSize(14).setColor(this.textColor_);
            this.labelText_.setBold(true);
            this.labelTextStringBuilder_ = new LineBuilder().setParams(param5);
            this.labelText_.setStringBuilder(this.labelTextStringBuilder_);
            this.centerVertically(this.labelText_);
            this.labelText_.filters = [DEFAULT_FILTER];
            addChild(this.labelText_);
         }
         if(param8) {
            this.rightLabelText_ = new TextFieldDisplayConcrete().setSize(14).setColor(this.textColor_);
            this.rightLabelText_.setBold(true);
            this.rightLabelTextStringBuilder_ = new LineBuilder().setParams("0%");
            this.rightLabelText_.setStringBuilder(this.labelTextStringBuilder_);
            this.centerVertically(this.rightLabelText_);
            this.rightLabelText_.filters = [DEFAULT_FILTER];
            addChild(this.rightLabelText_);
         }
         this.valueText_ = new TextFieldDisplayConcrete().setSize(14).setColor(16777215);
         this.valueText_.setBold(true);
         this.valueText_.filters = [DEFAULT_FILTER];
         this.centerVertically(this.valueText_);
         this.valueTextStringBuilder_ = new StaticStringBuilder();
         this.boostText_ = new TextFieldDisplayConcrete().setSize(14).setColor(this.textColor_);
         this.boostText_.setBold(true);
         this.boostText_.alpha = 0.6;
         this.centerVertically(this.boostText_);
         this.boostText_.filters = [DEFAULT_FILTER];
         this.exaltValText = new TextFieldDisplayConcrete().setSize(14).setColor(1010609);
         this.exaltValText.setBold(true);
         this.exaltValText.alpha = 0.6;
         this.centerVertically(this.exaltValText);
         this.exaltValText.filters = [DEFAULT_FILTER];
         this.multiplierIcon = new Sprite();
         this.multiplierIcon.x = this.w_ - 25;
         this.multiplierIcon.y = -3;
         this.multiplierIcon.graphics.beginFill(16711935,0);
         this.multiplierIcon.graphics.drawRect(0,0,20,20);
         this.multiplierIcon.addEventListener("mouseOver",this.onMultiplierOver,false,0,true);
         this.multiplierIcon.addEventListener("mouseOut",this.onMultiplierOut,false,0,true);
         this.multiplierText = new TextFieldDisplayConcrete().setSize(14).setColor(9493531);
         this.multiplierText.setBold(true);
         this.multiplierText.setStringBuilder(new StaticStringBuilder("x2"));
         this.multiplierText.filters = [DEFAULT_FILTER];
         this.multiplierIcon.addChild(this.multiplierText);
         if(!this.bTextEnabled(Parameters.data.toggleBarText)) {
            addEventListener("rollOver",this.onMouseOver,false,0,true);
            addEventListener("rollOut",this.onMouseOut,false,0,true);
         }
         quest = param7;
         barTextSignal.add(this.setBarText);
      }
      
      public function centerVertically(param1:TextFieldDisplayConcrete) : void {
         param1.setVerticalAlign("middle");
         param1.y = int(this.h_ / 2);
      }
      
      public function draw(param1:int, param2:int, param3:int, param4:int = -1, param5:int = 0, param6:int = 0) : void {
         if(param2 > 0) {
            param1 = Math.min(param2,Math.max(0,param1));
         }
         if(param1 == this.val_ && param2 == this.max_ && param3 == this.boost_ && param4 == this.maxMax_ && param6 == this.exalted) {
            return;
         }
         this.val_ = param1;
         this.max_ = param2;
         this.boost_ = param3;
         this.exalted = param6;
         this.maxMax_ = param4;
         this.level_ = param5;
         this.internalDraw();
      }
      
      public function setLabelText(param1:String, param2:Object = null) : void {
         this.labelTextStringBuilder_.setParams(param1,param2);
         this.labelText_.setStringBuilder(this.labelTextStringBuilder_);
      }
      
      public function setBarText(param1:int) : void {
         this.mouseOver_ = false;
         if(this.bTextEnabled(param1)) {
            removeEventListener("rollOver",this.onMouseOver);
            removeEventListener("rollOut",this.onMouseOut);
         } else {
            addEventListener("rollOver",this.onMouseOver);
            addEventListener("rollOut",this.onMouseOut);
         }
         this.internalDraw();
      }
      
      public function drawWithMouseOver() : void {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:String = "";
         if(Parameters.data.toggleToMaxText) {
            _loc1_ = this.maxMax_ - (this.max_ - this.boost_);
            if(this.level_ >= 20 && _loc1_ > 0) {
               _loc3_ = _loc3_ + ("|" + Math.ceil(_loc1_ * 0.2));
            }
         }
         if(this.max_ > 0) {
            this.valueText_.setStringBuilder(this.valueTextStringBuilder_.setString(this.val_ + "/" + this.max_ + _loc3_));
         } else {
            this.valueText_.setStringBuilder(this.valueTextStringBuilder_.setString("" + this.val_));
         }
         if(!contains(this.valueText_)) {
            this.valueText_.mouseEnabled = false;
            this.valueText_.mouseChildren = false;
            addChild(this.valueText_);
         }
         if(this.boost_ - this.exalted != 0 || this.exalted != 0) {
            _loc2_ = "";
            if(this.boost_ - this.exalted != 0) {
               _loc2_ = _loc2_ + (" (" + (this.boost_ - this.exalted > 0?"+":"") + (this.boost_ - this.exalted).toString() + ")");
            }
            this.boostText_.setStringBuilder(this.valueTextStringBuilder_.setString(_loc2_));
            if(!contains(this.boostText_)) {
               this.boostText_.mouseEnabled = false;
               this.boostText_.mouseChildren = false;
               addChild(this.boostText_);
            }
            if(this.exalted != 0) {
               this.exaltValText.setStringBuilder(this.valueTextStringBuilder_.setString(" (+" + this.exalted + ")"));
               if(!contains(this.exaltValText)) {
                  this.exaltValText.mouseEnabled = false;
                  this.exaltValText.mouseChildren = false;
                  addChild(this.exaltValText);
               }
            }
            this.valueText_.x = this.w_ * 0.5 - (this.valueText_.width + (this.boostText_.width != 0?this.boostText_.width - 4:0) + (this.exaltValText.width != 0?this.exaltValText.width - 4:0)) * 0.5;
            this.boostText_.x = this.valueText_.x + this.valueText_.width - 4;
            this.exaltValText.x = !!contains(this.boostText_)?this.boostText_.x + this.boostText_.width - 4:Number(this.valueText_.x + this.valueText_.width - 4);
         } else {
            this.valueText_.x = this.w_ * 0.5 - this.valueText_.width * 0.5;
            if(this.boost_ == 0 && contains(this.boostText_)) {
               removeChild(this.boostText_);
            }
            if(this.exalted == 0 && contains(this.exaltValText)) {
               removeChild(this.exaltValText);
            }
         }
      }
      
      public function showMultiplierText() : void {
         this.multiplierIcon.mouseEnabled = false;
         this.multiplierIcon.mouseChildren = false;
         addChild(this.multiplierIcon);
         this.startPulse(3,9493531,16777215);
      }
      
      public function hideMultiplierText() : void {
         if(this.multiplierIcon.parent) {
            removeChild(this.multiplierIcon);
         }
      }
      
      public function startPulse(param1:Number, param2:Number, param3:Number) : void {
         this.isPulsing = true;
         this.color_ = param2;
         this.pulseBackColor = param3;
         this.repetitions = param1;
         this.internalDraw();
         addEventListener("enterFrame",this.onPulse,false,0,true);
      }
      
      private function setTextColor(param1:uint) : void {
         this.textColor_ = param1;
         if(this.boostText_ != null) {
            this.boostText_.setColor(this.textColor_);
         }
         this.valueText_.setColor(this.textColor_);
      }
      
      private function bTextEnabled(param1:int) : Boolean {
         return param1 && (param1 == 1 || param1 == 2 && this.isProgressBar_ || param1 == 3 && !this.isProgressBar_);
      }
      
      private function internalDraw() : void {
         graphics.clear();
         this.colorSprite.graphics.clear();
         var _loc1_:int = 16777215;
         if(this.maxMax_ > 0 && this.max_ - this.boost_ == this.maxMax_) {
            _loc1_ = 16572160;
         } else if(this.boost_ > 0) {
            _loc1_ = 6206769;
         }
         if(this.textColor_ != _loc1_) {
            this.setTextColor(_loc1_);
         }
         graphics.beginFill(this.backColor_);
         graphics.drawRect(0,0,this.w_,this.h_);
         graphics.endFill();
         if(this.isPulsing) {
            this.colorSprite.graphics.beginFill(this.pulseBackColor);
            this.colorSprite.graphics.drawRect(0,0,this.w_,this.h_);
         }
         this.colorSprite.graphics.beginFill(this.color_);
         if(this.max_ > 0) {
            this.colorSprite.graphics.drawRect(0,0,this.w_ * (this.val_ / this.max_),this.h_);
         } else {
            this.colorSprite.graphics.drawRect(0,0,this.w_,this.h_);
         }
         this.colorSprite.graphics.endFill();
         if(this.bTextEnabled(Parameters.data.toggleBarText) || this.mouseOver_ && this.h_ > 4 || this.forceNumText_) {
            this.drawWithMouseOver();
         } else {
            if(contains(this.valueText_)) {
               removeChild(this.valueText_);
            }
            if(contains(this.boostText_)) {
               removeChild(this.boostText_);
            }
            if(contains(this.exaltValText)) {
               removeChild(this.exaltValText);
            }
         }
      }
      
      private function onMultiplierOver(param1:MouseEvent) : void {
         dispatchEvent(new Event("MULTIPLIER_OVER"));
      }
      
      private function onMultiplierOut(param1:MouseEvent) : void {
         dispatchEvent(new Event("MULTIPLIER_OUT"));
      }
      
      private function onPulse(param1:Event) : void {
         if(this.colorSprite.alpha > 1 || this.colorSprite.alpha < 0) {
            this.direction = this.direction * -1;
            if(this.colorSprite.alpha > 1) {
               this.repetitions--;
               if(!this.repetitions) {
                  this.isPulsing = false;
                  this.color_ = this.defaultForegroundColor;
                  this.backColor_ = this.defaultBackgroundColor;
                  this.colorSprite.alpha = 1;
                  this.internalDraw();
                  removeEventListener("enterFrame",this.onPulse);
               }
            }
         }
         this.colorSprite.alpha = this.colorSprite.alpha + this.speed * this.direction;
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         this.mouseOver_ = true;
         this.internalDraw();
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.mouseOver_ = false;
         this.internalDraw();
      }
   }
}
