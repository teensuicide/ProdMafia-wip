package io.decagames.rotmg.pets.data.ability {
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.vo.IPetVO;

public class AbilitiesUtil {


    public static function isActiveAbility(param1:PetRarityEnum, param2:int):Boolean {
        if (param1.ordinal >= PetRarityEnum.LEGENDARY.ordinal) {
            return true;
        }
        if (param1.ordinal >= PetRarityEnum.UNCOMMON.ordinal) {
            return param2 <= 1;
        }
        return param2 == 0;
    }

    public static function abilityPowerToMinPoints(param1:int):int {
        return Math.ceil(20 * (1 - Math.pow(1.08, param1 - 1)) / -0.0800000000000001);
    }

    public static function abilityPointsToLevel(param1:int):int {
        var _loc2_:Number = param1 * 0.0800000000000001 / 20 + 1;
        return int(Math.log(_loc2_) / Math.log(1.08)) + 1;
    }

    public static function simulateAbilityUpgrade(param1:IPetVO, param2:int):Array {
        var _loc3_:* = null;
        var _loc6_:int = 0;
        var _loc5_:int = 0;
        var _loc4_:* = [];
        while (_loc5_ < 3) {
            _loc3_ = param1.abilityList[_loc5_].clone();
            if (AbilitiesUtil.isActiveAbility(param1.rarity, _loc5_) && _loc3_.level < param1.maxAbilityPower) {
                _loc3_.points = _loc3_.points + param2 * AbilityConfig.ABILITY_INDEX_TO_POINT_MODIFIER[_loc5_];
                _loc6_ = abilityPointsToLevel(_loc3_.points);
                if (_loc6_ > param1.maxAbilityPower) {
                    _loc6_ = param1.maxAbilityPower;
                    _loc3_.points = abilityPowerToMinPoints(_loc6_);
                }
                _loc3_.level = _loc6_;
            }
            _loc4_.push(_loc3_);
            _loc5_++;
        }
        return _loc4_;
    }

    public function AbilitiesUtil() {
        super();
    }
}
}
