package kabam.rotmg.packages.control {
   import kabam.rotmg.packages.services.PackageModel;
   import kabam.rotmg.promotions.model.BeginnersPackageModel;
   
   public class InitPackagesCommand {
       
      
      [Inject]
      public var beginnersPackageModel:BeginnersPackageModel;
      
      [Inject]
      public var packageModel:PackageModel;
      
      [Inject]
      public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
      
      [Inject]
      public var packageAvailable:PackageAvailableSignal;
      
      public function InitPackagesCommand() {
         super();
      }
      
      public function execute() : void {
         var _loc1_:Boolean = this.beginnersPackageModel.status == 0 && this.packageModel.startupPackage() != null;
         if(this.beginnersPackageModel.isBeginnerAvailable() || _loc1_) {
            this.beginnersPackageAvailable.dispatch(_loc1_);
         } else if(this.packageModel.hasPackages()) {
            this.packageAvailable.dispatch();
         }
      }
   }
}
