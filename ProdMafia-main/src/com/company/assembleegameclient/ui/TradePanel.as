package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import kabam.rotmg.messaging.impl.incoming.TradeStart;
   
   public class TradePanel extends Sprite {
      
      public static const WIDTH:int = 200;
      
      public static const HEIGHT:int = 400;
       
      
      public var gs_:AGameSprite;
      
      private var myInv_:TradeInventory;
      
      private var yourInv_:TradeInventory;
      
      private var cancelButton_:DeprecatedTextButton;
      
      private var tradeButton_:TradeButton;
      
      public function TradePanel(param1:AGameSprite, param2:TradeStart) {
         super();
         this.gs_ = param1;
         var _loc3_:String = this.gs_.map.player_.name_;
         this.myInv_ = new TradeInventory(param1,_loc3_,param2.myItems_,true);
         this.myInv_.x = 14;
         this.myInv_.y = 0;
         this.myInv_.addEventListener("change",this.onMyInvChange,false,0,true);
         addChild(this.myInv_);
         this.yourInv_ = new TradeInventory(param1,param2.yourName_,param2.yourItems_,false);
         this.yourInv_.x = 14;
         this.yourInv_.y = 174;
         addChild(this.yourInv_);
         this.cancelButton_ = new DeprecatedTextButton(16,"Frame.cancel",80);
         this.cancelButton_.addEventListener("click",this.onCancelClick,false,0,true);
         this.cancelButton_.textChanged.addOnce(this.onCancelTextChanged);
         addChild(this.cancelButton_);
         this.tradeButton_ = new TradeButton(16,80);
         this.tradeButton_.x = 150 - this.tradeButton_.bWidth / 2;
         this.tradeButton_.addEventListener("click",this.onTradeClick,false,0,true);
         this.tradeButton_.addEventListener("rightClick",this.onTradeRightClick,false,0,true);
         addChild(this.tradeButton_);
         this.checkTrade();
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      }
      
      public function setYourOffer(param1:Vector.<Boolean>) : void {
         this.yourInv_.setOffer(param1);
         this.checkTrade();
      }
      
      public function youAccepted(param1:Vector.<Boolean>, param2:Vector.<Boolean>) : void {
         if(this.myInv_.isOffer(param1) && this.yourInv_.isOffer(param2)) {
            this.yourInv_.setMessage(2);
         }
      }
      
      public function checkTrade() : void {
         var _loc5_:int = this.myInv_.numIncluded();
         var _loc1_:int = this.myInv_.numEmpty();
         var _loc3_:int = this.yourInv_.numIncluded();
         var _loc4_:int = this.yourInv_.numEmpty();
         var _loc2_:Boolean = true;
         if(_loc3_ - _loc5_ - _loc1_ > 0) {
            this.myInv_.setMessage(1);
            _loc2_ = false;
         } else {
            this.myInv_.setMessage(0);
         }
         if(_loc5_ - _loc3_ - _loc4_ > 0) {
            this.yourInv_.setMessage(1);
            _loc2_ = false;
         } else {
            this.yourInv_.setMessage(3);
         }
         if(_loc2_) {
            this.tradeButton_.reset();
         } else {
            this.tradeButton_.disable();
         }
      }
      
      private function onCancelTextChanged() : void {
         this.cancelButton_.x = 50 - this.cancelButton_.bWidth / 2;
         this.cancelButton_.y = 400 - this.cancelButton_.height - 10;
         this.tradeButton_.y = this.cancelButton_.y;
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("activate",this.onActivate,false,0,true);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("addedToStage",this.onAddedToStage);
         removeEventListener("removedFromStage",this.onRemovedFromStage);
         this.myInv_.removeEventListener("change",this.onMyInvChange);
         this.cancelButton_.removeEventListener("click",this.onCancelClick);
         this.cancelButton_.textChanged.removeAll();
         this.tradeButton_.removeEventListener("click",this.onTradeClick);
         this.tradeButton_.removeEventListener("rightClick",this.onTradeRightClick);
         stage.removeEventListener("activate",this.onActivate);
      }
      
      private function onActivate(param1:Event) : void {
         this.tradeButton_.reset();
      }
      
      private function onMyInvChange(param1:Event) : void {
         this.gs_.gsc_.changeTrade(this.myInv_.getOffer());
         this.checkTrade();
      }
      
      private function onCancelClick(param1:MouseEvent) : void {
         this.gs_.gsc_.cancelTrade();
         dispatchEvent(new Event("cancel"));
      }
      
      private function onTradeClick(param1:MouseEvent) : void {
         this.gs_.gsc_.acceptTrade(this.myInv_.getOffer(),this.yourInv_.getOffer());
         this.myInv_.setMessage(2);
      }
      
      private function onTradeRightClick(param1:MouseEvent) : void {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         if(Parameters.data.rightClickSelectAll) {
            _loc3_ = new Vector.<Boolean>(12);
            _loc3_[0] = false;
            _loc3_[1] = false;
            _loc3_[2] = false;
            _loc3_[3] = false;
            _loc2_ = 4;
            while(_loc2_ < 12) {
               _loc3_[_loc2_] = this.gs_.map.player_.equipment_[_loc2_] != -1 && this.myInv_.slots_[_loc2_].included_;
               _loc2_++;
            }
            this.myInv_.setOffer(_loc3_);
            onMyInvChange(null);
         }
      }
   }
}
