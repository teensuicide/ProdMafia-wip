package io.decagames.rotmg.pets.commands {
   import io.decagames.rotmg.pets.data.PetsModel;
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.messaging.impl.outgoing.ActivePetUpdateRequest;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class DeactivatePetCommand extends Command {
       
      
      [Inject]
      public var instanceID:uint;
      
      [Inject]
      public var messages:MessageProvider;
      
      [Inject]
      public var server:SocketServer;
      
      [Inject]
      public var model:PetsModel;
      
      public function DeactivatePetCommand() {
         super();
      }
      
      override public function execute() : void {
         var _loc1_:ActivePetUpdateRequest = this.messages.require(24) as ActivePetUpdateRequest;
         _loc1_.instanceid = this.instanceID;
         _loc1_.commandtype = 2;
         this.server.sendMessage(_loc1_);
      }
   }
}
