package io.decagames.rotmg.dailyQuests.view.list {
   import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
   import io.decagames.rotmg.dailyQuests.signal.ShowQuestInfoSignal;
   import io.decagames.rotmg.dailyQuests.view.info.DailyQuestInfo;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.signals.UpdateQuestSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class DailyQuestsListMediator extends Mediator {
       
      
      [Inject]
      public var view:DailyQuestsList;
      
      [Inject]
      public var model:DailyQuestsModel;
      
      [Inject]
      public var hud:HUDModel;
      
      [Inject]
      public var updateQuestSignal:UpdateQuestSignal;
      
      [Inject]
      public var showInfoSignal:ShowQuestInfoSignal;
      
      private var hasEvent:Boolean;
      
      public function DailyQuestsListMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.onQuestsUpdate("UpdateQuestSignal.QuestListLoaded");
         this.updateQuestSignal.add(this.onQuestsUpdate);
         this.view.tabs.tabSelectedSignal.add(this.onTabSelected);
      }
      
      override public function destroy() : void {
         this.view.tabs.buttonsRenderedSignal.remove(this.onAddedHandler);
      }
      
      private function onTabSelected(param1:String) : void {
         var _loc2_:DailyQuestListElement = this.view.getCurrentlySelected(param1);
         if(_loc2_) {
            this.showInfoSignal.dispatch(_loc2_.id,_loc2_.category,param1);
         } else {
            this.showInfoSignal.dispatch("",-1,param1);
         }
      }
      
      private function onQuestsUpdate(param1:String) : void {
         this.view.clearQuestLists();
         var _loc2_:Vector.<int> = !this.hud.gameSprite.map.player_?new Vector.<int>():this.hud.gameSprite.map.player_.equipment_.slice(3,20);
         this.view.tabs.buttonsRenderedSignal.addOnce(this.onAddedHandler);
         this.addDailyQuests(_loc2_);
         this.addEventQuests(_loc2_);
      }
      
      private function addEventQuests(param1:Vector.<int>) : void {
         var _loc7_:* = null;
         var _loc3_:* = false;
         var _loc8_:* = null;
         var _loc2_:Boolean = true;
         var _loc5_:Date = new Date();
         var _loc6_:* = this.model.eventQuestsList;
         var _loc10_:int = 0;
         var _loc9_:* = this.model.eventQuestsList;
         for each(_loc7_ in this.model.eventQuestsList) {
            _loc3_ = false;
            if(_loc7_.expiration != "") {
               _loc3_ = parseFloat(_loc7_.expiration) - _loc5_.time / 1000 < 0;
            }
            if(!(_loc7_.completed || _loc3_)) {
               _loc8_ = new DailyQuestListElement(_loc7_.id,_loc7_.name,_loc7_.completed,DailyQuestInfo.hasAllItems(_loc7_.requirements,param1),_loc7_.category);
               if(_loc2_) {
                  _loc8_.isSelected = true;
               }
               _loc2_ = false;
               this.view.addEventToList(_loc8_);
               this.hasEvent = true;
            }
         }
      }
      
      private function addDailyQuests(param1:Vector.<int>) : void {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc2_:Boolean = true;
         var _loc6_:* = this.model.dailyQuestsList;
         var _loc8_:int = 0;
         var _loc7_:* = this.model.dailyQuestsList;
         for each(_loc5_ in this.model.dailyQuestsList) {
            if(!_loc5_.completed) {
               _loc3_ = new DailyQuestListElement(_loc5_.id,_loc5_.name,_loc5_.completed,DailyQuestInfo.hasAllItems(_loc5_.requirements,param1),_loc5_.category);
               if(_loc2_) {
                  _loc3_.isSelected = true;
               }
               _loc2_ = false;
               this.view.addQuestToList(_loc3_);
            }
         }
         this.onTabSelected("Quests");
      }
      
      private function onAddedHandler() : void {
         if(this.hasEvent) {
            this.view.addIndicator(this.hasEvent);
         }
      }
   }
}
