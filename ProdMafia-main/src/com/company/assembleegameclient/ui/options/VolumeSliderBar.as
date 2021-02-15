package com.company.assembleegameclient.ui.options {
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   
   public class VolumeSliderBar extends Sprite {
       
      
      public var MIN:Number = 0;
      
      public var MAX:Number = 1;
      
      private var bar:Shape;
      
      private var _label:TextFieldDisplayConcrete;
      
      private var _isMouseDown:Boolean;
      
      private var _mousePoint:Point;
      
      private var _localPoint:Point;
      
      private var _currentVolume:Number;
      
      public function VolumeSliderBar(param1:Number, param2:Number = 16777215, param3:Number = 0, param4:Number = 1) {
         _mousePoint = new Point(0,0);
         _localPoint = new Point(0,0);
         MIN = param3;
         MAX = param4;
         super();
         this.init();
         this.currentVolume = param1;
         this.draw(10197915);
         this._isMouseDown = false;
         this.addEventListener("mouseDown",this.onMouseDown);
         this.addEventListener("mouseUp",this.onMouseUp);
      }
      
      public function get currentVolume() : Number {
         return this._currentVolume;
      }
      
      public function set currentVolume(param1:Number) : void {
         param1 = param1 > this.MAX?this.MAX:Number(param1 < this.MIN?this.MIN:Number(param1));
         this._currentVolume = param1;
         this.draw();
      }
      
      private function init() : void {
         this._label = new TextFieldDisplayConcrete().setSize(14).setColor(11250603);
         this._label.setAutoSize("center").setVerticalAlign("middle");
         this._label.setStringBuilder(new StaticStringBuilder("Vol:"));
         this._label.setBold(true);
         this._label.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         addChild(this._label);
         this.bar = new Shape();
         this.bar.x = 20;
         addChild(this.bar);
         graphics.beginFill(0,0);
         graphics.drawRect(0,-30,130,30);
         graphics.endFill();
      }
      
      private function draw(param1:uint = 10197915) : void {
         var _loc2_:Number = this._currentVolume * 100;
         var _loc3_:Number = _loc2_ * -0.2;
         this.bar.graphics.clear();
         this.bar.graphics.lineStyle(2,10197915);
         this.bar.graphics.moveTo(0,0);
         this.bar.graphics.lineTo(0,-1);
         this.bar.graphics.lineTo(100,-20);
         this.bar.graphics.lineTo(100,0);
         this.bar.graphics.lineTo(0,0);
         this.bar.graphics.beginFill(param1,0.8);
         this.bar.graphics.moveTo(0,0);
         this.bar.graphics.lineTo(0,-1);
         this.bar.graphics.lineTo(_loc2_,_loc3_);
         this.bar.graphics.lineTo(_loc2_,0);
         this.bar.graphics.lineTo(0,0);
         this.bar.graphics.endFill();
      }
      
      private function onMouseDown(param1:MouseEvent) : void {
         this._isMouseDown = true;
         this.currentVolume = param1.localX / 100;
         dispatchEvent(new Event("change",true));
         if(stage) {
            stage.addEventListener("mouseMove",this.onMouseMove);
            stage.addEventListener("mouseUp",this.onMouseUp);
         }
      }
      
      private function onMouseUp(param1:MouseEvent) : void {
         this._isMouseDown = false;
         if(stage) {
            stage.removeEventListener("mouseMove",this.onMouseMove);
         }
      }
      
      private function onMouseMove(param1:MouseEvent) : void {
         if(!this._isMouseDown) {
            return;
         }
         this._mousePoint.x = param1.currentTarget.mouseX;
         this._localPoint = this.globalToLocal(this._mousePoint);
         this.currentVolume = this._localPoint.x / 100;
         dispatchEvent(new Event("change",true));
      }
   }
}
