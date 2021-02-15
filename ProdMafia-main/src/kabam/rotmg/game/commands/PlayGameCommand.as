package kabam.rotmg.game.commands {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.utils.ByteArray;
   import io.decagames.rotmg.pets.data.PetsModel;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.lib.net.impl.SocketServerModel;
   import kabam.lib.tasks.TaskMonitor;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   
   public class PlayGameCommand {
      
      public static const RECONNECT_DELAY:int = 250;
       
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var data:GameInitData;
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var petsModel:PetsModel;
      
      [Inject]
      public var serverModel:ServerModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      [Inject]
      public var monitor:TaskMonitor;
      
      [Inject]
      public var socketServerModel:SocketServerModel;
      
      public function PlayGameCommand() {
         super();
      }
      
      public function execute() : void {
         if(!this.data.isNewGame) {
            this.socketServerModel.connectDelayMS = Parameters.data.reconnectDelay;
         }
         this.recordCharacterUseInSharedObject();
         this.makeGameView();
         this.updatePet();
      }
      
      private function updatePet() : void {
         var _loc1_:SavedCharacter = this.model.getCharacterById(this.model.currentCharId);
         if(_loc1_) {
            this.petsModel.setActivePet(_loc1_.getPetVO());
         } else {
            if(this.model.currentCharId && this.petsModel.getActivePet() && !this.data.isNewGame) {
               return;
            }
            this.petsModel.setActivePet(null);
         }
      }
      
      private function recordCharacterUseInSharedObject() : void {
         Parameters.data.charIdUseMap[this.data.charId] = new Date().getTime();
         Parameters.save();
      }
      
      private function makeGameView() : void {
         this.serverModel.setAvailableServers();
         var _loc1_:Server = this.data.server || this.serverModel.getServer();
         var _loc3_:int = !!this.data.isNewGame?int(this.getInitialGameId()):int(this.data.gameId);
         var _loc4_:Boolean = this.data.createCharacter;
         var _loc9_:int = this.data.charId;
         var _loc7_:int = !!this.data.isNewGame?-1:int(this.data.keyTime);
         var _loc5_:ByteArray = this.data.key;
         this.model.currentCharId = _loc9_;
         this.setScreen.dispatch(new GameSprite(_loc1_,_loc3_,_loc4_,_loc9_,_loc7_,_loc5_,this.model,null,this.data.isFromArena));
      }
      
      private function getInitialGameId() : int {
         var _loc1_:int = 0;
         if(Parameters.data.needsTutorial) {
            _loc1_ = -1;
         } else if(Parameters.data.needsRandomRealm) {
            _loc1_ = -3;
         } else {
            _loc1_ = -2;
         }
         return _loc1_;
      }
   }
}
