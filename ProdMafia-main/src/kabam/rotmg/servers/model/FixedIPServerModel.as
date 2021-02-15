package kabam.rotmg.servers.model {
   import kabam.rotmg.servers.api.Server;
   import kabam.rotmg.servers.api.ServerModel;
   
   public class FixedIPServerModel implements ServerModel {
       
      
      private var localhost:Server;
      
      public function FixedIPServerModel() {
         super();
         this.localhost = new Server().setName("localhost").setPort(2050);
      }
      
      public function setIP(param1:String) : FixedIPServerModel {
         this.localhost.setAddress(param1);
         return this;
      }
      
      public function getServers() : Vector.<Server> {
         return new <Server>[this.localhost];
      }
      
      public function getServer() : Server {
         return this.localhost;
      }
      
      public function isServerAvailable() : Boolean {
         return true;
      }
      
      public function setServers(param1:Vector.<Server>) : void {
      }
      
      public function setAvailableServers() : void {
      }
      
      public function getAvailableServers() : Vector.<Server> {
         return new <Server>[this.localhost];
      }
   }
}
