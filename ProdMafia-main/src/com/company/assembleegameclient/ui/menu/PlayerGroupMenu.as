package com.company.assembleegameclient.ui.menu {
   import com.company.assembleegameclient.map.AbstractMap;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.GameObjectListItem;
   import com.company.assembleegameclient.ui.LineBreakDesign;
   import flash.events.Event;
   import org.osflash.signals.Signal;
   
   public class PlayerGroupMenu extends Menu {
       
      
      public var map_:AbstractMap;
      
      public var players_:Vector.<Player>;
      
      public var teleportOption_:MenuOption;
      
      public var lineBreakDesign_:LineBreakDesign;
      
      public var unableToTeleport:Signal;
      
      private var playerPanels_:Vector.<GameObjectListItem>;
      
      private var posY:uint = 4;
      
      public function PlayerGroupMenu(param1:AbstractMap, param2:Vector.<Player>) {
         unableToTeleport = new Signal();
         playerPanels_ = new Vector.<GameObjectListItem>();
         super(3552822,16777215);
         this.map_ = param1;
         this.players_ = param2.concat();
         this.createHeader();
         this.createPlayerList();
      }
      
      private function createPlayerList() : void {
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc2_:* = this.players_;
         var _loc6_:int = 0;
         var _loc5_:* = this.players_;
         for each(_loc3_ in this.players_) {
            _loc1_ = new GameObjectListItem(11776947,true,_loc3_);
            _loc1_.x = 0;
            _loc1_.y = this.posY;
            addChild(_loc1_);
            this.playerPanels_.push(_loc1_);
            _loc1_.textReady.addOnce(this.onTextChanged);
            this.posY = this.posY + 32;
         }
      }
      
      private function onTextChanged() : void {
         var _loc3_:* = null;
         draw();
         var _loc1_:* = this.playerPanels_;
         var _loc5_:int = 0;
         var _loc4_:* = this.playerPanels_;
         for each(_loc3_ in this.playerPanels_) {
            _loc3_.textReady.remove(this.onTextChanged);
         }
      }
      
      private function createHeader() : void {
         if(this.map_.allowPlayerTeleport()) {
            this.teleportOption_ = new TeleportMenuOption(this.map_.player_);
            this.teleportOption_.x = 8;
            this.teleportOption_.y = 8;
            this.teleportOption_.addEventListener("click",this.onTeleport,false,0,true);
            addChild(this.teleportOption_);
            this.lineBreakDesign_ = new LineBreakDesign(150,1842204);
            this.lineBreakDesign_.x = 6;
            this.lineBreakDesign_.y = 40;
            addChild(this.lineBreakDesign_);
            this.posY = 52;
         }
      }
      
      private function onTeleport(param1:Event) : void {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:Player = this.map_.player_;
         var _loc6_:* = this.players_;
         var _loc8_:int = 0;
         var _loc7_:* = this.players_;
         for each(_loc3_ in this.players_) {
            if(_loc2_.isTeleportEligible(_loc3_)) {
               _loc5_ = _loc3_;
               if(_loc2_.msUtilTeleport() > 10000) {
                  if(_loc3_.isFellowGuild_) {
                     break;
                  }
                  continue;
               }
               break;
            }
         }
         if(_loc5_ != null) {
            _loc2_.teleportTo(_loc5_);
         } else {
            this.unableToTeleport.dispatch();
         }
         remove();
      }
   }
}
