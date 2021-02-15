package kabam.rotmg.packages.control {
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.packages.view.PackageInfoDialog;
   
   public class BuyPackageSuccessfulCommand {
       
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      public function BuyPackageSuccessfulCommand() {
         super();
      }
      
      public function execute() : void {
         this.openDialog.dispatch(this.makeDialog());
      }
      
      private function makeDialog() : PackageInfoDialog {
         return new PackageInfoDialog().setTitle("PackagePurchased.title").setBody("PackagePurchased.message","PackagePurchased.body");
      }
   }
}
