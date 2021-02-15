package io.decagames.rotmg.dailyQuests.view.info {
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
   import com.company.assembleegameclient.ui.tooltip.TextToolTip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.dailyQuests.model.DailyQuest;
   import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
   import io.decagames.rotmg.dailyQuests.signal.LockQuestScreenSignal;
   import io.decagames.rotmg.dailyQuests.signal.SelectedItemSlotsSignal;
   import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
   import io.decagames.rotmg.dailyQuests.view.popup.DailyQuestExpiredPopup;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.signals.HideTooltipsSignal;
   import kabam.rotmg.core.signals.ShowTooltipSignal;
   import kabam.rotmg.dailyLogin.model.DailyLoginModel;
   import kabam.rotmg.game.view.components.BackpackTabContent;
   import kabam.rotmg.game.view.components.InventoryTabContent;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.tooltips.HoverTooltipDelegate;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class DailyQuestInfoMediator extends Mediator {
       
      
      [Inject]
      public var showInfoSignal:ShowQuestInfoSignal;
      
      [Inject]
      public var view:DailyQuestInfo;
      
      [Inject]
      public var model:DailyQuestsModel;
      
      [Inject]
      public var hud:HUDModel;
      
      [Inject]
      public var lockScreen:LockQuestScreenSignal;
      
      [Inject]
      public var selectedItemSlotsSignal:SelectedItemSlotsSignal;
      
      [Inject]
      public var showTooltipSignal:ShowTooltipSignal;
      
      [Inject]
      public var hideTooltipsSignal:HideTooltipsSignal;
      
      [Inject]
      public var dailyLoginModel:DailyLoginModel;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      private var tooltip:TextToolTip;
      
      private var hoverTooltipDelegate:HoverTooltipDelegate;
      
      public function DailyQuestInfoMediator() {
         hoverTooltipDelegate = new HoverTooltipDelegate();
         super();
      }
      
      override public function initialize() : void {
         this.showInfoSignal.add(this.showQuestInfo);
         this.tooltip = new TextToolTip(3552822,10197915,"","You must select a reward first!",190,null);
         this.hoverTooltipDelegate.setHideToolTipsSignal(this.hideTooltipsSignal);
         this.hoverTooltipDelegate.setShowToolTipSignal(this.showTooltipSignal);
         this.hoverTooltipDelegate.tooltip = this.tooltip;
         this.view.completeButton.addEventListener("click",this.onCompleteButtonClickHandler);
         this.selectedItemSlotsSignal.add(this.itemSelectedHandler);
      }
      
      override public function destroy() : void {
         this.view.completeButton.removeEventListener("click",this.onCompleteButtonClickHandler);
         this.showInfoSignal.remove(this.showQuestInfo);
         this.selectedItemSlotsSignal.remove(this.itemSelectedHandler);
      }
      
      private function itemSelectedHandler(param1:int) : void {
         this.view.completeButton.disabled = !!this.model.currentQuest.completed?true:Boolean(this.model.selectedItem == -1?true:!DailyQuestInfo.hasAllItems(this.model.currentQuest.requirements,this.model.playerItemsFromInventory));
         if(this.model.selectedItem == -1) {
            this.hoverTooltipDelegate.setDisplayObject(this.view.completeButton);
         } else {
            this.hoverTooltipDelegate.removeDisplayObject();
         }
      }
      
      private function showQuestInfo(param1:String, param2:int, param3:String) : void {
         if(param1 != "" && param2 != -1) {
            this.setupQuestInfo(param1);
            if(this.view.hasEventListener("enterFrame")) {
               this.view.removeEventListener("enterFrame",this.updateQuestAvailable);
            }
         } else if(param3 == "Quests") {
            this.view.dailyQuestsCompleted();
            this.view.addEventListener("enterFrame",this.updateQuestAvailable);
         } else {
            this.view.eventQuestsCompleted();
         }
      }
      
      private function setupQuestInfo(param1:String) : void {
         this.model.selectedItem = -1;
         this.view.dailyQuestsCompleted();
         this.model.currentQuest = this.model.getQuestById(param1);
         this.view.show(this.model.currentQuest,this.model.playerItemsFromInventory);
         if(!this.view.completeButton.completed && this.model.currentQuest.itemOfChoice) {
            this.view.completeButton.disabled = true;
            this.hoverTooltipDelegate.setDisplayObject(this.view.completeButton);
         }
      }
      
      private function tileToSlot(param1:InventoryTile) : SlotObjectData {
         var _loc2_:SlotObjectData = new SlotObjectData();
         _loc2_.objectId_ = param1.ownerGrid.owner.objectId_;
         _loc2_.objectType_ = param1.getItemId();
         _loc2_.slotId_ = param1.tileId;
         return _loc2_;
      }
      
      private function completeQuest() : void {
         var _loc5_:int = 0;
         var _loc2_:* = undefined;
         var _loc7_:int = 0;
         var _loc6_:* = undefined;
         var _loc1_:* = undefined;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc11_:* = undefined;
         var _loc10_:* = undefined;
         var _loc3_:int = 0;
         var _loc9_:* = null;
         if(!this.view.completeButton.disabled && !this.view.completeButton.completed) {
            _loc1_ = new Vector.<SlotObjectData>();
            _loc4_ = this.hud.gameSprite.hudView.tabStrip.getTabView(BackpackTabContent);
            _loc8_ = this.hud.gameSprite.hudView.tabStrip.getTabView(InventoryTabContent);
            _loc11_ = this.model.currentQuest.requirements.concat();
            _loc10_ = new Vector.<InventoryTile>();
            if(_loc4_) {
               _loc10_ = _loc10_.concat(_loc4_.backpack.tiles);
            }
            if(_loc8_) {
               _loc10_ = _loc10_.concat(_loc8_.storage.tiles);
            }
            _loc5_ = 0;
            _loc2_ = _loc11_;
            var _loc15_:int = 0;
            var _loc14_:* = _loc11_;
            for each(_loc3_ in _loc11_) {
               _loc7_ = 0;
               _loc6_ = _loc10_;
               var _loc13_:int = 0;
               var _loc12_:* = _loc10_;
               for each(_loc9_ in _loc10_) {
                  if(_loc9_.getItemId() == _loc3_) {
                     _loc10_.splice(_loc10_.indexOf(_loc9_),1);
                     _loc1_.push(this.tileToSlot(_loc9_));
                     break;
                  }
               }
            }
            this.lockScreen.dispatch();
            this.hud.gameSprite.gsc_.questRedeem(this.model.currentQuest.id,_loc1_,this.model.selectedItem);
            if(!this.model.currentQuest.repeatable) {
               this.model.currentQuest.completed = true;
            }
            this.view.completeButton.completed = true;
            this.view.completeButton.disabled = true;
         }
      }
      
      private function checkIfQuestHasExpired() : Boolean {
         var _loc2_:* = false;
         var _loc1_:DailyQuest = this.model.currentQuest;
         var _loc3_:Date = new Date();
         if(_loc1_.expiration != "") {
            _loc2_ = parseFloat(_loc1_.expiration) - _loc3_.time / 1000 < 0;
         }
         return _loc2_;
      }
      
      private function updateQuestAvailable(param1:Event) : void {
         var _loc2_:String = "New quests available in " + this.dailyLoginModel.getFormatedQuestRefreshTime();
         this.view.setQuestAvailableTime(_loc2_);
      }
      
      private function onCompleteButtonClickHandler(param1:MouseEvent) : void {
         if(this.checkIfQuestHasExpired()) {
            this.showPopupSignal.dispatch(new DailyQuestExpiredPopup());
         } else {
            this.completeQuest();
         }
      }
   }
}
