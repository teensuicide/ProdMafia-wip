package com.company.assembleegameclient.account.ui {
   import com.company.assembleegameclient.account.ui.components.Selectable;
   import com.company.assembleegameclient.account.ui.components.SelectionGroup;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import kabam.lib.ui.api.Layout;
   import kabam.lib.ui.impl.HorizontalLayout;
   import kabam.rotmg.ui.view.SignalWaiter;
   
   public class PaymentMethodRadioButtons extends Sprite {
       
      
      private const waiter:SignalWaiter = new SignalWaiter();
      
      private var labels:Vector.<String>;
      
      private var boxes:Vector.<PaymentMethodRadioButton>;
      
      private var group:SelectionGroup;
      
      public function PaymentMethodRadioButtons(param1:Vector.<String>) {
         super();
         this.labels = param1;
         this.waiter.complete.add(this.alignRadioButtons);
         this.makeRadioButtons();
         this.alignRadioButtons();
         this.makeSelectionGroup();
      }
      
      public function setSelected(param1:String) : void {
         this.group.setSelected(param1);
      }
      
      public function getSelected() : String {
         return this.group.getSelected().getValue();
      }
      
      private function makeRadioButtons() : void {
         var _loc1_:int = 0;
         var _loc2_:int = this.labels.length;
         this.boxes = new Vector.<PaymentMethodRadioButton>(_loc2_,true);
         while(_loc1_ < _loc2_) {
            this.boxes[_loc1_] = this.makeRadioButton(this.labels[_loc1_]);
            _loc1_++;
         }
      }
      
      private function makeRadioButton(param1:String) : PaymentMethodRadioButton {
         var _loc2_:PaymentMethodRadioButton = new PaymentMethodRadioButton(param1);
         _loc2_.addEventListener("click",this.onSelected);
         this.waiter.push(_loc2_.textSet);
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function alignRadioButtons() : void {
         var _loc2_:Vector.<DisplayObject> = this.castBoxesToDisplayObjects();
         var _loc1_:Layout = new HorizontalLayout();
         _loc1_.setPadding(20);
         _loc1_.layout(_loc2_);
      }
      
      private function castBoxesToDisplayObjects() : Vector.<DisplayObject> {
         var _loc3_:int = 0;
         var _loc2_:int = this.boxes.length;
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         while(_loc3_ < _loc2_) {
            _loc1_[_loc3_] = this.boxes[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function makeSelectionGroup() : void {
         var _loc1_:Vector.<Selectable> = this.castBoxesToSelectables();
         this.group = new SelectionGroup(_loc1_);
         this.group.setSelected(this.boxes[0].getValue());
      }
      
      private function castBoxesToSelectables() : Vector.<Selectable> {
         var _loc3_:int = 0;
         var _loc2_:int = this.boxes.length;
         var _loc1_:Vector.<Selectable> = new Vector.<Selectable>(0);
         while(_loc3_ < _loc2_) {
            _loc1_[_loc3_] = this.boxes[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function onSelected(param1:Event) : void {
         var _loc2_:Selectable = param1.currentTarget as Selectable;
         this.group.setSelected(_loc2_.getValue());
      }
   }
}
