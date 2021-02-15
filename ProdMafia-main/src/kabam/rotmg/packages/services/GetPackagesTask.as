package kabam.rotmg.packages.services {
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.MoreObjectUtil;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.language.model.LanguageModel;
   import kabam.rotmg.packages.model.PackageInfo;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GetPackagesTask extends BaseTask {
      
      private static var version:String = "0";
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var packageModel:PackageModel;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var languageModel:LanguageModel;
      
      public function GetPackagesTask() {
         super();
      }
      
      override protected function startTask() : void {
         var _loc1_:Object = {};
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         _loc1_.language = "en";
         _loc1_.version = 0;
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         _loc1_.game_net_user_id = this.account.gameNetworkUserId();
         _loc1_.game_net = this.account.gameNetwork();
         _loc1_.play_platform = this.account.playPlatform();
         this.client.sendRequest("/package/getPackages",_loc1_);
         this.client.complete.addOnce(this.onComplete);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.handleOkay(param2);
         } else {
            this.logger.warn("GetPackageTask.onComplete: Request failed.");
            completeTask(true);
         }
         reset();
      }
      
      private function handleOkay(param1:*) : void {
         version = XML(param1).attribute("version").toString();
         var _loc2_:XMLList = XML(param1).child("Package");
         var _loc3_:XMLList = XML(param1).child("SoldCounter");
         if(_loc3_.length() > 0) {
            this.updateSoldCounters(_loc3_);
         }
         if(_loc2_.length() > 0) {
            this.parse(_loc2_);
         } else if(this.packageModel.getInitialized()) {
            this.packageModel.updateSignal.dispatch();
         }
         completeTask(true);
      }
      
      private function updateSoldCounters(param1:XMLList) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = param1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(_loc2_ in param1) {
            _loc3_ = this.packageModel.getPackageById(_loc2_.attribute("id").toString());
            if(_loc3_ != null) {
               if(_loc2_.attribute("left") != "-1") {
                  _loc3_.unitsLeft = _loc2_.attribute("left");
               }
               if(_loc2_.attribute("purchaseLeft") != "-1") {
                  _loc3_.purchaseLeft = _loc2_.attribute("purchaseLeft");
               }
            }
         }
      }
      
      private function hasNoPackage(param1:*) : Boolean {
         var _loc2_:XMLList = XML(param1).children();
         return _loc2_.length() == 0;
      }
      
      private function parse(param1:XMLList) : void {
         var _loc5_:* = null;
         var _loc3_:PackageInfo = null;
         var _loc2_:* = [];
         var _loc6_:* = param1;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc5_ in param1) {
            _loc3_ = new PackageInfo();
            _loc3_.id = _loc5_.attribute("id").toString();
            _loc3_.title = _loc5_.attribute("title").toString();
            _loc3_.weight = _loc5_.attribute("weight").toString();
            _loc3_.description = _loc5_.Description.toString();
            _loc3_.contents = _loc5_.Contents.toString();
            _loc3_.priceAmount = _loc5_.Price.attribute("amount").toString();
            _loc3_.priceCurrency = _loc5_.Price.attribute("currency").toString();
            if(_loc5_.hasOwnProperty("Sale")) {
               _loc3_.saleAmount = _loc5_.Sale.attribute("price").toString();
               _loc3_.saleCurrency = _loc5_.Sale.attribute("currency").toString();
            }
            if(_loc5_.hasOwnProperty("Left")) {
               _loc3_.unitsLeft = _loc5_.Left;
            }
            if(_loc5_.hasOwnProperty("MaxPurchase")) {
               _loc3_.maxPurchase = _loc5_.MaxPurchase;
            }
            if(_loc5_.hasOwnProperty("PurchaseLeft")) {
               _loc3_.purchaseLeft = _loc5_.PurchaseLeft;
            }
            if(_loc5_.hasOwnProperty("ShowOnLogin")) {
               _loc3_.showOnLogin = _loc5_.ShowOnLogin == 1;
            }
            if(_loc5_.hasOwnProperty("Total")) {
               _loc3_.totalUnits = _loc5_.Total;
            }
            if(_loc5_.hasOwnProperty("Slot")) {
               _loc3_.slot = _loc5_.Slot;
            }
            if(_loc5_.hasOwnProperty("Tags")) {
               _loc3_.tags = _loc5_.Tags;
            }
            if(_loc5_.StartTime.toString()) {
               _loc3_.startTime = TimeUtil.parseUTCDate(_loc5_.StartTime.toString());
            }
            _loc3_.startTime = TimeUtil.parseUTCDate(_loc5_.StartTime.toString());
            if(_loc5_.EndTime.toString()) {
               _loc3_.endTime = TimeUtil.parseUTCDate(_loc5_.EndTime.toString());
            }
            _loc3_.image = _loc5_.Image.toString();
            _loc3_.charSlot = _loc5_.CharSlot.toString();
            _loc3_.vaultSlot = _loc5_.VaultSlot.toString();
            _loc3_.gold = _loc5_.Gold.toString();
            if(_loc5_.PopupImage.toString() != "") {
               _loc3_.popupImage = _loc5_.PopupImage.toString();
            }
            _loc2_.push(_loc3_);
         }
         this.packageModel.setPackages(_loc2_);
      }
   }
}
