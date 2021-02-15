package kabam.rotmg.servers.api {
   public class Server {
      
      public static const NORMAL_SERVER:int = 0;
      
      public static const CHALLENGER_SERVER:int = 1;
      
      public static var serverAbbreviations:Object = {};
       
      
      public var name:String;
      
      public var address:String;
      
      public var port:int;
      
      public var latLong:LatLong;
      
      public var usage:Number;
      
      public var isAdminOnly:Boolean;
      
      public function Server() {
         super();
         addToAbbrev("Proxy","proxy");
         addToAbbrev("USWest4","usw4","uswest4");
         addToAbbrev("USWest3","usw3","uswest3");
         addToAbbrev("USWest2","usw2","uswest2");
         addToAbbrev("USWest","usw","usw1","uswest1","uswest");
         addToAbbrev("USSouthWest","ussw","ussouthwest");
         addToAbbrev("USSouth3","uss3","ussouth3");
         addToAbbrev("USSouth2","uss2","ussouth2");
         addToAbbrev("USSouth","uss","uss1","ussouth1","ussouth");
         addToAbbrev("USNorthWest","usnw","usnorthwest");
         addToAbbrev("USMidWest","usmw","usmw1","usmidwest1","usmidwest");
         addToAbbrev("USMidWest2","usmw2","usmidwest2");
         addToAbbrev("USEast4","use4","useast4");
         addToAbbrev("USEast3","use3","useast3");
         addToAbbrev("USEast2","use2","useast2");
         addToAbbrev("USEast","use","use1","useast1","useast");
         addToAbbrev("EUWest2","euw2","euwest2");
         addToAbbrev("EUWest","euw","euw1","euwest1","euwest");
         addToAbbrev("EUSouthWest","eusw","eusouthwest");
         addToAbbrev("EUSouth","eus","eus1","eusouth1","eusouth");
         addToAbbrev("EUNorth2","eun2","eunorth2");
         addToAbbrev("EUNorth","eun","eun1","eunorth1","eunorth");
         addToAbbrev("EUEast2","eue2","eueast2");
         addToAbbrev("EUEast","eue","eue1","eueast1","eueast");
         addToAbbrev("AsiaSouthEast","ase","asiasoutheast");
         addToAbbrev("AsiaEast","ae","asiaeast");
         addToAbbrev("Australia","au","aus","australia");
      }
      
      private static function addToAbbrev(param1:String, ... rest) : void {
         var _loc4_:int = 0;
         var _loc3_:int = rest.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_) {
            serverAbbreviations[rest[_loc4_]] = param1;
            _loc4_++;
         }
      }
      
      public function setName(param1:String) : Server {
         this.name = param1;
         return this;
      }
      
      public function setAddress(param1:String) : Server {
         this.address = param1;
         return this;
      }
      
      public function setPort(param1:int) : Server {
         this.port = param1;
         return this;
      }
      
      public function setLatLong(param1:Number, param2:Number) : Server {
         this.latLong = new LatLong(param1,param2);
         return this;
      }
      
      public function setUsage(param1:Number) : Server {
         this.usage = param1;
         return this;
      }
      
      public function setIsAdminOnly(param1:Boolean) : Server {
         this.isAdminOnly = param1;
         return this;
      }
      
      public function priority() : int {
         return !!this.isAdminOnly?2:Number(!!this.isCrowded()?1:0);
      }
      
      public function isCrowded() : Boolean {
         return this.usage >= 0.66;
      }
      
      public function isFull() : Boolean {
         return this.usage >= 1;
      }
      
      public function toString() : String {
         return "[" + this.name + ": " + this.address + ":" + this.port + ":" + this.latLong + ":" + this.usage + ":" + this.isAdminOnly + "]";
      }
   }
}
