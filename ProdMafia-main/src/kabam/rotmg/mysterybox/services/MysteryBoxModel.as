package kabam.rotmg.mysterybox.services {
   import kabam.rotmg.mysterybox.model.MysteryBoxInfo;
   import org.osflash.signals.Signal;
   
   public class MysteryBoxModel {
       
      
      public const updateSignal:Signal = new Signal();
      
      private var models:Object;
      
      private var initialized:Boolean = false;
      
      private var maxSlots:int = 30;
      
      private var _isNew:Boolean = false;
      
      public function MysteryBoxModel() {
         super();
      }
      
      public function get isNew() : Boolean {
         return this._isNew;
      }
      
      public function set isNew(param1:Boolean) : void {
         this._isNew = param1;
      }
      
      public function getBoxesOrderByWeight() : Object {
         return this.models;
      }
      
      public function getBoxesForGrid() : Vector.<MysteryBoxInfo> {
         var _loc1_:* = null;
         var _loc3_:Vector.<MysteryBoxInfo> = new Vector.<MysteryBoxInfo>(this.maxSlots);
         var _loc2_:* = this.models;
         var _loc6_:int = 0;
         var _loc5_:* = this.models;
         for each(_loc1_ in this.models) {
            if(_loc1_.slot != 0 && this.isBoxValid(_loc1_)) {
               _loc3_[_loc1_.slot - 1] = _loc1_;
            }
         }
         return _loc3_;
      }
      
      public function getBoxById(param1:String) : MysteryBoxInfo {
         var _loc2_:* = null;
         var _loc3_:* = this.models;
         var _loc6_:int = 0;
         var _loc5_:* = this.models;
         for each(_loc2_ in this.models) {
            if(_loc2_.id == param1) {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setMysetryBoxes(param1:Array) : void {
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
      
      public function isInitialized() : Boolean {
         return this.initialized;
      }
      
      public function setInitialized(param1:Boolean) : void {
         this.initialized = param1;
      }
      
      private function isBoxValid(param1:MysteryBoxInfo) : Boolean {
         return (param1.unitsLeft == -1 || param1.unitsLeft > 0) && (param1.maxPurchase == -1 || param1.purchaseLeft > 0);
      }
   }
}
