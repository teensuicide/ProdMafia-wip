package com.company.assembleegameclient.ui.menu {
   import com.company.assembleegameclient.objects.Player;
   import com.company.util.AssetLibrary;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class TeleportMenuOption extends MenuOption {
      
      private static const inactiveCT:ColorTransform = new ColorTransform(0.329411764705882,0.329411764705882,0.329411764705882);
       
      
      private var player_:Player;
      
      private var mouseOver_:Boolean = false;
      
      private var barText_:TextFieldDisplayConcrete;
      
      private var barTextOrigWidth_:int;
      
      private var barMask:Shape;
      
      public function TeleportMenuOption(param1:Player) {
         barMask = new Shape();
         super(AssetLibrary.getImageFromSet("lofiInterface2",3),16777215,"TeleportMenuOption.title");
         this.player_ = param1;
         this.barText_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215);
         this.barText_.setBold(true);
         this.barText_.setStringBuilder(new LineBuilder().setParams("TeleportMenuOption.title"));
         var _loc2_:* = text_.x;
         this.barMask.x = _loc2_;
         this.barText_.x = _loc2_;
         _loc2_ = text_.y;
         this.barMask.y = _loc2_;
         this.barText_.y = _loc2_;
         this.barText_.textChanged.add(this.onTextChanged);
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      }
      
      private function onTextChanged() : void {
         this.barTextOrigWidth_ = this.barText_.textField.width;
         this.barMask.graphics.beginFill(16711935);
         this.barMask.graphics.drawRect(0,0,this.barText_.textField.width,this.barText_.textField.height);
      }
      
      override protected function onMouseOver(param1:MouseEvent) : void {
         this.mouseOver_ = true;
      }
      
      override protected function onMouseOut(param1:MouseEvent) : void {
         this.mouseOver_ = false;
      }
      
      private function onAddedToStage(param1:Event) : void {
         addEventListener("enterFrame",this.onEnterFrame,false,0,true);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("enterFrame",this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void {
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         var _loc2_:int = this.player_.msUtilTeleport();
         if(_loc2_ > 0) {
            _loc4_ = _loc2_ <= 10000?10000:120000;
            if(!contains(this.barText_)) {
               addChild(this.barText_);
               addChild(this.barMask);
               this.barText_.mask = this.barMask;
            }
            _loc3_ = this.barTextOrigWidth_ * (1 - _loc2_ / _loc4_);
            this.barMask.width = _loc3_;
            setColorTransform(inactiveCT);
         } else {
            if(contains(this.barText_)) {
               removeChild(this.barText_);
            }
            if(this.mouseOver_) {
               setColorTransform(mouseOverCT);
            } else {
               setColorTransform(null);
            }
         }
      }
   }
}
