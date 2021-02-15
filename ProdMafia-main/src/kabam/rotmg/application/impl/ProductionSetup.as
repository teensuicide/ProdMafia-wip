package kabam.rotmg.application.impl {
import com.company.assembleegameclient.parameters.Parameters;

import kabam.rotmg.application.api.ApplicationSetup;
   
   public class ProductionSetup implements ApplicationSetup {
       
      
      private const SERVER:String = "www.realmofthemadgod.com";
      
      private const UNENCRYPTED:String = "http://www.realmofthemadgod.com";
      
      private const ENCRYPTED:String = "https://www.realmofthemadgod.com";
      
      private const ANALYTICS:String = "UA-101960510-3";
      
      private const BUILD_LABEL:String = "RotMG #{VERSION}.{MINOR}";
      
      public function ProductionSetup() {
         super();
      }
      
      public function getAppEngineUrl(param1:Boolean = false) : String {
         return "https://www.realmofthemadgod.com";
      }
      
      public function getAnalyticsCode() : String {
         return "UA-101960510-3";
      }
      
      public function getBuildLabel() : String {
         return "RotMG #{VERSION}".replace("{VERSION}",Parameters.CLIENT_VERSION);
      }
      
      public function useLocalTextures() : Boolean {
         return false;
      }
      
      public function isToolingEnabled() : Boolean {
         return false;
      }
      
      public function isGameLoopMonitored() : Boolean {
         return false;
      }
      
      public function isServerLocal() : Boolean {
         return false;
      }
      
      public function useProductionDialogs() : Boolean {
         return true;
      }
      
      public function areErrorsReported() : Boolean {
         return false;
      }
      
      public function areDeveloperHotkeysEnabled() : Boolean {
         return false;
      }
      
      public function isDebug() : Boolean {
         return false;
      }
      
      public function getServerDomain() : String {
         return "www.realmofthemadgod.com";
      }
   }
}
