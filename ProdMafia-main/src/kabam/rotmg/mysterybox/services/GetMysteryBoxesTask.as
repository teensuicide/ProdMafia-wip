package kabam.rotmg.mysterybox.services {
   import com.company.assembleegameclient.util.TimeUtil;
   import com.company.util.MoreObjectUtil;
   import kabam.lib.tasks.BaseTask;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.language.model.LanguageModel;
   import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
   import robotlegs.bender.framework.api.ILogger;
   
   public class GetMysteryBoxesTask extends BaseTask {
      
      private static var version:String = "0";
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var mysteryBoxModel:MysteryBoxModel;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var languageModel:LanguageModel;
      
      [Inject]
      public var openDialogSignal:OpenDialogSignal;
      
      public function GetMysteryBoxesTask() {
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
         this.client.sendRequest("/mysterybox/getBoxes",_loc1_);
         this.client.complete.addOnce(this.onComplete);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(param1) {
            this.handleOkay(param2);
         } else {
            this.logger.warn("GetMysteryBox.onComplete: Request failed.");
            completeTask(true);
         }
         reset();
      }
      
      private function handleOkay(param1:*) : void {
         version = XML(param1).attribute("version").toString();
         var _loc2_:XMLList = XML(param1).child("MysteryBox");
         var _loc3_:XMLList = XML(param1).child("SoldCounter");
         if(_loc3_.length() > 0) {
            this.updateSoldCounters(_loc3_);
         }
         if(_loc2_.length() > 0) {
            this.parse(_loc2_);
         } else if(this.mysteryBoxModel.isInitialized()) {
            this.mysteryBoxModel.updateSignal.dispatch();
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
            _loc3_ = this.mysteryBoxModel.getBoxById(_loc2_.attribute("id").toString());
            if(_loc2_.attribute("left") != "-1") {
               _loc3_.unitsLeft = _loc2_.attribute("left");
            }
            if(_loc2_.attribute("purchaseLeft") != "-1") {
               _loc3_.purchaseLeft = _loc2_.attribute("purchaseLeft");
            }
         }
      }
      
      private function parse(param1:XMLList) : void {
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc7_:Boolean = false;
         var _loc2_:* = [];
         var _loc4_:* = param1;
         var _loc9_:int = 0;
         var _loc8_:* = param1;
         for each(_loc6_ in param1) {
            _loc3_ = new MysteryBoxInfo();
            _loc3_.id = _loc6_.attribute("id").toString();
            _loc3_.title = _loc6_.attribute("title").toString();
            _loc3_.weight = _loc6_.attribute("weight").toString();
            _loc3_.description = _loc6_.Description.toString();
            _loc3_.contents = _loc6_.Contents.toString();
            _loc3_.priceAmount = _loc6_.Price.attribute("amount").toString();
            _loc3_.priceCurrency = _loc6_.Price.attribute("currency").toString();
            if(_loc6_.hasOwnProperty("Sale")) {
               _loc3_.saleAmount = _loc6_.Sale.attribute("price").toString();
               _loc3_.saleCurrency = _loc6_.Sale.attribute("currency").toString();
            }
            if(_loc6_.hasOwnProperty("Left")) {
               _loc3_.unitsLeft = _loc6_.Left;
            }
            if(_loc6_.hasOwnProperty("Total")) {
               _loc3_.totalUnits = _loc6_.Total;
            }
            if(_loc6_.hasOwnProperty("Slot")) {
               _loc3_.slot = _loc6_.Slot;
            }
            if(_loc6_.hasOwnProperty("Jackpots")) {
               _loc3_.jackpots = _loc6_.Jackpots;
            }
            if(_loc6_.hasOwnProperty("DisplayedItems")) {
               _loc3_.displayedItems = _loc6_.DisplayedItems;
            }
            if(_loc6_.hasOwnProperty("Rolls")) {
               _loc3_.rolls = _loc6_.Rolls;
            }
            if(_loc6_.hasOwnProperty("Tags")) {
               _loc3_.tags = _loc6_.Tags;
            }
            if(_loc6_.hasOwnProperty("MaxPurchase")) {
               _loc3_.maxPurchase = _loc6_.MaxPurchase;
            }
            if(_loc6_.hasOwnProperty("PurchaseLeft")) {
               _loc3_.purchaseLeft = _loc6_.PurchaseLeft;
            }
            _loc3_.iconImageUrl = _loc6_.Icon.toString();
            _loc3_.infoImageUrl = _loc6_.Image.toString();
            _loc3_.startTime = TimeUtil.parseUTCDate(_loc6_.StartTime.toString());
            if(_loc6_.EndTime.toString()) {
               _loc3_.endTime = TimeUtil.parseUTCDate(_loc6_.EndTime.toString());
            }
            _loc3_.parseContents();
            if(!_loc7_ && (_loc3_.isNew() || _loc3_.isOnSale())) {
               _loc7_ = true;
            }
            _loc2_.push(_loc3_);
         }
         this.mysteryBoxModel.setMysetryBoxes(_loc2_);
         this.mysteryBoxModel.isNew = _loc7_;
      }
   }
}
