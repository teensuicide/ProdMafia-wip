package kabam.rotmg.core.commands {
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.tasks.GetOwnedPetSkinsTask;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import io.decagames.rotmg.supportCampaign.tasks.GetCampaignStatusTask;
   import kabam.lib.tasks.TaskMonitor;
   import kabam.rotmg.account.core.services.GetCharListTask;
   import kabam.rotmg.account.core.services.GetIgnoreListTask;
   import kabam.rotmg.account.core.services.GetLockListTask;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.dailyLogin.tasks.FetchPlayerCalendarTask;
   
   public class SetScreenWithValidDataCommand {
       
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var view:Sprite;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      [Inject]
      public var task:GetCharListTask;
      
      [Inject]
      public var calendarTask:FetchPlayerCalendarTask;
      
      [Inject]
      public var campaignStatusTask:GetCampaignStatusTask;
      
      [Inject]
      public var petSkinsTask:GetOwnedPetSkinsTask;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var getLockListTask:GetLockListTask;
      
      [Inject]
      public var getIgnoreListTask:GetIgnoreListTask;
      
      public function SetScreenWithValidDataCommand() {
         super();
      }
      
      public function execute() : void {
         if(this.model.isInvalidated) {
            this.reloadDataThenSetScreen();
         } else {
            this.setScreen.dispatch(this.view);
         }
      }
      
      private function reloadDataThenSetScreen() : void {
         this.setScreen.dispatch(this.view);
      }
   }
}
