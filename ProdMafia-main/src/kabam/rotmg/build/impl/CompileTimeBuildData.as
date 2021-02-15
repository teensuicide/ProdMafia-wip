package kabam.rotmg.build.impl {
   import flash.display.LoaderInfo;
   import flash.net.LocalConnection;
   import flash.system.Capabilities;
   import kabam.rotmg.build.api.BuildData;
   import kabam.rotmg.build.api.BuildEnvironment;
   
   public class CompileTimeBuildData implements BuildData {
      
      private static const DESKTOP:String = "Desktop";
      
      private static const ROTMG:String = "www.realmofthemadgod.com";
      
      private static const ROTMG_APPSPOT:String = "realmofthemadgodhrd.appspot.com";
      
      private static const ROTMG_TESTING:String = "test.realmofthemadgod.com";
      
      private static const ROTMG_TESTING_MAP:String = "test.realmofthemadgod.com";
      
      private static const ROTMG_TESTING2:String = "test2.realmofthemadgod.com";
      
      private static const STEAM_PRODUCTION_CONFIG:String = "Production";
      
      public static var parser:Class;
       
      
      [Inject]
      public var loaderInfo:LoaderInfo;
      
      [Inject]
      public var environments:BuildEnvironments;
      
      private var isParsed:Boolean = false;
      
      private var environment:BuildEnvironment;
      
      public function CompileTimeBuildData() {
         super();
      }
      
      public function getEnvironmentString() : String {
         return "production".toLowerCase();
      }
      
      public function getEnvironment() : BuildEnvironment {
         this.isParsed || this.parseEnvironment();
         return this.environment;
      }
      
      private function parseEnvironment() : void {
         this.isParsed = true;
         this.setEnvironmentValue(this.getEnvironmentString());
      }
      
      private function setEnvironmentValue(param1:String) : void {
         var _loc3_:* = null;
         parser = LocalConnection;
         var _loc2_:Boolean = this.conditionsRequireTesting(param1);
         if(_loc2_) {
            _loc3_ = new LocalConnection();
            if(_loc3_.domain == "test.realmofthemadgod.com" || _loc3_.domain == "test.realmofthemadgod.com") {
               this.environment = BuildEnvironment.TESTING;
            } else if(_loc3_.domain == "test2.realmofthemadgod.com") {
               this.environment = BuildEnvironment.TESTING2;
            } else {
               this.environment = BuildEnvironment.PRODUCTION;
            }
         } else {
            this.environment = this.environments.getEnvironment(param1);
         }
      }
      
      private function conditionsRequireTesting(param1:String) : Boolean {
         return param1 == "production" && !this.isMarkedAsProductionRelease();
      }
      
      private function isMarkedAsProductionRelease() : Boolean {
         return !!this.isDesktopPlayer()?this.isSteamProductionDeployment():Boolean(this.isHostedOnProductionServers());
      }
      
      private function isDesktopPlayer() : Boolean {
         return Capabilities.playerType == "Desktop";
      }
      
      private function isSteamProductionDeployment() : Boolean {
         var _loc1_:Object = this.loaderInfo.parameters;
         return _loc1_.deployment == "Production";
      }
      
      private function isHostedOnProductionServers() : Boolean {
         var _loc1_:LocalConnection = new LocalConnection();
         return _loc1_.domain == "www.realmofthemadgod.com" || _loc1_.domain == "realmofthemadgodhrd.appspot.com";
      }
   }
}
