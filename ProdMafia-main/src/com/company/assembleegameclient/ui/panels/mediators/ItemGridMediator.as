package com.company.assembleegameclient.ui.panels.mediators {
   import com.company.assembleegameclient.map.Map;
   import com.company.assembleegameclient.objects.Container;
   import com.company.assembleegameclient.objects.GameObject;
   import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.ObjectProperties;
import com.company.assembleegameclient.objects.OneWayContainer;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.panels.itemgrids.ContainerGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.InventoryGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTile;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.ItemTileEvent;
   import com.company.assembleegameclient.ui.tooltip.ToolTip;
   import com.company.assembleegameclient.util.DisplayHierarchy;
import com.company.assembleegameclient.util.TimeUtil;

import io.decagames.rotmg.pets.data.PetsModel;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.core.model.MapModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.game.model.PotionInventoryModel;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import kabam.rotmg.game.view.components.TabStripView;
   import kabam.rotmg.messaging.impl.GameServerConnection;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.model.TabStripModel;
import kabam.rotmg.ui.view.components.PotionSlotView;

import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class ItemGridMediator extends Mediator {
       
      
      [Inject]
      public var view:ItemGrid;
      
      [Inject]
      public var mapModel:MapModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var potionInventoryModel:PotionInventoryModel;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var tabStripModel:TabStripModel;
      
      [Inject]
      public var showToolTip:ShowTooltipSignal;
      
      [Inject]
      public var petsModel:PetsModel;
      
      [Inject]
      public var addTextLine:AddTextLineSignal;
      
      public function ItemGridMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.addEventListener("ITEM_MOVE",this.onTileMove);
         this.view.addEventListener("ITEM_SHIFT_CLICK",this.onShiftClick);
         this.view.addEventListener("ITEM_DOUBLE_CLICK",this.onDoubleClick);
         this.view.addEventListener("ITEM_CTRL_CLICK",this.onCtrlClick);
         this.view.addToolTip.add(this.onAddToolTip);
      }
      
      override public function destroy() : void {
         super.destroy();
      }
      
      private function onAddToolTip(param1:ToolTip) : void {
         this.showToolTip.dispatch(param1);
      }
      
      private function canSwapItems(param1:InteractiveItemTile, param2:InteractiveItemTile) : Boolean {
         if(!param1.canHoldItem(param2.getItemId())) {
            return false;
         }
         if(!param2.canHoldItem(param1.getItemId())) {
            return false;
         }
         if(ItemGrid(param2.parent).owner is OneWayContainer) {
            return false;
         }
         if(param1.blockingItemUpdates || param2.blockingItemUpdates) {
            return false;
         }
         return true;
      }
      
      private function dropItem(param1:InteractiveItemTile) : void {
         var _loc4_:* = null;
         var _loc8_:* = undefined;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Boolean = ObjectLibrary.isSoulbound(param1.itemSprite.itemId);
         var _loc5_:Boolean = ObjectLibrary.isDropTradable(param1.itemSprite.itemId);
         var _loc3_:Container = this.view.owner as Container;
         if(!_loc3_ && this.view.owner != this.view.curPlayer) {
            return;
         }
         if(this.view.owner == this.view.curPlayer || _loc3_ && _loc3_.ownerId_ == this.view.curPlayer.accountId_ && !_loc2_) {
            _loc4_ = this.mapModel.currentInteractiveTarget as Container;
            if(_loc4_ && !(!_loc4_.canHaveSoulbound_ && !_loc5_ || _loc4_.canHaveSoulbound_ && _loc4_.isLoot_ && _loc5_)) {
               _loc8_ = _loc4_.equipment_;
               _loc7_ = _loc8_.length;
               _loc6_ = 0;
               while(_loc6_ < _loc7_) {
                  if(_loc8_[_loc6_] >= 0) {
                     _loc6_++;
                     continue;
                  }
                  break;
               }
               if(_loc6_ < _loc7_) {
                  this.dropWithoutDestTile(param1,_loc4_,_loc6_);
               } else {
                  GameServerConnection.instance.invDrop(this.view.owner,param1.tileId,param1.getItemId());
               }
            } else {
               GameServerConnection.instance.invDrop(this.view.owner,param1.tileId,param1.getItemId());
            }
         } else if(_loc3_.canHaveSoulbound_ && _loc3_.isLoot_ && _loc5_) {
            GameServerConnection.instance.invDrop(this.view.owner,param1.tileId,param1.getItemId());
         }
         param1.setItem(-1);
      }
      
      private function swapItemTiles(param1:ItemTile, param2:ItemTile) : Boolean {
         if(!GameServerConnection.instance || !this.view.interactive || !param1 || !param2) {
            return false;
         }
         GameServerConnection.instance.invSwap(this.view.curPlayer,this.view.owner,param1.tileId,param1.itemSprite.itemId,param2.ownerGrid.owner,param2.tileId,param2.itemSprite.itemId);
         var _loc3_:int = param1.getItemId();
         param1.setItem(param2.getItemId());
         param2.setItem(_loc3_);
         param1.updateUseability(this.view.curPlayer);
         param2.updateUseability(this.view.curPlayer);
         return true;
      }
      
      private function dropWithoutDestTile(param1:ItemTile, param2:Container, param3:int) : void {
         if(!GameServerConnection.instance || !this.view.interactive || !param1 || !param2) {
            return;
         }
         GameServerConnection.instance.invSwap(this.view.curPlayer,this.view.owner,param1.tileId,param1.itemSprite.itemId,param2,param3,-1);
         param1.setItem(-1);
      }
      
      private function equipOrUseContainer(param1:InteractiveItemTile) : void {
         var _loc2_:GameObject = param1.ownerGrid.owner;
         var _loc4_:Player = this.view.curPlayer;
         var _loc3_:int = this.view.curPlayer.nextAvailableInventorySlot();
         if(_loc3_ != -1) {
            GameServerConnection.instance.invSwap(_loc4_,this.view.owner,param1.tileId,param1.itemSprite.itemId,this.view.curPlayer,_loc3_,-1);
         } else {
            GameServerConnection.instance.useItem_new(_loc2_,param1.tileId);
         }
         param1.setItem(-1);
      }
      
      private function equipOrUseInventory(param1:InteractiveItemTile) : void {
         var _loc2_:GameObject = param1.ownerGrid.owner;
         var _loc4_:Player = this.view.curPlayer;
         var _loc3_:int = ObjectLibrary.getMatchingSlotIndex(param1.getItemId(),_loc4_);
         if(_loc3_ != -1) {
            GameServerConnection.instance.invSwap(_loc4_,_loc2_,param1.tileId,param1.getItemId(),_loc4_,_loc3_,_loc4_.equipment_[_loc3_]);
         } else {
            GameServerConnection.instance.useItem_new(_loc2_,param1.tileId);
         }
         param1.setItem(-1);
      }
      
      private function onTileMove(param1:ItemTileEvent) : void {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var psv:PotionSlotView = null;
         var _loc6_:int = 0;
         var tile:InteractiveItemTile = param1.tile;
         var _loc4_:* = DisplayHierarchy.getParentWithTypeArray(tile.getDropTarget(),TabStripView,InteractiveItemTile,PotionSlotView,Map);
         if(_loc4_ is InteractiveItemTile) {
            _loc5_ = _loc4_ as InteractiveItemTile;
            if(_loc5_.tileId > this.view.curPlayer.lockedSlot.length - 1 || this.view.curPlayer.lockedSlot[_loc5_.tileId] == 0) {
               if(this.canSwapItems(tile,_loc5_)) {
                  this.swapItemTiles(tile,_loc5_);
               }
            } else {
               this.addTextLine.dispatch(ChatMessage.make("*Error*","You cannot put items into this slot right now."));
            }
         } else if(_loc4_ is TabStripView) {
            _loc3_ = _loc4_ as TabStripView;
            _loc6_ = tile.ownerGrid.curPlayer.nextAvailableInventorySlot();
            if(_loc6_ != -1) {
               GameServerConnection.instance.invSwap(this.view.curPlayer,tile.ownerGrid.owner,tile.tileId,tile.itemSprite.itemId,this.view.curPlayer,_loc6_,-1);
               tile.setItem(-1);
               tile.updateUseability(this.view.curPlayer);
            }
         } else if (_loc4_ is PotionSlotView) {
            psv = _loc4_ as PotionSlotView;
            if (psv) {
               var props:ObjectProperties = ObjectLibrary.propsLibrary_[tile.itemSprite.itemId];
               var hasOtherInstance:Boolean = false;
               switch (psv.position) {
                  case 0:
                     if (this.view.curPlayer.quickSlotItem2 == tile.itemSprite.itemId
                             || this.view.curPlayer.quickSlotItem3 == tile.itemSprite.itemId)
                        hasOtherInstance = true;
                     break;
                  case 1:
                     if (this.view.curPlayer.quickSlotItem1 == tile.itemSprite.itemId
                             || this.view.curPlayer.quickSlotItem3 == tile.itemSprite.itemId)
                        hasOtherInstance = true;
                     break;
                  case 2:
                     if (this.view.curPlayer.quickSlotItem1 == tile.itemSprite.itemId
                             || this.view.curPlayer.quickSlotItem2 == tile.itemSprite.itemId)
                        hasOtherInstance = true;
                     break;
               }
               var changingObjType:Boolean = psv.objectType != -1
                       && psv.objectType != tile.itemSprite.itemId;
               if (props.maxQuickStack == -1
                       || psv.itemCount >= props.maxQuickStack
                       || changingObjType && psv.itemCount > 1
                       || hasOtherInstance) {
                  tile.resetItemPosition();
                  return;
               }

               GameServerConnection.instance.invSwapRaw(
                       this.view.curPlayer.x_, this.view.curPlayer.y_,
                       tile.ownerGrid.owner.objectId_, tile.tileId, tile.itemSprite.itemId,
                       this.view.curPlayer.objectId_, 1000000 + psv.position, psv.objectType);

               psv.setData(changingObjType ? 1 : psv.itemCount + 1, props.maxQuickStack, tile.itemSprite.itemId);
               switch (psv.position) {
                  case 0:
                     this.view.curPlayer.quickSlotItem1 = tile.itemSprite.itemId;
                     this.view.curPlayer.quickSlotCount1 = psv.itemCount;
                     break;
                  case 1:
                     this.view.curPlayer.quickSlotItem2 = tile.itemSprite.itemId;
                     this.view.curPlayer.quickSlotCount2 = psv.itemCount;
                     break;
                  case 2:
                     this.view.curPlayer.quickSlotItem3 = tile.itemSprite.itemId;
                     this.view.curPlayer.quickSlotCount3 = psv.itemCount;
                     break;
               }

               tile.setItem(-1);
               tile.updateUseability(this.view.curPlayer);
            }
         } else if (_loc4_ is Map || this.hudModel.gameSprite.map.mouseX < 600) {
            this.dropItem(tile);
         }
         tile.resetItemPosition();
      }

      private function onShiftClick(param1:ItemTileEvent) : void {
         var _loc2_:InteractiveItemTile = param1.tile;
         if(_loc2_.ownerGrid is InventoryGrid || _loc2_.ownerGrid is ContainerGrid) {
            GameServerConnection.instance.useItem_new(_loc2_.ownerGrid.owner,_loc2_.tileId);
         }
      }
      
      private function onCtrlClick(param1:ItemTileEvent) : void {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(Parameters.data.inventorySwap) {
            _loc2_ = param1.tile;
            if(_loc2_.ownerGrid is InventoryGrid) {
               _loc3_ = _loc2_.ownerGrid.curPlayer.swapInventoryIndex(this.tabStripModel.currentSelection);
               if(_loc3_ != -1) {
                  GameServerConnection.instance.invSwap(this.view.curPlayer,_loc2_.ownerGrid.owner,_loc2_.tileId,_loc2_.itemSprite.itemId,this.view.curPlayer,_loc3_,-1);
                  _loc2_.setItem(-1);
                  _loc2_.updateUseability(this.view.curPlayer);
               }
            }
         }
      }
      
      private function onDoubleClick(param1:ItemTileEvent) : void {
         var _loc2_:InteractiveItemTile = param1.tile;
         if(_loc2_.ownerGrid is ContainerGrid) {
            this.equipOrUseContainer(_loc2_);
         } else {
            this.equipOrUseInventory(_loc2_);
         }
         this.view.refreshTooltip();
      }
   }
}
