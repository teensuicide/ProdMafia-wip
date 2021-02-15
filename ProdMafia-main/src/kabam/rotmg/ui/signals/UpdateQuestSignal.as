package kabam.rotmg.ui.signals {
   import org.osflash.signals.Signal;
   
   public class UpdateQuestSignal extends Signal {
      
      public static const QUEST_LIST_LOADED:String = "UpdateQuestSignal.QuestListLoaded";
      
      public static const QUEST_INVENTORY_CHANGED:String = "UpdateQuestSignal.QuestInventoryChanged";
       
      
      public function UpdateQuestSignal() {
         super(String);
      }
   }
}
