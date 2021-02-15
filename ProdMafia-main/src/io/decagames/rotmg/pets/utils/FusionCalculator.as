package io.decagames.rotmg.pets.utils {
   import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
   import io.decagames.rotmg.pets.data.vo.PetVO;
   
   public class FusionCalculator {
      
      private static var ranges:Object = makeRanges();
       
      
      public function FusionCalculator() {
         super();
      }
      
      public static function getStrengthPercentage(param1:PetVO, param2:PetVO) : Number {
         var _loc4_:Number = getRarityPointsPercentage(param1);
         var _loc3_:Number = getRarityPointsPercentage(param2);
         return average(_loc4_,_loc3_);
      }
      
      private static function makeRanges() : Object {
         ranges = {};
         ranges[PetRarityEnum.COMMON.rarityKey] = 30;
         ranges[PetRarityEnum.UNCOMMON.rarityKey] = 20;
         ranges[PetRarityEnum.RARE.rarityKey] = 20;
         ranges[PetRarityEnum.LEGENDARY.rarityKey] = 20;
         return ranges;
      }
      
      private static function average(param1:Number, param2:Number) : Number {
         return (param1 + param2) / 2;
      }
      
      private static function getRarityPointsPercentage(param1:PetVO) : Number {
         var _loc2_:int = ranges[param1.rarity.rarityKey];
         var _loc4_:int = param1.maxAbilityPower - _loc2_;
         var _loc3_:int = param1.abilityList[0].level - _loc4_;
         return _loc3_ / _loc2_;
      }
   }
}
