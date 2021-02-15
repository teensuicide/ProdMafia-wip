package io.decagames.rotmg.fame.data {
import com.company.assembleegameclient.appengine.SavedCharacter;

import io.decagames.rotmg.characterMetrics.tracker.CharactersMetricsTracker;
import io.decagames.rotmg.fame.data.bonus.FameBonus;
import io.decagames.rotmg.fame.data.bonus.FameBonusConfig;

import kabam.rotmg.core.model.PlayerModel;
import kabam.rotmg.ui.model.HUDModel;

public class FameTracker {


    public function FameTracker() {
        super();
    }
    [Inject]
    public var metrics:CharactersMetricsTracker;
    [Inject]
    public var hudModel:HUDModel;
    [Inject]
    public var player:PlayerModel;

    public function getCurrentTotalFame(param1:int):TotalFame {
        var _loc2_:TotalFame = new TotalFame(this.currentFame(param1));
        var _loc5_:int = this.getCharacterLevel(param1);
        var _loc3_:int = this.getCharacterType(param1);
        if (this.player.getTotalFame() == 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 20, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 5) == 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 1, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 1) == 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 2, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 2) == 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 3, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 4) == 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 4, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 13) > 0 && this.metrics.getCharacterStat(param1, 14) > 0 && this.metrics.getCharacterStat(param1, 15) > 0 && this.metrics.getCharacterStat(param1, 16) > 0 && this.metrics.getCharacterStat(param1, 17) > 0 && this.metrics.getCharacterStat(param1, 18) > 0 && this.metrics.getCharacterStat(param1, 21) > 0 && this.metrics.getCharacterStat(param1, 22) > 0 && this.metrics.getCharacterStat(param1, 23) > 0 && this.metrics.getCharacterStat(param1, 24) > 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 5, _loc2_.currentFame));
        }
        var _loc4_:int = this.metrics.getCharacterStat(param1, 6);
        var _loc8_:int = this.metrics.getCharacterStat(param1, 8);
        if (_loc4_ + _loc8_ > 0) {
            if (_loc8_ / (_loc4_ + _loc8_) > 0.1) {
                _loc2_.addBonus(this.getFameBonus(param1, 6, _loc2_.currentFame));
            }
            if (_loc8_ / (_loc4_ + _loc8_) > 0.5) {
                _loc2_.addBonus(this.getFameBonus(param1, 7, _loc2_.currentFame));
            }
        }
        if (this.metrics.getCharacterStat(param1, 11) > 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 8, _loc2_.currentFame));
        }
        var _loc7_:int = this.metrics.getCharacterStat(param1, 0);
        var _loc6_:int = this.metrics.getCharacterStat(param1, 1);
        if (_loc6_ > 0 && _loc7_ > 0) {
            if (_loc6_ / _loc7_ > 0.25) {
                _loc2_.addBonus(this.getFameBonus(param1, 9, _loc2_.currentFame));
            }
            if (_loc6_ / _loc7_ > 0.5) {
                _loc2_.addBonus(this.getFameBonus(param1, 10, _loc2_.currentFame));
            }
            if (_loc6_ / _loc7_ > 0.75) {
                _loc2_.addBonus(this.getFameBonus(param1, 11, _loc2_.currentFame));
            }
        }
        if (this.metrics.getCharacterStat(param1, 3) > 1000000) {
            _loc2_.addBonus(this.getFameBonus(param1, 12, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 3) > 4000000) {
            _loc2_.addBonus(this.getFameBonus(param1, 13, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 10) == 0) {
            _loc2_.addBonus(this.getFameBonus(param1, 14, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 19) > 100) {
            _loc2_.addBonus(this.getFameBonus(param1, 18, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 19) > 1000) {
            _loc2_.addBonus(this.getFameBonus(param1, 19, _loc2_.currentFame));
        }
        if (this.metrics.getCharacterStat(param1, 12) > 1000) {
            _loc2_.addBonus(this.getFameBonus(param1, 21, _loc2_.currentFame));
        }
        _loc2_.addBonus(this.getWellEquippedBonus(this.getCharacterFameBonus(param1), _loc2_.currentFame));
        if (_loc2_.currentFame > this.player.getBestCharFame()) {
            _loc2_.addBonus(this.getFameBonus(param1, 16, _loc2_.currentFame));
        }
        return _loc2_;
    }

    public function currentFame(param1:int):int {
        var _loc3_:int = this.metrics.getCharacterStat(param1, 20);
        var _loc4_:int = this.getCharacterExp(param1);
        var _loc2_:int = this.getCharacterLevel(param1);
        if (this.hasMapPlayer()) {
            _loc4_ = _loc4_ + (_loc2_ - 1) * (_loc2_ - 1) * 50;
        }
        return this.calculateBaseFame(_loc4_, _loc3_);
    }

    public function calculateBaseFame(param1:int, param2:int):int {
        var _loc3_:* = 0;
        _loc3_ = _loc3_ + Math.max(0, Math.min(20000, param1)) * 0.001;
        _loc3_ = _loc3_ + Math.max(0, Math.min(45200, param1) - 20000) * 0.002;
        _loc3_ = _loc3_ + Math.max(0, Math.min(80000, param1) - 45200) * 0.003;
        _loc3_ = _loc3_ + Math.max(0, Math.min(101200, param1) - 80000) * 0.002;
        _loc3_ = _loc3_ + Math.max(0, param1 - 101200) * 0.0005;
        _loc3_ = _loc3_ + Math.min(Math.floor(param2 / 6), 30);
        return Math.floor(_loc3_);
    }

    private function getFameBonus(param1:int, param2:int, param3:int):FameBonus {
        var _loc5_:FameBonus = FameBonusConfig.getBonus(param2);
        var _loc4_:int = this.getCharacterLevel(param1);
        if (_loc4_ < _loc5_.level) {
            return null;
        }
        _loc5_.fameAdded = Math.floor(_loc5_.added * param3 / 100 + _loc5_.numAdded);
        return _loc5_;
    }

    private function getWellEquippedBonus(param1:Number, param2:int):FameBonus {
        var _loc3_:FameBonus = FameBonusConfig.getBonus(22);
        _loc3_.fameAdded = Math.floor(param1 * param2);
        return _loc3_;
    }

    private function hasMapPlayer():Boolean {
        return this.hudModel.gameSprite && this.hudModel.gameSprite.map && this.hudModel.gameSprite.map.player_;
    }

    private function getSavedCharacter(param1:int):SavedCharacter {
        return this.player.getCharacterById(param1);
    }

    private function getCharacterExp(param1:int):int {
        if (this.hasMapPlayer()) {
            return this.hudModel.gameSprite.map.player_.exp_;
        }
        return this.getSavedCharacter(param1).xp();
    }

    private function getCharacterLevel(param1:int):int {
        if (this.hasMapPlayer()) {
            return this.hudModel.gameSprite.map.player_.level_;
        }
        return this.getSavedCharacter(param1).level();
    }

    private function getCharacterType(param1:int):int {
        if (this.hasMapPlayer()) {
            return this.hudModel.gameSprite.map.player_.objectType_;
        }
        return this.getSavedCharacter(param1).objectType();
    }

    private function getCharacterFameBonus(param1:int):Number {
        if (this.hasMapPlayer()) {
            return this.hudModel.gameSprite.map.player_.getFameBonus();
        }
        return this.getSavedCharacter(param1).fameBonus();
    }
}
}
