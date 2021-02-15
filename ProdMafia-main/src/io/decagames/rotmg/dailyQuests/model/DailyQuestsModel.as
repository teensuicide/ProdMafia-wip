package io.decagames.rotmg.dailyQuests.model {
   import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
   import io.decagames.rotmg.dailyQuests.view.slot.DailyQuestItemSlot;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.signals.UpdateQuestSignal;
   
   public class DailyQuestsModel {
       
      
      public var currentQuest:DailyQuest;
      
      public var isPopupOpened:Boolean;
      
      public var categoriesWeight:Array;
      
      public var selectedItem:int = -1;
      
      [Inject]
      public var hud:HUDModel;
      
      [Inject]
      public var updateQuestSignal:UpdateQuestSignal;
      
      private var slots:Vector.<DailyQuestItemSlot>;
      
      private var _questsList:Vector.<DailyQuest>;
      
      private var _dailyQuestsList:Vector.<DailyQuest>;
      
      private var _eventQuestsList:Vector.<DailyQuest>;
      
      private var _nextRefreshPrice:int;
      
      private var _hasQuests:Boolean;
      
      public function DailyQuestsModel() {
         categoriesWeight = [1,0,2,3,4];
         slots = new Vector.<DailyQuestItemSlot>(0);
         _dailyQuestsList = new Vector.<DailyQuest>(0);
         _eventQuestsList = new Vector.<DailyQuest>(0);
         super();
      }
      
      public function get questsList() : Vector.<DailyQuest> {
         var _loc1_:Vector.<DailyQuest> = this._questsList.concat();
         return _loc1_.sort(this.questsCompleteSort);
      }
      
      public function get dailyQuestsList() : Vector.<DailyQuest> {
         return this._dailyQuestsList;
      }
      
      public function get eventQuestsList() : Vector.<DailyQuest> {
         return this._eventQuestsList;
      }
      
      public function get nextRefreshPrice() : int {
         return this._nextRefreshPrice;
      }
      
      public function set nextRefreshPrice(param1:int) : void {
         this._nextRefreshPrice = param1;
      }
      
      public function get hasQuests() : Boolean {
         return this._hasQuests;
      }
      
      public function get playerItemsFromInventory() : Vector.<int> {
         return !this.hud.gameSprite.map.player_?new Vector.<int>():this.hud.gameSprite.map.player_.equipment_.slice(3,20);
      }
      
      public function get numberOfActiveQuests() : int {
         return this._questsList.length;
      }
      
      public function get numberOfCompletedQuests() : int {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = this._questsList;
         var _loc6_:int = 0;
         var _loc5_:* = this._questsList;
         for each(_loc1_ in this._questsList) {
            if(_loc1_.completed) {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      public function get first() : DailyQuest {
         if(this._questsList.length > 0) {
            return this.questsList[0];
         }
         return null;
      }
      
      public function registerSelectableSlot(param1:DailyQuestItemSlot) : void {
         this.slots.push(param1);
      }
      
      public function unregisterSelectableSlot(param1:DailyQuestItemSlot) : void {
         var _loc2_:int = this.slots.indexOf(param1);
         if(_loc2_ != -1) {
            this.slots.splice(_loc2_,1);
         }
      }
      
      public function unselectAllSlots(param1:int) : void {
         var _loc2_:* = null;
         var _loc3_:* = this.slots;
         var _loc6_:int = 0;
         var _loc5_:* = this.slots;
         for each(_loc2_ in this.slots) {
            if(_loc2_.itemID != param1) {
               _loc2_.selected = false;
            }
         }
      }
      
      public function clear() : void {
         this._dailyQuestsList.length = 0;
         this._eventQuestsList.length = 0;
         if(this._questsList) {
            this._questsList.length = 0;
         }
      }
      
      public function addQuests(param1:Vector.<DailyQuest>) : void {
         var _loc2_:* = null;
         this._questsList = param1;
         if(this._questsList.length > 0) {
            this._hasQuests = true;
         }
         var _loc3_:* = this._questsList;
         var _loc6_:int = 0;
         var _loc5_:* = this._questsList;
         for each(_loc2_ in this._questsList) {
            this.addQuestToCategoryList(_loc2_);
         }
         this.updateQuestSignal.dispatch("UpdateQuestSignal.QuestListLoaded");
      }
      
      public function addQuestToCategoryList(param1:DailyQuest) : void {
         if(param1.category == 7) {
            this._eventQuestsList.push(param1);
         } else {
            this._dailyQuestsList.push(param1);
         }
      }
      
      public function markAsCompleted(param1:String) : void {
         var _loc2_:* = null;
         var _loc3_:* = this._questsList;
         var _loc6_:int = 0;
         var _loc5_:* = this._questsList;
         for each(_loc2_ in this._questsList) {
            if(_loc2_.id == param1 && !_loc2_.repeatable) {
               _loc2_.completed = true;
            }
         }
      }
      
      public function getQuestById(param1:String) : DailyQuest {
         var _loc2_:* = null;
         var _loc3_:* = this._questsList;
         var _loc6_:int = 0;
         var _loc5_:* = this._questsList;
         for each(_loc2_ in this._questsList) {
            if(_loc2_.id == param1) {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeQuestFromlist(param1:DailyQuest) : void {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc2_ < this._eventQuestsList.length) {
            if(param1.id == this._eventQuestsList[_loc2_].id) {
               this._eventQuestsList.splice(_loc2_,1);
            }
            _loc2_++;
         }
         while(_loc3_ < this._questsList.length) {
            if(param1.id == this._questsList[_loc3_].id) {
               this._questsList.splice(_loc3_,1);
            }
            _loc3_++;
         }
      }
      
      private function questsNameSort(param1:DailyQuest, param2:DailyQuest) : int {
         if(param1.name > param2.name) {
            return 1;
         }
         return -1;
      }
      
      private function sortByCategory(param1:DailyQuest, param2:DailyQuest) : int {
         if(this.categoriesWeight[param1.category] < this.categoriesWeight[param2.category]) {
            return -1;
         }
         if(this.categoriesWeight[param1.category] > this.categoriesWeight[param2.category]) {
            return 1;
         }
         return this.questsNameSort(param1,param2);
      }
      
      private function questsReadySort(param1:DailyQuest, param2:DailyQuest) : int {
         var _loc4_:Boolean = DailyQuestInfo.hasAllItems(param1.requirements,this.playerItemsFromInventory);
         var _loc3_:Boolean = DailyQuestInfo.hasAllItems(param2.requirements,this.playerItemsFromInventory);
         if(_loc4_ && !_loc3_) {
            return -1;
         }
         if(_loc4_ && _loc3_) {
            return this.questsNameSort(param1,param2);
         }
         return 1;
      }
      
      private function questsCompleteSort(param1:DailyQuest, param2:DailyQuest) : int {
         if(param1.completed && !param2.completed) {
            return 1;
         }
         if(param1.completed && param2.completed) {
            return this.sortByCategory(param1,param2);
         }
         if(!param1.completed && !param2.completed) {
            return this.sortByCategory(param1,param2);
         }
         return -1;
      }
   }
}
