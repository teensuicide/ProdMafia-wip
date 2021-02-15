package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.ui.BaseSimpleText;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.messaging.impl.data.TradeItem;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class TradeInventory extends Sprite {
      
      private static const NO_CUT:Array = [0,0,0,0];
      
      private static const cuts:Array = [[1,0,0,1],NO_CUT,NO_CUT,[0,1,1,0],[1,0,0,0],NO_CUT,NO_CUT,[0,1,0,0],[0,0,0,1],NO_CUT,NO_CUT,[0,0,1,0]];
      
      public static const CLICKITEMS_MESSAGE:int = 0;
      
      public static const NOTENOUGHSPACE_MESSAGE:int = 1;
      
      public static const TRADEACCEPTED_MESSAGE:int = 2;
      
      public static const TRADEWAITING_MESSAGE:int = 3;
       
      
      public var gs_:AGameSprite;
      
      public var playerName_:String;
      
      public var slots_:Vector.<TradeSlot>;
      
      private var message_:int;
      
      private var nameText_:BaseSimpleText;
      
      private var taglineText_:TextFieldDisplayConcrete;
      
      public function TradeInventory(param1:AGameSprite, param2:String, param3:Vector.<TradeItem>, param4:Boolean) {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc6_:int = 0;
         slots_ = new Vector.<TradeSlot>();
         super();
         this.gs_ = param1;
         this.playerName_ = param2;
         this.nameText_ = new BaseSimpleText(20,11776947,false,0,0);
         this.nameText_.setBold(true);
         this.nameText_.x = 0;
         this.nameText_.y = 0;
         this.nameText_.text = !!this.playerName_?this.playerName_:"";
         this.nameText_.updateMetrics();
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText_);
         this.taglineText_ = new TextFieldDisplayConcrete().setSize(12).setColor(11776947);
         this.taglineText_.x = 0;
         this.taglineText_.y = 22;
         this.taglineText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.taglineText_);
         while(_loc6_ < param3.length) {
            _loc5_ = param3[_loc6_];
            _loc7_ = new TradeSlot(_loc5_.item_,_loc5_.tradeable_,_loc5_.included_,_loc5_.slotType_,_loc6_ - 3,cuts[_loc6_ % 8],_loc6_);
            _loc7_.setPlayer(this.gs_.map.player_);
            _loc7_.x = _loc6_ % 8 * 22;
            _loc7_.y = int(_loc6_ / 4) == 0 ? int(_loc6_ / 4) * 22 + 46 : int((_loc6_ - 4) / 8) * 22 + 46 + 46;
            if(param4 && _loc5_.tradeable_) {
               _loc7_.addEventListener("mouseDown",this.onSlotClick,false,0,true);
            }
            this.slots_.push(_loc7_);
            addChild(_loc7_);
            _loc6_++;
         }
      }
      
      public function getOffer() : Vector.<Boolean> {
         var _loc1_:int = 0;
         var _loc2_:Vector.<Boolean> = new Vector.<Boolean>();
         while(_loc1_ < this.slots_.length) {
            _loc2_.push(this.slots_[_loc1_].included_);
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function setOffer(param1:Vector.<Boolean>) : void {
         var _loc2_:int = 0;
         while(_loc2_ < this.slots_.length) {
            this.slots_[_loc2_].setIncluded(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function isOffer(param1:Vector.<Boolean>) : Boolean {
         var _loc2_:int = 0;
         while(_loc2_ < this.slots_.length) {
            if(param1[_loc2_] != this.slots_[_loc2_].included_) {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function numIncluded() : int {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < this.slots_.length) {
            if(this.slots_[_loc1_].included_) {
               _loc2_++;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function numEmpty() : int {
         var _loc2_:int = 0;
         var _loc1_:int = 4;
         while(_loc1_ < this.slots_.length) {
            if(this.slots_[_loc1_].isEmpty()) {
               _loc2_++;
            }
            _loc1_++;
         }
         return _loc2_;
      }
      
      public function setMessage(param1:int) : void {
         var _loc2_:String = "";
         switch(int(param1)) {
            case 0:
               this.nameText_.setColor(11776947);
               this.taglineText_.setColor(11776947);
               _loc2_ = "TradeInventory.clickItemsToTrade";
               break;
            case 1:
               this.nameText_.setColor(16711680);
               this.taglineText_.setColor(16711680);
               _loc2_ = "TradeInventory.notEnoughSpace";
               break;
            case 2:
               this.nameText_.setColor(9022300);
               this.taglineText_.setColor(9022300);
               _loc2_ = "TradeInventory.tradeAccepted";
               break;
            case 3:
               this.nameText_.setColor(11776947);
               this.taglineText_.setColor(11776947);
               _loc2_ = "TradeInventory.playerIsSelectingItems";
         }
         this.taglineText_.setStringBuilder(new LineBuilder().setParams(_loc2_));
      }
      
      private function onSlotClick(param1:MouseEvent) : void {
         var _loc2_:TradeSlot = param1.currentTarget as TradeSlot;
         _loc2_.setIncluded(!_loc2_.included_);
         dispatchEvent(new Event("change"));
      }
   }
}
