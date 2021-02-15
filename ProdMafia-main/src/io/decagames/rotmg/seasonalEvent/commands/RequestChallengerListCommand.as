package io.decagames.rotmg.seasonalEvent.commands {
   import io.decagames.rotmg.seasonalEvent.tasks.GetChallengerListTask;
   import kabam.lib.tasks.BranchingTask;
   import kabam.lib.tasks.DispatchSignalTask;
   import kabam.lib.tasks.Task;
   import kabam.lib.tasks.TaskMonitor;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.TaskErrorSignal;
   import kabam.rotmg.death.model.DeathModel;
   import kabam.rotmg.fame.model.FameModel;
   import kabam.rotmg.legends.control.FameListUpdateSignal;
   
   public class RequestChallengerListCommand {
       
      
      [Inject]
      public var task:GetChallengerListTask;
      
      [Inject]
      public var update:FameListUpdateSignal;
      
      [Inject]
      public var error:TaskErrorSignal;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      [Inject]
      public var player:PlayerModel;
      
      [Inject]
      public var death:DeathModel;
      
      [Inject]
      public var model:FameModel;
      
      public function RequestChallengerListCommand() {
         super();
      }
      
      public function execute() : void {
         this.task.charId = this.getCharId();
         var _loc1_:BranchingTask = new BranchingTask(this.task,this.makeSuccess(),this.makeFailure());
         this.monitor.add(_loc1_);
         _loc1_.start();
      }
      
      private function getCharId() : int {
         if(this.player.hasAccount() && this.death.getIsDeathViewPending()) {
            return this.death.getLastDeath().charId_;
         }
         return -1;
      }
      
      private function makeSuccess() : Task {
         return new DispatchSignalTask(this.update);
      }
      
      private function makeFailure() : Task {
         return new DispatchSignalTask(this.error,this.task);
      }
   }
}
