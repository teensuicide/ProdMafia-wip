package com.company.assembleegameclient.ui.dropdown {
   import com.company.ui.BaseSimpleText;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class DropDown extends Sprite {
       
      
      protected var strings_:Vector.<String>;
      
      protected var w_:int;
      
      protected var h_:int;
      
      protected var maxItems_:int;
      
      protected var labelText_:BaseSimpleText;
      
      protected var xOffset_:int = 0;
      
      protected var selected_:DropDownItem;
      
      protected var all_:Sprite;
      
      public function DropDown(param1:Vector.<String>, param2:int, param3:int, param4:String = null, param5:Number = 0, param6:int = 17) {
         all_ = new Sprite();
         super();
         this.strings_ = param1;
         this.w_ = param2;
         this.h_ = param3;
         this.maxItems_ = param6;
         if(param4 != null) {
            this.labelText_ = new BaseSimpleText(14,16777215,false,0,0);
            this.labelText_.setBold(true);
            this.labelText_.text = param4 + ":";
            this.labelText_.updateMetrics();
            addChild(this.labelText_);
            this.xOffset_ = this.labelText_.width + 5;
         }
         this.setIndex(param5);
      }
      
      public function getValue() : String {
         return this.selected_.getValue();
      }
      
      public function setListItems(param1:Vector.<String>) : void {
         this.strings_ = param1;
      }
      
      public function setValue(param1:String) : Boolean {
         var _loc2_:int = 0;
         while(_loc2_ < this.strings_.length) {
            if(param1 == this.strings_[_loc2_]) {
               this.setIndex(_loc2_);
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function setIndex(param1:int) : void {
         if(param1 >= this.strings_.length) {
            param1 = 0;
         }
         this.setSelected(this.strings_[param1]);
      }
      
      public function getIndex() : int {
         var _loc1_:int = 0;
         while(_loc1_ < this.strings_.length) {
            if(this.selected_.getValue() == this.strings_[_loc1_]) {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function setSelected(param1:String) : void {
         var _loc2_:String = this.selected_ != null?this.selected_.getValue():null;
         this.selected_ = new DropDownItem(param1,this.w_,this.h_);
         this.selected_.x = this.xOffset_;
         this.selected_.y = 0;
         addChild(this.selected_);
         this.selected_.addEventListener("click",this.onClick);
         if(param1 != _loc2_) {
            dispatchEvent(new Event("change"));
         }
      }
      
      private function showAll() : void {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Point = parent.localToGlobal(new Point(x,y));
         this.all_.x = _loc4_.x;
         this.all_.y = _loc4_.y;
         var _loc1_:int = Math.ceil(this.strings_.length / this.maxItems_);
         while(_loc6_ < _loc1_) {
            _loc3_ = _loc6_ * this.maxItems_;
            _loc5_ = Math.min(_loc3_ + this.maxItems_,this.strings_.length);
            _loc2_ = this.xOffset_ - this.w_ * _loc6_;
            this.listItems(_loc3_,_loc5_,_loc2_);
            _loc6_++;
         }
         this.all_.addEventListener("rollOut",this.onOut);
         stage.addChild(this.all_);
      }
      
      private function listItems(param1:int, param2:int, param3:int) : void {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         _loc6_ = 0;
         var _loc4_:* = param1;
         while(_loc4_ < param2) {
            _loc5_ = new DropDownItem(this.strings_[_loc4_],this.w_,this.h_);
            _loc5_.addEventListener("click",this.onSelect);
            _loc5_.x = param3;
            _loc5_.y = _loc6_;
            this.all_.addChild(_loc5_);
            _loc6_ = _loc6_ + _loc5_.h_;
            _loc4_++;
         }
      }
      
      private function hideAll() : void {
         this.all_.removeEventListener("rollOut",this.onOut);
         stage.removeChild(this.all_);
      }
      
      private function onClick(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         this.selected_.removeEventListener("click",this.onClick);
         if(contains(this.selected_)) {
            removeChild(this.selected_);
         }
         this.showAll();
      }
      
      private function onSelect(param1:MouseEvent) : void {
         param1.stopImmediatePropagation();
         this.hideAll();
         var _loc2_:DropDownItem = param1.target as DropDownItem;
         this.setSelected(_loc2_.getValue());
      }
      
      private function onOut(param1:MouseEvent) : void {
         this.hideAll();
         this.setSelected(this.selected_.getValue());
      }
   }
}
