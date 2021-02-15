package io.decagames.rotmg.pets.commands {
   import io.decagames.rotmg.pets.data.vo.requests.FeedPetRequestVO;
   import io.decagames.rotmg.pets.data.vo.requests.FusePetRequestVO;
   import io.decagames.rotmg.pets.data.vo.requests.IUpgradePetRequestVO;
   import io.decagames.rotmg.pets.data.vo.requests.UpgradePetYardRequestVO;
   import kabam.lib.net.api.MessageProvider;
   import kabam.lib.net.impl.SocketServer;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.view.RegisterPromptDialog;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.messaging.impl.PetUpgradeRequest;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class UpgradePetCommand extends Command {
      
      private static const PET_YARD_REGISTER_STRING:String = "In order to upgradeYard your yard you must be a registered user.";
       
      
      [Inject]
      public var vo:IUpgradePetRequestVO;
      
      [Inject]
      public var messages:MessageProvider;
      
      [Inject]
      public var server:SocketServer;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      public function UpgradePetCommand() {
         super();
      }
      
      override public function execute() : void {
         var _loc1_:* = null;
         if(this.vo is UpgradePetYardRequestVO) {
            if(!this.account.isRegistered()) {
               this.showPromptToRegister("In order to upgradeYard your yard you must be a registered user.");
            }
            _loc1_ = this.messages.require(16) as PetUpgradeRequest;
            _loc1_.petTransType = 1;
            _loc1_.objectId = UpgradePetYardRequestVO(this.vo).objectID;
            _loc1_.paymentTransType = UpgradePetYardRequestVO(this.vo).paymentTransType;
         }
         if(this.vo is FeedPetRequestVO) {
            _loc1_ = this.messages.require(16) as PetUpgradeRequest;
            _loc1_.petTransType = 2;
            _loc1_.PIDOne = FeedPetRequestVO(this.vo).petInstanceId;
            _loc1_.slotsObject = FeedPetRequestVO(this.vo).slotObjects;
            _loc1_.paymentTransType = FeedPetRequestVO(this.vo).paymentTransType;
         }
         if(this.vo is FusePetRequestVO) {
            _loc1_ = this.messages.require(16) as PetUpgradeRequest;
            _loc1_.petTransType = 3;
            _loc1_.PIDOne = FusePetRequestVO(this.vo).petInstanceIdOne;
            _loc1_.PIDTwo = FusePetRequestVO(this.vo).petInstanceIdTwo;
            _loc1_.paymentTransType = FusePetRequestVO(this.vo).paymentTransType;
         }
         if(_loc1_) {
            this.server.sendMessage(_loc1_);
         }
      }
      
      private function showPromptToRegister(param1:String) : void {
         this.openDialog.dispatch(new RegisterPromptDialog(param1));
      }
   }
}
