package com.company.assembleegameclient.account.ui {
   import com.company.assembleegameclient.account.ui.components.Selectable;
   import com.company.assembleegameclient.account.ui.components.SelectionGroup;
   import com.company.assembleegameclient.util.offer.Offer;
   import com.company.assembleegameclient.util.offer.Offers;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import kabam.lib.ui.api.Layout;
   import kabam.lib.ui.impl.VerticalLayout;
   import kabam.rotmg.account.core.model.MoneyConfig;
   
   public class OfferRadioButtons extends Sprite {
       
      
      private var offers:Offers;
      
      private var config:MoneyConfig;
      
      private var choices:Vector.<OfferRadioButton>;
      
      private var group:SelectionGroup;
      
      public function OfferRadioButtons(param1:Offers, param2:MoneyConfig) {
         super();
         this.offers = param1;
         this.config = param2;
         this.makeGoldChoices();
         this.alignGoldChoices();
         this.makeSelectionGroup();
      }
      
      public function getChoice() : OfferRadioButton {
         return this.group.getSelected() as OfferRadioButton;
      }
      
      public function showBonuses(param1:Boolean) : void {
         var _loc2_:int = this.choices.length;
         while(true) {
            _loc2_--;
            if(_loc2_) {
               this.choices[_loc2_].showBonus(param1);
               continue;
            }
            break;
         }
      }
      
      private function makeGoldChoices() : void {
         var _loc1_:int = 0;
         var _loc2_:int = this.offers.offerList.length;
         this.choices = new Vector.<OfferRadioButton>(_loc2_,true);
         while(_loc1_ < _loc2_) {
            this.choices[_loc1_] = this.makeGoldChoice(this.offers.offerList[_loc1_]);
            _loc1_++;
         }
      }
      
      private function makeGoldChoice(param1:Offer) : OfferRadioButton {
         var _loc2_:OfferRadioButton = new OfferRadioButton(param1,this.config);
         _loc2_.addEventListener("click",this.onSelected);
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function alignGoldChoices() : void {
         var _loc2_:Vector.<DisplayObject> = this.castChoicesToDisplayList();
         var _loc1_:Layout = new VerticalLayout();
         _loc1_.setPadding(5);
         _loc1_.layout(_loc2_);
      }
      
      private function castChoicesToDisplayList() : Vector.<DisplayObject> {
         var _loc3_:int = 0;
         var _loc2_:int = this.choices.length;
         var _loc1_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         while(_loc3_ < _loc2_) {
            _loc1_[_loc3_] = this.choices[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function makeSelectionGroup() : void {
         var _loc1_:Vector.<Selectable> = this.castBoxesToSelectables();
         this.group = new SelectionGroup(_loc1_);
         this.group.setSelected(this.choices[0].getValue());
      }
      
      private function castBoxesToSelectables() : Vector.<Selectable> {
         var _loc3_:int = 0;
         var _loc2_:int = this.choices.length;
         var _loc1_:Vector.<Selectable> = new Vector.<Selectable>(0);
         while(_loc3_ < _loc2_) {
            _loc1_[_loc3_] = this.choices[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function onSelected(param1:MouseEvent) : void {
         var _loc2_:Selectable = param1.currentTarget as Selectable;
         this.group.setSelected(_loc2_.getValue());
      }
   }
}
