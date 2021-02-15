package kabam.rotmg.game.model {
   import flash.utils.Dictionary;
   import kabam.rotmg.ui.model.PotionModel;
   import org.osflash.signals.Signal;
   
   public class PotionInventoryModel {
      
      public static const HEALTH_POTION_ID:int = 2594;
      
      public static const HEALTH_POTION_SLOT:int = 1000000;
      
      public static const MAGIC_POTION_ID:int = 2595;
      
      public static const MAGIC_POTION_SLOT:int = 1000001;
       
      
      public var potionModels:Dictionary;
      
      public var updatePosition:Signal;
      
      public function PotionInventoryModel() {
         super();
         this.potionModels = new Dictionary();
         this.updatePosition = new Signal(int);
      }
      
      public static function getPotionSlot(param1:int) : int {
         switch(int(param1) - 2594) {
            case 0:
               return 1000000;
            case 1:
               return 1000001;
            default:
               return 0;
         }
      }
      
      public function initializePotionModels(param1:XML) : void {
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc2_:int = param1.PotionPurchaseCooldown;
         var _loc6_:int = param1.PotionPurchaseCostCooldown;
         var _loc3_:int = param1.MaxStackablePotions;
         var _loc7_:* = [];
         var _loc4_:* = param1.PotionPurchaseCosts.cost;
         var _loc11_:int = 0;
         var _loc10_:* = param1.PotionPurchaseCosts.cost;
         for each(_loc9_ in param1.PotionPurchaseCosts.cost) {
            _loc7_.push(_loc9_);
         }
         _loc8_ = new PotionModel();
         _loc8_.purchaseCooldownMillis = _loc2_;
         _loc8_.priceCooldownMillis = _loc6_;
         _loc8_.maxPotionCount = _loc3_;
         _loc8_.objectId = 2594;
         _loc8_.position = 0;
         _loc8_.costs = _loc7_;
         this.potionModels[_loc8_.position] = _loc8_;
         _loc8_.update.add(this.update);
         _loc8_ = new PotionModel();
         _loc8_.purchaseCooldownMillis = _loc2_;
         _loc8_.priceCooldownMillis = _loc6_;
         _loc8_.maxPotionCount = _loc3_;
         _loc8_.objectId = 2595;
         _loc8_.position = 1;
         _loc8_.costs = _loc7_;
         this.potionModels[_loc8_.position] = _loc8_;
         _loc8_.update.add(this.update);
      }
      
      public function getPotionModel(param1:uint) : PotionModel {
         var _loc2_:* = undefined;
         var _loc3_:* = this.potionModels;
         var _loc6_:int = 0;
         var _loc5_:* = this.potionModels;
         for(_loc2_ in this.potionModels) {
            if(this.potionModels[_loc2_].objectId == param1) {
               return this.potionModels[_loc2_];
            }
         }
         return null;
      }
      
      private function update(param1:int) : void {
         this.updatePosition.dispatch(param1);
      }
   }
}
