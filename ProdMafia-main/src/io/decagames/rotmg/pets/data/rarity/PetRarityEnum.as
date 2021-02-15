package io.decagames.rotmg.pets.data.rarity {
import kabam.rotmg.text.view.stringBuilder.LineBuilder;

public class PetRarityEnum {

    public static const COMMON:PetRarityEnum = new PetRarityEnum("Pets.common", 0, 12960964, 4539717);

    public static const UNCOMMON:PetRarityEnum = new PetRarityEnum("Pets.uncommon", 1, 12960964, 4539717);

    public static const RARE:PetRarityEnum = new PetRarityEnum("Pets.rare", 2, 222407, 672896);

    public static const LEGENDARY:PetRarityEnum = new PetRarityEnum("Pets.legendary", 3, 222407, 672896);

    public static const DIVINE:PetRarityEnum = new PetRarityEnum("Pets.divine", 4, 12951808, 8349960);

    public static function get list():Array {
        return [COMMON, UNCOMMON, RARE, LEGENDARY, DIVINE];
    }

    public static function parseNames():void {
        var _loc3_:* = null;
        var _loc1_:* = PetRarityEnum.list;
        var _loc5_:int = 0;
        var _loc4_:* = PetRarityEnum.list;
        for each(_loc3_ in PetRarityEnum.list) {
            _loc3_.rarityName = LineBuilder.getLocalizedStringFromKey(_loc3_.rarityKey);
        }
    }

    public static function selectByRarityKey(param1:String):PetRarityEnum {
        var _loc2_:* = null;
        var _loc3_:* = null;
        var _loc4_:* = PetRarityEnum.list;
        var _loc7_:int = 0;
        var _loc6_:* = PetRarityEnum.list;
        for each(_loc3_ in PetRarityEnum.list) {
            if (param1 == _loc3_.rarityKey) {
                _loc2_ = _loc3_;
            }
        }
        return _loc2_;
    }

    public static function selectByRarityName(param1:String):PetRarityEnum {
        var _loc2_:* = null;
        var _loc3_:* = null;
        var _loc4_:* = PetRarityEnum.list;
        var _loc7_:int = 0;
        var _loc6_:* = PetRarityEnum.list;
        for each(_loc3_ in PetRarityEnum.list) {
            if (param1 == _loc3_.rarityName) {
                _loc2_ = _loc3_;
            }
        }
        return _loc2_;
    }

    public static function selectByOrdinal(param1:int):PetRarityEnum {
        var _loc2_:* = null;
        var _loc3_:* = null;
        var _loc4_:* = PetRarityEnum.list;
        var _loc7_:int = 0;
        var _loc6_:* = PetRarityEnum.list;
        for each(_loc3_ in PetRarityEnum.list) {
            if (param1 == _loc3_.ordinal) {
                _loc2_ = _loc3_;
            }
        }
        return _loc2_;
    }

    public function PetRarityEnum(param1:String, param2:int, param3:uint, param4:uint) {
        super();
        this.rarityKey = param1;
        this.ordinal = param2;
        this.color = param3;
        this.backgroundColor = param4;
    }
    public var rarityKey:String;
    public var ordinal:int;
    public var rarityName:String;
    public var color:uint;
    public var backgroundColor:uint;
}
}
