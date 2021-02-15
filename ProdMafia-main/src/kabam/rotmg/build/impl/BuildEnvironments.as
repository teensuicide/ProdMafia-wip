package kabam.rotmg.build.impl {
   import kabam.rotmg.build.api.BuildEnvironment;
   
   public final class BuildEnvironments {
      
      public static const LOCALHOST:String = "localhost";
      
      public static const PRIVATE:String = "private";
      
      public static const DEV:String = "dev";
      
      public static const TESTING:String = "testing";
      
      public static const TESTING2:String = "testing2";
      
      public static const PRODTEST:String = "prodtest";
      
      public static const PRODUCTION:String = "production";
      
      private static const IP_MATCHER:RegExp = /[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/;
       
      
      public function BuildEnvironments() {
         super();
      }
      
      public function getEnvironment(param1:String) : BuildEnvironment {
         return !!this.isFixedIP(param1)?BuildEnvironment.FIXED_IP:this.getEnvironmentFromName(param1);
      }
      
      private function isFixedIP(param1:String) : Boolean {
         return param1.match(IP_MATCHER) != null;
      }
      
      private function getEnvironmentFromName(param1:String) : BuildEnvironment {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "localhost":
               return BuildEnvironment.LOCALHOST;
            case "private":
               return BuildEnvironment.PRIVATE;
            case "dev":
               return BuildEnvironment.DEV;
            case "testing":
               return BuildEnvironment.TESTING;
            case "testing2":
               return BuildEnvironment.TESTING2;
            case "prodtest":
               return BuildEnvironment.PRODTEST;
            case "production":
               return BuildEnvironment.PRODUCTION;
            default:
               return BuildEnvironment.PRODUCTION;
         }
      }
   }
}
