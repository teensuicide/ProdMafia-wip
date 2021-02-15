package io.decagames.rotmg.dailyQuests.command {
   import io.decagames.rotmg.dailyQuests.messages.incoming.QuestFetchResponse;
   import io.decagames.rotmg.dailyQuests.model.DailyQuest;
   import io.decagames.rotmg.dailyQuests.model.DailyQuestsModel;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class QuestFetchCompleteCommand extends Command {
       
      
      [Inject]
      public var response:QuestFetchResponse;
      
      [Inject]
      public var model:DailyQuestsModel;
      
      private var _questsList:Vector.<DailyQuest>;
      
      public function QuestFetchCompleteCommand() {
         super();
      }
      
      override public function execute() : void {
         var _loc4_:int = 0;
         var _loc2_:* = undefined;
         var _loc3_:* = null;
         var _loc1_:* = null;
         this.model.clear();
         this.model.nextRefreshPrice = this.response.nextRefreshPrice;
         if(this.response.quests) {
            this._questsList = new Vector.<DailyQuest>(0);
            _loc4_ = 0;
            _loc2_ = this.response.quests;
            var _loc6_:int = 0;
            var _loc5_:* = this.response.quests;
            for each(_loc3_ in this.response.quests) {
               _loc1_ = new DailyQuest();
               _loc1_.id = _loc3_.id;
               _loc1_.name = _loc3_.name;
               _loc1_.description = _loc3_.description;
               _loc1_.expiration = _loc3_.expiration;
               _loc1_.requirements = _loc3_.requirements;
               _loc1_.rewards = _loc3_.rewards;
               _loc1_.completed = _loc3_.completed;
               _loc1_.category = _loc3_.category;
               _loc1_.itemOfChoice = _loc3_.itemOfChoice;
               _loc1_.repeatable = _loc3_.repeatable;
               _loc1_.weight = _loc3_.weight;
               this._questsList.push(_loc1_);
            }
            this._questsList.sort(this.questWeightSort);
            this.model.addQuests(this._questsList);
         }
      }
      
      private function questWeightSort(param1:DailyQuest, param2:DailyQuest) : int {
         if(param1.weight > param2.weight) {
            return -1;
         }
         if(param1.weight < param2.weight) {
            return 1;
         }
         return 0;
      }
   }
}
