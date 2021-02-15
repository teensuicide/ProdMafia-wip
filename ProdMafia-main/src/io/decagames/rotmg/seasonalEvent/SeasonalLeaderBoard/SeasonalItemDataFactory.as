package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import com.company.util.ConversionUtil;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.model.PlayerModel;
   
   public class SeasonalItemDataFactory {
       
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var classesModel:ClassesModel;
      
      [Inject]
      public var factory:CharacterFactory;
      
      private var seasonalLeaderBoardItemDatas:Vector.<SeasonalLeaderBoardItemData>;
      
      public function SeasonalItemDataFactory() {
         super();
      }
      
      public function createSeasonalLeaderBoardItemDatas(param1:XML) : Vector.<SeasonalLeaderBoardItemData> {
         this.seasonalLeaderBoardItemDatas = new Vector.<SeasonalLeaderBoardItemData>(0);
         this.createItemsFromList(param1.FameListElem);
         return this.seasonalLeaderBoardItemDatas;
      }
      
      public function createSeasonalLeaderBoardItemData(param1:XML) : SeasonalLeaderBoardItemData {
         var _loc2_:int = param1.ObjectType;
         var _loc6_:int = param1.Texture;
         var _loc3_:CharacterClass = this.classesModel.getCharacterClass(_loc2_);
         var _loc5_:CharacterSkin = _loc3_.skins.getSkin(_loc6_);
         var _loc9_:int = !param1.hasOwnProperty("Tex1")?0:param1.Tex1;
         var _loc8_:int = !param1.hasOwnProperty("Tex2")?0:param1.Tex2;
         var _loc4_:int = !_loc5_.is16x16?100:50;
         var _loc7_:SeasonalLeaderBoardItemData = new SeasonalLeaderBoardItemData();
         _loc7_.rank = param1.Rank;
         _loc7_.accountId = param1.@accountId;
         _loc7_.charId = param1.@charId;
         _loc7_.name = param1.Name;
         _loc7_.totalFame = param1.TotalFame;
         _loc7_.character = this.factory.makeIcon(_loc5_.template,_loc4_,_loc9_,_loc8_,_loc7_.rank <= 10);
         _loc7_.equipmentSlots = _loc3_.slotTypes;
         _loc7_.equipment = ConversionUtil.toIntVector(param1.Equipment);
         return _loc7_;
      }
      
      private function createItemsFromList(param1:XMLList) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = param1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(_loc2_ in param1) {
            if(!this.seasonalLeaderBoardItemDatasContains(_loc2_)) {
               _loc3_ = this.createSeasonalLeaderBoardItemData(_loc2_);
               _loc3_.isOwn = _loc2_.Name == this.playerModel.getName();
               this.seasonalLeaderBoardItemDatas.push(_loc3_);
            }
         }
      }
      
      private function seasonalLeaderBoardItemDatasContains(param1:XML) : Boolean {
         var _loc2_:* = null;
         var _loc3_:* = this.seasonalLeaderBoardItemDatas;
         var _loc6_:int = 0;
         var _loc5_:* = this.seasonalLeaderBoardItemDatas;
         for each(_loc2_ in this.seasonalLeaderBoardItemDatas) {
            if(_loc2_.accountId == param1.@accountId && _loc2_.charId == param1.@charId) {
               return true;
            }
         }
         return false;
      }
   }
}
