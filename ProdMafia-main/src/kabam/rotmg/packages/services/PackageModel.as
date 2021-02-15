package kabam.rotmg.packages.services {
   import kabam.rotmg.packages.model.PackageInfo;
   import org.osflash.signals.Signal;
   
   public class PackageModel {
      
      public static const TARGETING_BOX_SLOT:int = 100;
       
      
      public const updateSignal:Signal = new Signal();
      
      public var numSpammed:int = 0;
      
      private var models:Object;
      
      private var initialized:Boolean;
      
      private var maxSlots:int = 18;
      
      public function PackageModel() {
         models = {};
         super();
      }
      
      public function getBoxesForGrid() : Vector.<PackageInfo> {
         var _loc1_:* = null;
         var _loc3_:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
         var _loc2_:* = this.models;
         var _loc6_:int = 0;
         var _loc5_:* = this.models;
         for each(_loc1_ in this.models) {
            if(_loc1_.slot != 0 && _loc1_.slot != 100 && this.isPackageValid(_loc1_)) {
               _loc3_[_loc1_.slot - 1] = _loc1_;
            }
         }
         return _loc3_;
      }
      
      public function getTargetingBoxesForGrid() : Vector.<PackageInfo> {
         var _loc1_:* = null;
         var _loc3_:Vector.<PackageInfo> = new Vector.<PackageInfo>(this.maxSlots);
         var _loc2_:* = this.models;
         var _loc6_:int = 0;
         var _loc5_:* = this.models;
         for each(_loc1_ in this.models) {
            if(_loc1_.slot == 100 && this.isPackageValid(_loc1_)) {
               _loc3_.push(_loc1_);
            }
         }
         return _loc3_;
      }
      
      public function startupPackage() : PackageInfo {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = this.models;
         var _loc6_:int = 0;
         var _loc5_:* = this.models;
         for each(_loc1_ in this.models) {
            if(_loc1_.slot == 100) {
               return _loc1_;
            }
            if(this.isPackageValid(_loc1_) && _loc1_.showOnLogin && _loc1_.popupImage != "") {
               if(_loc3_ != null) {
                  if(_loc1_.unitsLeft != -1 || _loc1_.maxPurchase != -1) {
                     _loc3_ = _loc1_;
                  }
               } else {
                  _loc3_ = _loc1_;
               }
            }
         }
         return _loc3_;
      }
      
      public function getInitialized() : Boolean {
         return this.initialized;
      }
      
      public function getPackageById(param1:int) : PackageInfo {
         return this.models[param1];
      }
      
      public function hasPackage(param1:int) : Boolean {
         return param1 in this.models;
      }
      
      public function setPackages(param1:Array) : void {
         var _loc2_:* = null;
         this.models = {};
         var _loc3_:* = param1;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for each(_loc2_ in param1) {
            this.models[_loc2_.id] = _loc2_;
         }
         this.updateSignal.dispatch();
         this.initialized = true;
      }
      
      public function canPurchasePackage(param1:int) : Boolean {
         return this.models[param1] != null;
      }
      
      public function getPriorityPackage() : PackageInfo {
         return null;
      }
      
      public function setInitialized(param1:Boolean) : void {
         this.initialized = param1;
      }
      
      public function hasPackages() : Boolean {
         var _loc3_:* = null;
         var _loc1_:* = this.models;
         var _loc5_:int = 0;
         var _loc4_:* = this.models;
         for each(_loc3_ in this.models) {
            return true;
         }
         return false;
      }
      
      private function isPackageValid(param1:PackageInfo) : Boolean {
         return (param1.unitsLeft == -1 || param1.unitsLeft > 0) && (param1.maxPurchase == -1 || param1.purchaseLeft > 0);
      }
   }
}
