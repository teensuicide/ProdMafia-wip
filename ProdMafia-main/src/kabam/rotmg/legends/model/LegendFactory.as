package kabam.rotmg.legends.model {
   import com.company.util.ConversionUtil;
   import kabam.rotmg.assets.services.CharacterFactory;
   import kabam.rotmg.classes.model.CharacterClass;
   import kabam.rotmg.classes.model.CharacterSkin;
   import kabam.rotmg.classes.model.ClassesModel;
   import kabam.rotmg.core.model.PlayerModel;
   
   public class LegendFactory {
       
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var classesModel:ClassesModel;
      
      [Inject]
      public var factory:CharacterFactory;
      
      private var ownAccountId:String;
      
      private var legends:Vector.<Legend>;
      
      public function LegendFactory() {
         super();
      }
      
      public function makeLegends(param1:XML) : Vector.<Legend> {
         this.ownAccountId = this.playerModel.getAccountId();
         this.legends = new Vector.<Legend>(0);
         this.makeLegendsFromList(param1.FameListElem,false);
         this.makeLegendsFromList(param1.MyFameListElem,true);
         return this.legends;
      }
      
      public function makeLegend(param1:XML) : Legend {
         var _loc2_:int = param1.ObjectType;
         var _loc6_:int = param1.Texture;
         var _loc3_:CharacterClass = this.classesModel.getCharacterClass(_loc2_);
         var _loc5_:CharacterSkin = _loc3_.skins.getSkin(_loc6_);
         var _loc9_:int = "Tex1" in param1?param1.Tex1:0;
         var _loc8_:int = "Tex2" in param1?param1.Tex2:0;
         var _loc4_:int = !!_loc5_.is16x16?50:100;
         var _loc7_:Legend = new Legend();
         _loc7_.place = this.legends.length + 1;
         _loc7_.accountId = param1.@accountId;
         _loc7_.charId = param1.@charId;
         _loc7_.name = param1.Name;
         _loc7_.totalFame = param1.TotalFame;
         _loc7_.character = this.factory.makeIcon(_loc5_.template,_loc4_,_loc9_,_loc8_,_loc7_.place <= 10);
         _loc7_.equipmentSlots = _loc3_.slotTypes;
         _loc7_.equipment = ConversionUtil.toIntVector(param1.Equipment);
         return _loc7_;
      }
      
      private function makeLegendsFromList(param1:XMLList, param2:Boolean) : void {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = param1;
         var _loc8_:int = 0;
         var _loc7_:* = param1;
         for each(_loc5_ in param1) {
            if(!this.legendsContains(_loc5_)) {
               _loc3_ = this.makeLegend(_loc5_);
               _loc3_.isOwnLegend = _loc5_.@accountId == this.ownAccountId;
               _loc3_.isFocus = param2;
               this.legends.push(_loc3_);
            }
         }
      }
      
      private function legendsContains(param1:XML) : Boolean {
         var _loc2_:* = null;
         var _loc3_:* = this.legends;
         var _loc6_:int = 0;
         var _loc5_:* = this.legends;
         for each(_loc2_ in this.legends) {
            if(_loc2_.accountId == param1.@accountId && _loc2_.charId == param1.@charId) {
               return true;
            }
         }
         return false;
      }
   }
}
