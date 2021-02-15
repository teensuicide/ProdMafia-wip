package io.decagames.rotmg.pets.data.vo {
import com.company.assembleegameclient.objects.ObjectLibrary;

import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.skin.PetSkinRenderer;

import org.osflash.signals.Signal;

public class SkinVO extends PetSkinRenderer implements IPetVO {


    public static function parseFromXML(param1:XML):SkinVO {
        var _loc2_:SkinVO = new SkinVO();
        _loc2_.skinType = int(param1.@type);
        _loc2_.family = param1.Family[0];
        _loc2_.name = param1.DisplayId[0];
        _loc2_.rarity = PetRarityEnum.selectByRarityName(param1.Rarity[0]);
        return _loc2_;
    }

    public function SkinVO() {
        super();
    }

    private var _family:String;

    public function get family():String {
        return this._family;
    }

    public function set family(param1:String):void {
        this._family = param1;
    }

    private var _rarity:PetRarityEnum;

    public function get rarity():PetRarityEnum {
        return this._rarity;
    }

    public function set rarity(param1:PetRarityEnum):void {
        this._rarity = param1;
    }

    private var _name:String;

    public function get name():String {
        return this._name;
    }

    public function set name(param1:String):void {
        this._name = param1;
    }

    private var _isOwned:Boolean;

    public function get isOwned():Boolean {
        return this._isOwned;
    }

    public function set isOwned(param1:Boolean):void {
        this._isOwned = param1;
    }

    private var _isNew:Boolean;

    public function get isNew():Boolean {
        return this._isNew;
    }

    public function set isNew(param1:Boolean):void {
        this._isNew = param1;
    }

    public function get updated():Signal {
        return null;
    }

    public function get skinType():int {
        return _skinType;
    }

    public function set skinType(param1:int):void {
        _skinType = param1;
    }

    public function get abilityList():Array {
        return [new AbilityVO(), new AbilityVO(), new AbilityVO()];
    }

    public function get maxAbilityPower():int {
        return 0;
    }

    public function getID():int {
        return -1;
    }

    public function getType():int {
        return ObjectLibrary.petSkinIdToPetType_[ObjectLibrary.getIdFromType(this.skinType)];
    }
}
}
