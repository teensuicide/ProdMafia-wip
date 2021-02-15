package com.company.assembleegameclient.objects {
import com.company.assembleegameclient.game.GameSprite;
import com.company.assembleegameclient.map.Camera;
import com.company.assembleegameclient.map.Map;
import com.company.assembleegameclient.parameters.Parameters;
import com.company.assembleegameclient.ui.panels.Panel;
import com.company.assembleegameclient.ui.tooltip.TextToolTip;
import com.company.assembleegameclient.ui.tooltip.ToolTip;
import com.company.assembleegameclient.util.AnimatedChar;
import com.company.assembleegameclient.util.AnimatedChars;

import flash.display.GraphicsBitmapFill;

import io.decagames.rotmg.pets.data.PetsModel;
import io.decagames.rotmg.pets.data.vo.PetVO;
import io.decagames.rotmg.pets.panels.PetPanel;

import kabam.rotmg.core.StaticInjectorContext;
import kabam.rotmg.game.signals.TextPanelMessageUpdateSignal;

public class Pet extends GameObject implements IInteractiveObject {


    public function Pet(_arg_1:XML) {
        super(_arg_1);
        isInteractive_ = true;
        this.textPanelUpdateSignal = StaticInjectorContext.getInjector().getInstance(TextPanelMessageUpdateSignal);
        this.petsModel = StaticInjectorContext.getInjector().getInstance(PetsModel);
        this.petsModel.getActivePet();
    }
    public var vo:PetVO;
    public var skin:AnimatedChar;
    public var defaultSkin:AnimatedChar;
    public var skinId:int;
    public var isDefaultAnimatedChar:Boolean = false;
    public var customSkin:Boolean = false;
    public var customSize:Boolean = false;
    private var textPanelUpdateSignal:TextPanelMessageUpdateSignal;
    private var petsModel:PetsModel;

    override public function addTo(_arg_1:Map, _arg_2:Number, _arg_3:Number):Boolean {
        if (!super.addTo(_arg_1, _arg_2, _arg_3)) {
            return false;
        }
        var _local4:GameObject = this.map_.goDict_[this.objectId_ - 1];
        if (_local4 && _local4 == this.map_.player_) {
            myPet = true;
        }
        return true;
    }

    override public function draw(_arg_1:Vector.<GraphicsBitmapFill>, _arg_2:Camera, _arg_3:int):void {
        if (Parameters.data.hidePets2 == 1
                || myPet && Parameters.data.hidePets2 == 2
                || map_.isPetYard && !Parameters.lowCPUMode)
            super.draw(_arg_1, _arg_2, _arg_3);
    }

    public function getTooltip():ToolTip {
        return new TextToolTip(0x363636, 0x9b9b9b, "ClosedGiftChest.title", "TextPanel.giftChestIsEmpty", 200);
    }

    public function getPanel(_arg_1:GameSprite):Panel {
        return new PetPanel(_arg_1, this.vo);
    }

    public function setSkin(_arg_1:int, _arg_2:Boolean = false):void {
        var _local7:* = null;
        this.skinId = _arg_1;
        var _local6:XML = ObjectLibrary.getXMLfromId(ObjectLibrary.getIdFromType(_arg_1));
        var _local5:String = _local6.AnimatedTexture.File;
        var _local3:int = _local6.AnimatedTexture.Index;
        if (this.skin == null || _arg_2) {
            this.isDefaultAnimatedChar = true;
            this.skin = AnimatedChars.getAnimatedChar(_local5, _local3);
            this.defaultSkin = this.skin;
        } else {
            this.skin = AnimatedChars.getAnimatedChar(_local5, _local3);
        }
        this.isDefaultAnimatedChar = this.skin == this.defaultSkin;
        _local7 = this.skin.imageFromAngle(0, 0, 0);
        animatedChar_ = this.skin;
        texture = _local7.image_;
        mask_ = _local7.mask_;
        var _local4:ObjectProperties = ObjectLibrary.getPropsFromId(_local6.DisplayId);
        if (_local4) {
            props_.flying_ = _local4.flying_;
            props_.whileMoving_ = _local4.whileMoving_;
            flying = props_.flying_;
            z_ = props_.z_;
        }
    }

    public function setDefaultSkin():void {
        var _local1:* = null;
        this.skinId = -1;
        if (this.defaultSkin == null) {
            return;
        }
        _local1 = this.defaultSkin.imageFromAngle(0, 0, 0);
        this.isDefaultAnimatedChar = true;
        animatedChar_ = this.defaultSkin;
        texture = _local1.image_;
        mask_ = _local1.mask_;
    }
}
}
