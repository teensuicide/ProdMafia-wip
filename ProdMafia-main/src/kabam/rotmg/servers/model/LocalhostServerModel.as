package kabam.rotmg.servers.model {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   
   public class LocalhostServerModel implements ServerModel {
       
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var localhost:Server;
      
      private var servers:Vector.<Server>;
      
      private var availableServers:Vector.<Server>;
      
      public function LocalhostServerModel() {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         super();
         this.servers = new Vector.<Server>(0);
         while(_loc2_ < 40) {
            _loc1_ = _loc2_ % 2 == 0?"localhost":"C_localhost" + _loc2_;
            _loc3_ = new Server().setName(_loc1_).setAddress("localhost").setPort(2050);
            this.servers.push(_loc3_);
            _loc2_++;
         }
      }
      
      public function setAvailableServers() : void {
         var _loc3_:* = null;
         if(!this.availableServers) {
            this.availableServers = new Vector.<Server>(0);
         } else {
            this.availableServers.length = 0;
         }
         for each(_loc3_ in this.servers) {
            this.availableServers.push(_loc3_);
         }
      }
      
      public function getAvailableServers() : Vector.<Server> {
         return this.availableServers;
      }
      
      public function getServer() : Server {
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc6_:Boolean = this.playerModel.isAdmin();
         this.setAvailableServers();
         for each(_loc9_ in this.availableServers) {
            if(!(_loc9_.isFull() && !_loc6_)) {
               _loc8_ = Parameters.data.preferredServer;
               if(_loc9_.name == _loc8_) {
                  return _loc9_;
               }
               _loc7_ = this.availableServers[0];
               Parameters.data.bestServer = _loc7_.name;
               Parameters.save();
            }
         }
         return _loc7_;
      }
      
      public function isServerAvailable() : Boolean {
         return true;
      }
      
      public function setServers(param1:Vector.<Server>) : void {
      }
      
      public function getServers() : Vector.<Server> {
         return this.servers;
      }
   }
}
