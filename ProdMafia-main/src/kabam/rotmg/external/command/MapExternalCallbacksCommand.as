package kabam.rotmg.external.command {
   import kabam.rotmg.external.service.ExternalServiceHelper;
   import robotlegs.bender.bundles.mvcs.Command;
   
   public class MapExternalCallbacksCommand extends Command {
       
      
      [Inject]
      public var externalServiceHelper:ExternalServiceHelper;
      
      public function MapExternalCallbacksCommand() {
         super();
      }
      
      override public function execute() : void {
         this.externalServiceHelper.mapExternalCallbacks();
      }
   }
}
