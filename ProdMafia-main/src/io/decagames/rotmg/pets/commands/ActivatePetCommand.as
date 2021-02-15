package io.decagames.rotmg.pets.commands {
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.messaging.impl.outgoing.ActivePetUpdateRequest;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class ActivatePetCommand extends Command {
       
      
      [Inject]
      public var instanceID:uint;
      
      [Inject]
      public var messages:MessageProvider;
      
      [Inject]
      public var server:SocketServer;
      
      public function ActivatePetCommand() {
         super();
      }
      
      override public function execute() : void {
         var _loc1_:ActivePetUpdateRequest = this.messages.require(24) as ActivePetUpdateRequest;
         _loc1_.instanceid = this.instanceID;
         _loc1_.commandtype = 1;
         this.server.sendMessage(_loc1_);
      }
   }
}
