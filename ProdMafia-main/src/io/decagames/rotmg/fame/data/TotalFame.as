package io.decagames.rotmg.fame.data {
import flash.utils.Dictionary;

import io.decagames.rotmg.fame.data.bonus.FameBonus;

public class TotalFame {


    public function TotalFame(param1:Number) {
        _bonuses = new Vector.<FameBonus>();
        super();
        this._baseFame = param1;
        this._currentFame = param1;
    }

    private var _bonuses:Vector.<FameBonus>;

    public function get bonuses():Dictionary {
        var _loc1_:* = null;
        var _loc3_:Dictionary = new Dictionary();
        var _loc2_:* = this._bonuses;
        var _loc6_:int = 0;
        var _loc5_:* = this._bonuses;
        for each(_loc1_ in this._bonuses) {
            _loc3_[_loc1_.id] = _loc1_;
        }
        return _loc3_;
    }

    private var _baseFame:Number;

    public function get baseFame():int {
        return this._baseFame;
    }

    private var _currentFame:Number;

    public function get currentFame():int {
        return this._currentFame;
    }

    public function addBonus(param1:FameBonus):void {
        if (param1 != null) {
            this._bonuses.push(param1);
            this._currentFame = this._currentFame + param1.fameAdded;
        }
    }
}
}
