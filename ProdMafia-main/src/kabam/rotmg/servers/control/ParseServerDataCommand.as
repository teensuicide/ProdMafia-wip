package kabam.rotmg.servers.control {
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   
   public class ParseServerDataCommand {
       
      
      [Inject]
      public var servers:ServerModel;
      
      [Inject]
      public var data:XML;
      
      public function ParseServerDataCommand() {
         super();
      }
      
      public static function makeLocalhostServer() : Server {
         return new Server().setName("Proxy").setAddress("127.0.0.1").setPort(2050).setLatLong(Infinity,Infinity).setUsage(0).setIsAdminOnly(false);
      }
      
      public function execute() : void {
         this.servers.setServers(this.makeListOfServers());
      }
      
      private function makeListOfServers() : Vector.<Server> {
         var _loc3_:* = null;
         var _loc2_:XMLList = this.data.child("Servers").child("Server");
         var _loc1_:Vector.<Server> = new Vector.<Server>(0);
         _loc1_.push(makeLocalhostServer());
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(_loc3_ in _loc2_) {
            _loc1_.push(this.makeServer(_loc3_));
         }
         return _loc1_;
      }
      
      private function makeServer(param1:XML) : Server {
         return new Server().setName(param1.Name).setAddress(param1.DNS).setPort(2050).setLatLong(param1.Lat,param1.Long).setUsage(param1.Usage).setIsAdminOnly("AdminOnly" in param1);
      }
   }
}
