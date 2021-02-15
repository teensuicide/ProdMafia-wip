package io.decagames.rotmg.pets.data.vo {
import com.company.assembleegameclient.util.MaskedImage;

import flash.display.Bitmap;

import io.decagames.rotmg.pets.data.rarity.PetRarityEnum;

import org.osflash.signals.Signal;

public interface IPetVO {


    function get updated():Signal;

    function get name():String;

    function get rarity():PetRarityEnum;

    function get family():String;

    function get abilityList():Array;

    function get isOwned():Boolean;

    function get skinType():int;

    function get maxAbilityPower():int;

    function get isNew():Boolean;

    function set isNew(param1:Boolean):void;

    function getSkinBitmap():Bitmap;

    function getID():int;

    function getType():int;

    function getSkinMaskedImage():MaskedImage;
}
}
