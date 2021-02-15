package kabam.rotmg.ui.view.components {
   import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.objects.ObjectLibrary;
import com.company.assembleegameclient.objects.ObjectProperties;
import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InteractiveItemTile;
   import com.company.assembleegameclient.util.DisplayHierarchy;
   import flash.display.DisplayObject;
   import kabam.rotmg.game.model.PotionInventoryModel;
   import kabam.rotmg.game.model.UseBuyPotionVO;
   import kabam.rotmg.game.signals.UseBuyPotionSignal;
   import kabam.rotmg.messaging.impl.GameServerConnection;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.model.PotionModel;
   import kabam.rotmg.ui.signals.UpdateHUDSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class PotionSlotMediator extends Mediator {
       
      
      [Inject]
      public var view:PotionSlotView;
      
      [Inject]
      public var hudModel:HUDModel;
      
      [Inject]
      public var updateHUD:UpdateHUDSignal;
      
      [Inject]
      public var potionInventoryModel:PotionInventoryModel;
      
      [Inject]1.3.2.1.0
      public var useBuyPotionSignal:UseBuyPotionSignal;
      
      private var blockingUpdate:Boolean = false;
      
      private var prevCount:int = 0;
      
      public function PotionSlotMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.updateHUD.addOnce(this.initializeData);
         this.view.drop.add(this.onDrop);
         this.view.buyUse.add(this.onBuyUse);
         this.updateHUD.add(this.update);
      }
      
      override public function destroy() : void {
         this.view.drop.remove(this.onDrop);
         this.view.buyUse.remove(this.onBuyUse);
         this.updateHUD.remove(this.update);
      }
      
      private function initializeData(player:Player) : void {
         var itemId:int = -1;
         var itemCount:int = 0;
         switch (this.view.position) {
            case 0:
               itemId = player.quickSlotItem1;
               itemCount = player.quickSlotCount1;
               break;
            case 1:
               itemId = player.quickSlotItem2;
               itemCount = player.quickSlotCount2;
               break;
            case 2:
               itemId = player.quickSlotItem3;
               itemCount = player.quickSlotCount3;
               break;
         }

         if (itemId != -1) {
            var props:ObjectProperties = ObjectLibrary.propsLibrary_[itemId];
            this.view.setData(itemCount, props.maxQuickStack, itemId);
         } else
            this.view.setData(0, 0, -1);
      }
      
      private function update(player:Player) : void {
         var itemId:int = -1;
         var itemCount:int = 0;
         switch (this.view.position) {
            case 0:
               itemId = player.quickSlotItem1;
               itemCount = player.quickSlotCount1;
               break;
            case 1:
               itemId = player.quickSlotItem2;
               itemCount = player.quickSlotCount2;
               break;
            case 2:
               itemId = player.quickSlotItem3;
               itemCount = player.quickSlotCount3;
               break;
         }

         if (itemCount != this.prevCount) {
            if (itemCount == 0)
               this.view.setData(0, 0, -1);
            else {
               var props:ObjectProperties = ObjectLibrary.propsLibrary_[itemId];
               this.view.setData(itemCount, props.maxQuickStack, itemId);
            }
            this.prevCount = itemCount;
         }
      }
      
      private function onDrop(param1:DisplayObject) : void {
         var tile:InteractiveItemTile = null;
         var player:Player = this.hudModel.gameSprite.map.player_;
         var dropTarget:DisplayObject = DisplayHierarchy.getParentWithTypeArray(param1,InteractiveItemTile,Map);
         var slotId:int = 1000000 + this.view.position;
         var update:Boolean = false;
         if (dropTarget is Map || dropTarget == null) {
            GameServerConnection.instance.invDrop(player, slotId, this.view.objectType);
            update = true;
         } else if (dropTarget is InteractiveItemTile) {
            tile = dropTarget as InteractiveItemTile;
            if (tile.getItemId() == -1) {
               GameServerConnection.instance.invSwapRaw(player.x_, player.y_,
                       player.objectId_, slotId, this.view.objectType,
                       tile.ownerGrid.owner.objectId_, tile.tileId, -1);

               tile.setItem(this.view.objectType);
               tile.updateUseability(player);

               update = true;
            }
         }

         if (update) {
            var newCount:int = this.view.itemCount - 1;
            if (newCount <= 0) {
               this.view.setData(0, 0, -1);
               switch (this.view.position) {
                  case 0:
                     player.quickSlotItem1 = -1;
                     player.quickSlotCount1 = 0;
                     break;
                  case 1:
                     player.quickSlotItem2 = -1;
                     player.quickSlotCount2 = 0;
                     break;
                  case 2:
                     player.quickSlotItem3 = -1;
                     player.quickSlotCount3 = 0;
                     break;
               }
            } else {
               this.view.setData(newCount, this.view.maxCount, this.view.objectType);
               switch (this.view.position) {
                  case 0:
                     player.quickSlotItem1 = this.view.objectType;
                     player.quickSlotCount1 = newCount;
                     break;
                  case 1:
                     player.quickSlotItem2 = this.view.objectType;
                     player.quickSlotCount2 = newCount;
                     break;
                  case 2:
                     player.quickSlotItem3 = this.view.objectType;
                     player.quickSlotCount3 = newCount;
                     break;
               }
            }
         }
      }
      
      private function onBuyUse() : void {
         var _loc1_:* = null;
         var _loc2_:PotionModel = this.potionInventoryModel.potionModels[this.view.position];
         if(_loc2_.available) {
            _loc1_ = new UseBuyPotionVO(_loc2_.objectId,1000000 + this.view.position);
            this.useBuyPotionSignal.dispatch(_loc1_);
         }
      }
   }
}
