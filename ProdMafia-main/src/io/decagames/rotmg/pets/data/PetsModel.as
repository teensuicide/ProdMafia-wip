package io.decagames.rotmg.pets.data {
import com.company.assembleegameclient.appengine.SavedCharacter;
import com.company.assembleegameclient.map.AbstractMap;
import com.company.assembleegameclient.objects.ObjectLibrary;

import flash.utils.Dictionary;

import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.data.vo.SkinVO;
import io.decagames.rotmg.pets.data.yard.PetYardEnum;
import io.decagames.rotmg.pets.signals.NotifyActivePetUpdated;
import io.decagames.rotmg.seasonalEvent.data.SeasonalEventModel;

import kabam.rotmg.assets.pets;
import kabam.rotmg.core.model.PlayerModel;

public class PetsModel {

    private static var petsDataXML:Class = pets;

    public function PetsModel() {
        hash = {};
        pets = new Vector.<PetVO>();
        skins = new Dictionary();
        familySkins = new Dictionary();
        ownedSkinsIDs = new Vector.<int>();
        super();
    }
    [Inject]
    public var notifyActivePetUpdated:NotifyActivePetUpdated;
    [Inject]
    public var seasonalEventModel:SeasonalEventModel;
    [Inject]
    public var playerModel:PlayerModel;
    private var petsData:XMLList;
    private var hash:Object;
    private var pets:Vector.<PetVO>;
    private var skins:Dictionary;
    private var familySkins:Dictionary;
    private var yardXmlData:XML;
    private var type:int;
    private var activePet:PetVO;
    private var _wardrobePet:PetVO;
    private var ownedSkinsIDs:Vector.<int>;

    private var _totalPetsSkins:int = 0;

    public function get totalPetsSkins():int {
        return this._totalPetsSkins;
    }

    private var _activeUIVO:PetVO;

    public function get activeUIVO():PetVO {
        return this._activeUIVO;
    }

    public function set activeUIVO(param1:PetVO):void {
        this._activeUIVO = param1;
    }

    public function get totalOwnedPetsSkins():int {
        return this.ownedSkinsIDs.length;
    }

    public function destroy():void {
    }

    public function setPetYardType(param1:int):void {
        this.type = param1;
        this.yardXmlData = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(param1));
    }

    public function getPetYardRarity():uint {
        return PetYardEnum.selectByValue(this.yardXmlData.@id).rarity.ordinal;
    }

    public function getPetYardType():int {
        return !this.yardXmlData ? 1 : PetYardEnum.selectByValue(this.yardXmlData.@id).ordinal;
    }

    public function isMapNameYardName(param1:AbstractMap):Boolean {
        return param1.name_ && param1.name_.substr(0, 8) == "Pet Yard";
    }

    public function getPetYardUpgradeFamePrice():int {
        return this.yardXmlData.Fame;
    }

    public function getPetYardUpgradeGoldPrice():int {
        return this.yardXmlData.Price;
    }

    public function getPetYardObjectID():int {
        return this.type;
    }

    public function deletePet(param1:int):void {
        var _loc2_:int = this.getPetIndex(param1);
        if (_loc2_ >= 0) {
            this.pets.splice(this.getPetIndex(param1), 1);
            if (this._activeUIVO && this._activeUIVO.getID() == param1) {
                this._activeUIVO = null;
            }
            if (this.activePet && this.activePet.getID() == param1) {
                this.removeActivePet();
            }
        }
    }

    public function clearPets():void {
        this.hash = {};
        this.pets = new Vector.<PetVO>();
        this.petsData = null;
        this.skins = new Dictionary();
        this.familySkins = new Dictionary();
        this._totalPetsSkins = 0;
        this.ownedSkinsIDs = new Vector.<int>();
        this.removeActivePet();
    }

    public function parsePetsData():void {
        var _loc4_:* = 0;
        var _loc1_:int = 0;
        var _loc3_:* = null;
        var _loc2_:* = null;
        if (this.petsData == null) {
            this.petsData = XML(new petsDataXML()).Object;
            _loc4_ = uint(this.petsData.length());
            _loc1_ = 0;
            while (_loc1_ < _loc4_) {
                _loc3_ = this.petsData[_loc1_];
                if (_loc3_.hasOwnProperty("PetSkin")) {
                    if (_loc3_.@type != "0x8090") {
                        _loc2_ = SkinVO.parseFromXML(_loc3_);
                        _loc2_.isOwned = this.ownedSkinsIDs.indexOf(_loc2_.skinType) >= 0;
                        this.skins[_loc2_.skinType] = _loc2_;
                        this._totalPetsSkins++;
                        if (!this.familySkins[_loc2_.family]) {
                            this.familySkins[_loc2_.family] = new Vector.<SkinVO>();
                        }
                        this.familySkins[_loc2_.family].push(_loc2_);
                    }
                }
                _loc1_++;
            }
        }
    }

    public function unlockSkin(param1:int):void {
        this.skins[param1].isNew = true;
        this.skins[param1].isOwned = true;
        if (this.ownedSkinsIDs.indexOf(param1) == -1) {
            this.ownedSkinsIDs.push(param1);
        }
    }

    public function getSkinVOById(param1:int):SkinVO {
        return this.skins[param1];
    }

    public function hasSkin(param1:int):Boolean {
        return this.ownedSkinsIDs.indexOf(param1) != -1;
    }

    public function parseOwnedSkins(param1:XML):void {
        if (param1.toString() != "") {
            this.ownedSkinsIDs = Vector.<int>(param1.toString().split(","));
        }
    }

    public function getPetVO(param1:int):PetVO {
        var _loc2_:* = null;
        if (this.hash[param1] != null) {
            return this.hash[param1];
        }
        _loc2_ = new PetVO(param1);
        this.pets.push(_loc2_);
        this.hash[param1] = _loc2_;
        return _loc2_;
    }

    public function getPetsSkinsFromFamily(param1:String):Vector.<SkinVO> {
        return this.familySkins[param1];
    }

    public function getCachedVOOnly(param1:int):PetVO {
        return this.hash[param1];
    }

    public function getAllPets(param1:String = "", param2:PetRarityEnum = null):Vector.<PetVO> {
        _arg_1 = param1;
        _arg_2 = param2;
        var _arg_1:String = _arg_1;
        var _arg_2:PetRarityEnum = _arg_2;
        var param1:String = _arg_1;
        var param2:PetRarityEnum = _arg_2;
        var family:String = param1;
        var rarity:PetRarityEnum = param2;
        var petsList:Vector.<PetVO> = this.pets;
        if (family != "") {
            petsList = petsList.filter(function (param1:PetVO, param2:int, param3:Vector.<PetVO>):Boolean {
                return param1.family == family;
            });
        }
        if (rarity != null) {
            petsList = petsList.filter(function (param1:PetVO, param2:int, param3:Vector.<PetVO>):Boolean {
                return param1.rarity == rarity;
            });
        }
        return petsList;
    }

    public function addPet(param1:PetVO):void {
        this.pets.push(param1);
    }

    public function setActivePet(param1:PetVO):void {
        this.activePet = param1;
        var _loc2_:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
        if (_loc2_) {
            _loc2_.setPetVO(this.activePet);
        }
        this.notifyActivePetUpdated.dispatch();
    }

    public function getActivePet():PetVO {
        return this.activePet;
    }

    public function removeActivePet():void {
        if (this.activePet == null) {
            return;
        }
        var _loc1_:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
        if (_loc1_) {
            _loc1_.setPetVO(null);
        }
        this.activePet = null;
        this.notifyActivePetUpdated.dispatch();
    }

    public function getPet(param1:int):PetVO {
        var _loc2_:int = this.getPetIndex(param1);
        if (_loc2_ == -1) {
            return null;
        }
        return this.pets[_loc2_];
    }

    private function petNodeIsSkin(param1:XML):Boolean {
        return param1.hasOwnProperty("PetSkin");
    }

    private function getPetIndex(param1:int):int {
        var _loc2_:* = null;
        var _loc3_:int = 0;
        while (_loc3_ < this.pets.length) {
            _loc2_ = this.pets[_loc3_];
            if (_loc2_.getID() == param1) {
                return _loc3_;
            }
            _loc3_++;
        }
        return -1;
    }

    private function selectPetInWardrobe(param1:PetVO):void {
        this._wardrobePet = param1;
    }
}
}
