package io.decagames.rotmg.fame.data.bonus {
public class FameBonus {


    public function FameBonus(param1:int, param2:int, param3:int, param4:int, param5:String, param6:String) {
        super();
        this._added = param2;
        this._numAdded = param3;
        this._level = param4;
        this._id = param1;
        this._name = param5;
        this._tooltip = param6;
    }

    private var _added:int;

    public function get added():int {
        return this._added;
    }

    private var _numAdded:int;

    public function get numAdded():int {
        return this._numAdded;
    }

    private var _level:int;

    public function get level():int {
        return this._level;
    }

    private var _fameAdded:int;

    public function get fameAdded():int {
        return this._fameAdded;
    }

    public function set fameAdded(param1:int):void {
        this._fameAdded = param1;
    }

    private var _id:int;

    public function get id():int {
        return this._id;
    }

    private var _name:String;

    public function get name():String {
        return this._name;
    }

    private var _tooltip:String;

    public function get tooltip():String {
        return this._tooltip;
    }
}
}
