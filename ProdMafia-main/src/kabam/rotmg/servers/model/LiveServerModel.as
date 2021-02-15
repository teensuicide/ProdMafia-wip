package kabam.rotmg.servers.model {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.servers.api.LatLong;
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   
   public class LiveServerModel implements ServerModel {
       
      
      private const servers:Vector.<Server> = new Vector.<Server>(0);
      
      [Inject]
      public var model:PlayerModel;
      
      [Inject]
      public var seasonalEventModel:SeasonalEventModel;
      
      private var _descendingFlag:Boolean;
      
      private var availableServers:Vector.<Server>;
      
      public function LiveServerModel() {
         super();
      }
      
      public function setServers(param1:Vector.<Server>) : void {
         var _loc2_:* = null;
         this.servers.length = 0;
         var _loc3_:* = param1;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(_loc2_ in param1) {
            this.servers.push(_loc2_);
         }
         this._descendingFlag = false;
         this.servers.sort(this.compareServerName);
      }
      
      public function getServers() : Vector.<Server> {
         return this.servers;
      }
      
      public function getServer() : Server {
         var _loc8_:* = null;
         var _loc3_:int = 0;
         var _loc6_:Number = NaN;
         var _loc13_:* = null;
         var _loc14_:* = false;
         var _loc2_:LatLong = this.model.getMyPos();
         var _loc10_:* = Infinity;
         var _loc5_:* = 2147483647;
         var _loc7_:String = Parameters.data.preferredServer;
         this.setAvailableServers();
         for each(_loc8_ in this.availableServers) {
            if(_loc8_.name == _loc7_) {
               return _loc8_;
            }
            _loc3_ = _loc8_.priority();
            _loc6_ = LatLong.distance(_loc2_,_loc8_.latLong);
            if(_loc3_ < _loc5_ || _loc3_ == _loc5_ && _loc6_ < _loc10_) {
               _loc13_ = _loc8_;
               _loc10_ = _loc6_;
               _loc5_ = _loc3_;
               Parameters.data.bestServer = _loc13_.name;
               Parameters.save();
            }
         }
         return _loc13_;
      }
      
      public function getServerNameByAddress(param1:String) : String {
         var _loc2_:* = null;
         var _loc3_:* = this.servers;
         var _loc6_:int = 0;
         var _loc5_:* = this.servers;
         for each(_loc2_ in this.servers) {
            if(_loc2_.address == param1) {
               return _loc2_.name;
            }
         }
         return "";
      }
      
      public function isServerAvailable() : Boolean {
         return this.servers.length > 0;
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
      
      private function compareServerName(param1:Server, param2:Server) : int {
         if(param1.name < param2.name) {
            return !this._descendingFlag?1:-1;
         }
         if(param1.name > param2.name) {
            return !this._descendingFlag?-1:1;
         }
         return 0;
      }
   }
}
