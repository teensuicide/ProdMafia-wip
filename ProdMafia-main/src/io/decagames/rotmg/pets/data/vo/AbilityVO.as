package io.decagames.rotmg.pets.data.vo {
import com.company.assembleegameclient.objects.ObjectLibrary;

import org.osflash.signals.Signal;

public class AbilityVO {


    public const updated:Signal = new Signal(AbilityVO);

    public function AbilityVO() {
        super();
    }
    public var level:int;
    public var points:int;
    public var name:String;
    public var description:String;
    private var _staticData:XML;
    private var unlocked:Boolean;

    private var _type:uint;

    public function set type(param1:uint):void {
        this._type = param1;
        this._staticData = ObjectLibrary.getPetDataXMLByType(this._type);
        this.name = this._staticData.DisplayId == undefined ? this._staticData.@id : this._staticData.DisplayId;
        this.description = this._staticData.Description;
    }

    public function setUnlocked(param1:Boolean):void {
        this.unlocked = param1;
    }

    public function getUnlocked():Boolean {
        return this.unlocked;
    }

    public function clone():AbilityVO {
        var _loc1_:AbilityVO = new AbilityVO();
        _loc1_.type = this._type;
        _loc1_.level = this.level;
        _loc1_.points = this.points;
        _loc1_.setUnlocked(this.getUnlocked());
        return _loc1_;
    }

    public function toString():String {
        return "[AbilityVO] Name: " + this.name + ", level:" + this.level + ", unlocked? " + (!this.getUnlocked() ? "no" : "yes");
    }
}
}
