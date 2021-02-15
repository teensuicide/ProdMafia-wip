package kabam.rotmg.application.model {
   import flash.display.DisplayObjectContainer;
   import flash.system.Capabilities;
   
   public class PlatformModel {
      
      private static var platform:PlatformType;
       
      
      private const DESKTOP:String = "Desktop";
      
      [Inject]
      public var root:DisplayObjectContainer;
      
      public function PlatformModel() {
         super();
      }
      
      public function isWeb() : Boolean {
         return Capabilities.playerType != "Desktop";
      }
      
      public function isDesktop() : Boolean {
         return Capabilities.playerType == "Desktop";
      }
      
      public function getPlatform() : PlatformType {
         platform = platform || this.determinePlatform();
         return platform || this.determinePlatform();
      }
      
      private function determinePlatform() : PlatformType {
         return PlatformType.WEB;
      }
   }
}
