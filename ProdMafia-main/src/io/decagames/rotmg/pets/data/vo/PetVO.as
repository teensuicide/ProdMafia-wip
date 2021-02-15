package io.decagames.rotmg.pets.data.vo {
import com.company.assembleegameclient.objects.ObjectLibrary;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.skin.PetSkinRenderer;

import kabam.rotmg.core.StaticInjectorContext;

import org.osflash.signals.Signal;

public class PetVO extends PetSkinRenderer implements IPetVO {


    public static function clone(param1:PetVO):PetVO {
        return new PetVO(param1.id);
    }

    private static function getPetDataDescription(param1:int):String {
        return ObjectLibrary.getPetDataXMLByType(param1).Description;
    }

    private static function getPetDataDisplayId(param1:int):String {
        return ObjectLibrary.getPetDataXMLByType(param1).@id;
    }

    public function PetVO(param1:int = undefined) {
        _abilityList = [new AbilityVO(), new AbilityVO(), new AbilityVO()];
        _updated = new Signal();
        _abilityUpdated = new Signal();
        super();
        this.id = param1;
        this.staticData = <data/>
        ;
        this.listenToAbilities();
    }
    private var staticData:XML;
    private var id:int;
    private var type:int;

    private var _rarity:PetRarityEnum;

    public function get rarity():PetRarityEnum {
        return this._rarity;
    }

    private var _name:String;

    public function get name():String {
        return this._name;
    }

    private var _maxAbilityPower:int;

    public function get maxAbilityPower():int {
        return this._maxAbilityPower;
    }

    private var _abilityList:Array;

    public function get abilityList():Array {
        return this._abilityList;
    }

    public function set abilityList(param1:Array):void {
        this._abilityList = param1;
    }

    private var _updated:Signal;

    public function get updated():Signal {
        return this._updated;
    }

    private var _abilityUpdated:Signal;

    public function get abilityUpdated():Signal {
        return this._abilityUpdated;
    }

    private var _ownedSkin:Boolean;

    public function get ownedSkin():Boolean {
        return this._ownedSkin;
    }

    public function set ownedSkin(param1:Boolean):void {
        this._ownedSkin = param1;
    }

    private var _family:String = "";

    public function get family():String {
        var _loc1_:SkinVO = this.skinVO;
        if (_loc1_) {
            return _loc1_.family;
        }
        return this.staticData.Family;
    }

    public function get totalMaxAbilitiesLevel():int {
        var _loc1_:* = null;
        var _loc3_:int = 0;
        var _loc2_:* = this._abilityList;
        var _loc6_:int = 0;
        var _loc5_:* = this._abilityList;
        for each(_loc1_ in this._abilityList) {
            if (_loc1_.getUnlocked()) {
                _loc3_ = _loc3_ + this._maxAbilityPower;
            }
        }
        return _loc3_;
    }

    public function get skinVO():SkinVO {
        return StaticInjectorContext.getInjector().getInstance(PetsModel).getSkinVOById(_skinType);
    }

    public function get skinType():int {
        return _skinType;
    }

    public function get isOwned():Boolean {
        return false;
    }

    public function get isNew():Boolean {
        return false;
    }

    public function set isNew(param1:Boolean):void {
    }

    public function maxedAvailableAbilities():Boolean {
        var _loc3_:* = null;
        var _loc1_:* = this._abilityList;
        var _loc5_:int = 0;
        var _loc4_:* = this._abilityList;
        for each(_loc3_ in this._abilityList) {
            if (_loc3_.getUnlocked() && _loc3_.level < this.maxAbilityPower) {
                return false;
            }
        }
        return true;
    }

    public function totalAbilitiesLevel():int {
        var _loc1_:* = null;
        var _loc3_:int = 0;
        var _loc2_:* = this._abilityList;
        var _loc6_:int = 0;
        var _loc5_:* = this._abilityList;
        for each(_loc1_ in this._abilityList) {
            if (_loc1_.getUnlocked() && _loc1_.level) {
                _loc3_ = _loc3_ + _loc1_.level;
            }
        }
        return _loc3_;
    }

    public function maxedAllAbilities():Boolean {
        var _loc1_:* = null;
        var _loc3_:int = 0;
        var _loc2_:* = this._abilityList;
        var _loc6_:int = 0;
        var _loc5_:* = this._abilityList;
        for each(_loc1_ in this._abilityList) {
            if (_loc1_.getUnlocked() && _loc1_.level == this.maxAbilityPower) {
                _loc3_++;
            }
        }
        return _loc3_ == this._abilityList.length;
    }

    public function apply(param1:XML):void {
        this.extractBasicData(param1);
        this.extractAbilityData(param1);
    }

    public function extractAbilityData(param1:XML):void {
        var _loc2_:int = 0;
        var _loc4_:* = null;
        var _loc3_:int = 0;
        var _loc5_:uint = this._abilityList.length;
        _loc2_ = 0;
        while (_loc2_ < _loc5_) {
            _loc4_ = this._abilityList[_loc2_];
            _loc3_ = param1.Abilities.Ability[_loc2_].@type;
            _loc4_.name = getPetDataDisplayId(_loc3_);
            _loc4_.description = getPetDataDescription(_loc3_);
            _loc4_.level = param1.Abilities.Ability[_loc2_].@power;
            _loc4_.points = param1.Abilities.Ability[_loc2_].@points;
            _loc2_++;
        }
    }

    public function setID(param1:int):void {
        this.id = param1;
    }

    public function getID():int {
        return this.id;
    }

    public function setType(param1:int):void {
        this.type = param1;
        this.staticData = ObjectLibrary.xmlLibrary_[this.type];
    }

    public function getType():int {
        return this.type;
    }

    public function setRarity(param1:uint):void {
        this._rarity = PetRarityEnum.selectByOrdinal(param1);
        this.unlockAbilitiesBasedOnPetRarity(param1);
        var _loc2_:* = this._rarity;
        switch (_loc2_) {
            case PetRarityEnum.COMMON:
                this._maxAbilityPower = 30;
                break;
            case PetRarityEnum.UNCOMMON:
                this._maxAbilityPower = 50;
                break;
            case PetRarityEnum.RARE:
                this._maxAbilityPower = 70;
                break;
            case PetRarityEnum.LEGENDARY:
                this._maxAbilityPower = 90;
                break;
            case PetRarityEnum.DIVINE:
                this._maxAbilityPower = 100;
        }
        this._updated.dispatch();
    }

    public function setName(param1:String):void {
        this._name = ObjectLibrary.typeToDisplayId_[_skinType];
        if (this._name == null || this._name == "") {
            this._name = ObjectLibrary.typeToDisplayId_[this.getType()];
        }
        this._updated.dispatch();
    }

    public function setMaxAbilityPower(param1:int):void {
        this._maxAbilityPower = param1;
        this._updated.dispatch();
    }

    public function setSkin(param1:int):void {
        _skinType = param1;
        this._updated.dispatch();
    }

    public function setFamily(param1:String):void {
        this._family = param1;
    }

    private function listenToAbilities():void {
        var _loc3_:* = null;
        var _loc1_:* = this._abilityList;
        var _loc5_:int = 0;
        var _loc4_:* = this._abilityList;
        for each(_loc3_ in this._abilityList) {
            _loc3_.updated.add(this.onAbilityUpdate);
        }
    }

    private function onAbilityUpdate(param1:AbilityVO):void {
        this._updated.dispatch();
        this._abilityUpdated.dispatch();
    }

    private function extractBasicData(param1:XML):void {
        param1.@instanceId && this.setID(param1.@instanceId);
        param1.@type && this.setType(param1.@type);
        param1.@skin && this.setSkin(param1.@skin);
        param1.@name && this.setName(param1.@name);
    }

    private function unlockAbilitiesBasedOnPetRarity(param1:uint):void {
        this._abilityList[0].setUnlocked(true);
        this._abilityList[1].setUnlocked(param1 >= PetRarityEnum.UNCOMMON.ordinal);
        this._abilityList[2].setUnlocked(param1 >= PetRarityEnum.LEGENDARY.ordinal);
    }
}
}
