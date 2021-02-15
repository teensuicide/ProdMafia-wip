package kabam.rotmg.classes.control {
   import io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker;
   import kabam.rotmg.classes.model.CharacterSkinState;
   import kabam.rotmg.classes.model.ClassesModel;
   import robotlegs.bender.framework.api.ILogger;
   
   public class ParseCharListXmlCommand {
       
      
      [Inject]
      public var data:XML;
      
      [Inject]
      public var model:ClassesModel;
      
      [Inject]
      public var logger:ILogger;
      
      [Inject]
      public var statsTracker:CharactersMetricsTracker;
      
      public function ParseCharListXmlCommand() {
         super();
      }
      
      public function execute() : void {
         this.parseMaxLevelsAchieved();
         this.parseItemCosts();
         this.parseOwnership();
         //this.statsTracker.parseCharListData(this.data);
      }
      
      private function parseMaxLevelsAchieved() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:XMLList = this.data.MaxClassLevelList.MaxClassLevel;
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            _loc3_ = this.model.getCharacterClass(_loc1_.@classType);
            _loc3_.setMaxLevelAchieved(_loc1_.@maxLevel);
         }
      }
      
      private function parseItemCosts() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:XMLList = this.data.ItemCosts.ItemCost;
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            _loc3_ = this.model.getCharacterSkin(_loc1_.@type);
            if(_loc3_) {
               _loc3_.cost = _loc1_;
               _loc3_.limited = Boolean(_loc1_.@expires);
               if(!_loc1_.@purchasable && _loc3_.id != 0) {
                  _loc3_.setState(CharacterSkinState.UNLISTED);
               }
            } else {
               this.logger.warn("Cannot set Character Skin cost: type {0} not found",[_loc1_.@type]);
            }
         }
      }
      
      private function parseOwnership() : void {
         var _loc1_:int = 0;
         var _loc3_:* = null;
         var _loc2_:Array = !!this.data.OwnedSkins.length()?this.data.OwnedSkins.split(","):[];
         var _loc4_:* = _loc2_;
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc1_ in _loc2_) {
            _loc3_ = this.model.getCharacterSkin(_loc1_);
            if(_loc3_) {
               _loc3_.setState(CharacterSkinState.OWNED);
            } else {
               this.logger.warn("Cannot set Character Skin ownership: itemType {0} not found",[_loc1_]);
            }
         }
      }
   }
}
