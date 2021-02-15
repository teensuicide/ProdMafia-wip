package com.company.assembleegameclient.ui.tooltip {
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.GameObjectListItem;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class PlayerGroupToolTip extends ToolTip {
       
      
      public var players_:Vector.<Player> = null;
      
      private var playerPanels_:Vector.<GameObjectListItem>;
      
      private var clickMessage_:TextFieldDisplayConcrete;
      
      public function PlayerGroupToolTip(param1:Vector.<Player>, param2:Boolean = true) {
         playerPanels_ = new Vector.<GameObjectListItem>();
         super(3552822,0.5,16777215,1,param2);
         this.clickMessage_ = new TextFieldDisplayConcrete().setSize(12).setColor(11776947);
         this.clickMessage_.setStringBuilder(new LineBuilder().setParams("PlayerToolTip.clickMessage"));
         this.clickMessage_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.clickMessage_);
         this.setPlayers(param1);
         if(!param2) {
            filters = [];
         }
         waiter.push(this.clickMessage_.textChanged);
      }
      
      public function setPlayers(param1:Vector.<Player>) : void {
         var _loc2_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         this.clear();
         this.players_ = param1.slice();
         if(this.players_ == null || this.players_.length == 0) {
            return;
         }
         var _loc6_:* = param1;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc5_ in param1) {
            _loc3_ = new GameObjectListItem(11776947,true,_loc5_);
            _loc3_.x = 0;
            _loc3_.y = _loc2_;
            addChild(_loc3_);
            this.playerPanels_.push(_loc3_);
            _loc3_.textReady.addOnce(this.onTextChanged);
            _loc2_ = _loc2_ + 32;
         }
         this.clickMessage_.x = width / 2 - this.clickMessage_.width / 2;
         this.clickMessage_.y = _loc2_;
         draw();
      }
      
      private function onTextChanged() : void {
         var _loc3_:* = null;
         this.clickMessage_.x = width / 2 - this.clickMessage_.width / 2;
         draw();
         var _loc1_:* = this.playerPanels_;
         var _loc5_:int = 0;
         var _loc4_:* = this.playerPanels_;
         for each(_loc3_ in this.playerPanels_) {
            _loc3_.textReady.remove(this.onTextChanged);
         }
      }
      
      private function clear() : void {
         var _loc3_:* = null;
         graphics.clear();
         var _loc1_:* = this.playerPanels_;
         var _loc5_:int = 0;
         var _loc4_:* = this.playerPanels_;
         for each(_loc3_ in this.playerPanels_) {
            removeChild(_loc3_);
         }
         this.playerPanels_.length = 0;
      }
   }
}
