package io.decagames.rotmg.pets.windows.yard.feed {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.panels.itemgrids.itemtiles.InventoryTile;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   import io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO;
   import io.decagames.rotmg.pets.signals.SelectFeedItemSignal;
   import io.decagames.rotmg.pets.signals.SelectPetSignal;
   import io.decagames.rotmg.pets.signals.SimulateFeedSignal;
   import io.decagames.rotmg.pets.signals.UpgradePetSignal;
   import io.decagames.rotmg.pets.utils.FeedFuseCostModel;
   import io.decagames.rotmg.pets.windows.yard.feed.items.FeedItem;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.shop.NotEnoughResources;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
   import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.model.GameModel;
   import kabam.rotmg.game.view.components.InventoryTabContent;
   import kabam.rotmg.messaging.impl.data.SlotObjectData;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class FeedTabMediator extends Mediator {
       
      
      [Inject]
      public var view:FeedTab;
      
      [Inject]
      public var hud:HUDModel;
      
      [Inject]
      public var model:PetsModel;
      
      [Inject]
      public var selectFeedItemSignal:SelectFeedItemSignal;
      
      [Inject]
      public var selectPetSignal:SelectPetSignal;
      
      [Inject]
      public var gameModel:GameModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var showPopup:ShowPopupSignal;
      
      [Inject]
      public var upgradePet:UpgradePetSignal;
      
      [Inject]
      public var showFade:ShowLockFade;
      
      [Inject]
      public var removeFade:RemoveLockFade;
      
      [Inject]
      public var simulateFeed:SimulateFeedSignal;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var currentPet:PetVO;
      
      private var items:Vector.<FeedItem>;
      
      public function FeedTabMediator() {
         super();
      }
      
      private function get currentGold() : int {
         var _loc1_:Player = this.gameModel.player;
         if(_loc1_ != null) {
            return _loc1_.credits_;
         }
         if(this.playerModel != null) {
            return this.playerModel.getCredits();
         }
         return 0;
      }
      
      private function get currentFame() : int {
         var _loc1_:Player = this.gameModel.player;
         if(_loc1_ != null) {
            return _loc1_.fame_;
         }
         if(this.playerModel != null) {
            return this.playerModel.getFame();
         }
         return 0;
      }
      
      override public function initialize() : void {
         this.currentPet = !this.model.activeUIVO?this.model.getActivePet():this.model.activeUIVO;
         this.selectPetSignal.add(this.onPetSelected);
         this.items = new Vector.<FeedItem>();
         this.selectFeedItemSignal.add(this.refreshFeedPower);
         this.view.feedGoldButton.clickSignal.add(this.purchaseGold);
         this.view.feedFameButton.clickSignal.add(this.purchaseFame);
         this.view.displaySignal.add(this.showHideSignal);
         this.renderItems();
         this.refreshFeedPower();
      }
      
      override public function destroy() : void {
         this.items = new Vector.<FeedItem>();
         this.selectFeedItemSignal.remove(this.refreshFeedPower);
         this.selectPetSignal.remove(this.onPetSelected);
         this.view.feedGoldButton.clickSignal.remove(this.purchaseGold);
         this.view.feedFameButton.clickSignal.remove(this.purchaseFame);
         this.view.displaySignal.remove(this.showHideSignal);
      }
      
      private function showHideSignal(param1:Boolean) : void {
         var _loc4_:int = 0;
         var _loc3_:* = undefined;
         var _loc2_:* = null;
         if(!param1) {
            _loc4_ = 0;
            _loc3_ = this.items;
            var _loc6_:int = 0;
            var _loc5_:* = this.items;
            for each(_loc2_ in this.items) {
               _loc2_.selected = false;
            }
            this.refreshFeedPower();
         }
      }
      
      private function renderItems() : void {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc2_:* = null;
         this.view.clearGrid();
         this.items = new Vector.<FeedItem>();
         var _loc7_:InventoryTabContent = this.hud.gameSprite.hudView.tabStrip.getTabView(InventoryTabContent);
         var _loc1_:Vector.<InventoryTile> = new Vector.<InventoryTile>();
         if(_loc7_) {
            _loc1_ = _loc1_.concat(_loc7_.storage.tiles);
         }
         var _loc4_:* = _loc1_;
         var _loc9_:int = 0;
         var _loc8_:* = _loc1_;
         for each(_loc3_ in _loc1_) {
            _loc6_ = _loc3_.getItemId();
            if(_loc6_ != -1 && this.hasFeedPower(_loc6_)) {
               _loc2_ = new FeedItem(_loc3_);
               this.items.push(_loc2_);
               this.view.addItem(_loc2_);
            }
         }
      }
      
      private function refreshFeedPower() : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:* = this.items;
         var _loc7_:int = 0;
         var _loc6_:* = this.items;
         for each(_loc3_ in this.items) {
            if(_loc3_.selected) {
               _loc2_ = _loc2_ + _loc3_.feedPower;
               _loc1_++;
            }
         }
         if(this.currentPet) {
            this.view.feedGoldButton.price = 1?FeedFuseCostModel.getFeedGoldCost(this.currentPet.rarity) * _loc1_:0;
            this.view.feedFameButton.price = 1?FeedFuseCostModel.getFeedFameCost(this.currentPet.rarity) * _loc1_:0;
            this.view.updateFeedPower(_loc2_,this.currentPet.maxedAvailableAbilities());
         } else {
            this.view.feedGoldButton.price = 0;
            this.view.feedFameButton.price = 0;
            this.view.updateFeedPower(0,false);
         }
         this.simulateFeed.dispatch(_loc2_);
      }
      
      private function hasFeedPower(param1:int) : Boolean {
         var _loc2_:XML = ObjectLibrary.xmlLibrary_[param1];
         return _loc2_.hasOwnProperty("feedPower");
      }
      
      private function purchaseFame(param1:BaseButton) : void {
         this.purchase(1,this.view.feedFameButton.price);
      }
      
      private function purchaseGold(param1:BaseButton) : void {
         this.purchase(0,this.view.feedGoldButton.price);
      }
      
      private function purchase(param1:int, param2:int) : void {
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc8_:* = null;
         if(!this.checkYardType()) {
            return;
         }
         if(param1 == 0 && this.currentGold < param2) {
            this.showPopup.dispatch(new NotEnoughResources(300,0));
            return;
         }
         if(param1 == 1 && this.currentFame < param2) {
            this.showPopup.dispatch(new NotEnoughResources(300,1));
            return;
         }
         var _loc5_:Vector.<SlotObjectData> = new Vector.<SlotObjectData>();
         var _loc6_:* = this.items;
         var _loc10_:int = 0;
         var _loc9_:* = this.items;
         for each(_loc7_ in this.items) {
            if(_loc7_.selected) {
               _loc8_ = new SlotObjectData();
               _loc8_.objectId_ = _loc7_.item.ownerGrid.owner.objectId_;
               _loc8_.objectType_ = _loc7_.item.getItemId();
               _loc8_.slotId_ = _loc7_.item.tileId;
               _loc5_.push(_loc8_);
            }
         }
         this.currentPet.abilityUpdated.addOnce(this.abilityUpdated);
         this.showFade.dispatch();
         _loc3_ = new FeedPetRequestVO(this.currentPet.getID(),_loc5_,param1);
         this.upgradePet.dispatch(_loc3_);
      }
      
      private function abilityUpdated() : void {
         var _loc3_:* = null;
         this.removeFade.dispatch();
         this.renderItems();
         var _loc1_:* = this.items;
         var _loc5_:int = 0;
         var _loc4_:* = this.items;
         for each(_loc3_ in this.items) {
            _loc3_.selected = false;
         }
         this.refreshFeedPower();
      }
      
      private function onPetSelected(param1:PetVO) : void {
         var _loc2_:* = null;
         this.currentPet = param1;
         var _loc3_:* = this.items;
         var _loc6_:int = 0;
         var _loc5_:* = this.items;
         for each(_loc2_ in this.items) {
            _loc2_.selected = false;
         }
         this.refreshFeedPower();
      }
      
      private function checkYardType() : Boolean {
         if(this.currentPet.rarity.ordinal >= this.model.getPetYardType()) {
            this.showPopup.dispatch(new ErrorModal(350,"Feed Pets",LineBuilder.getLocalizedStringFromKey("server.upgrade_petyard_first")));
            return false;
         }
         return true;
      }
   }
}
