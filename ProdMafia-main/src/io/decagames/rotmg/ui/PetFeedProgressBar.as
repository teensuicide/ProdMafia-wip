package io.decagames.rotmg.ui {
import com.greensock.TweenMax;
import com.greensock.easing.Expo;
import com.gskinner.motion.easing.Linear;

import flash.display.Shape;
import flash.text.TextFormat;

import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
import io.decagames.rotmg.ui.gird.UIGridElement;
import io.decagames.rotmg.ui.labels.UILabel;

public class PetFeedProgressBar extends UIGridElement {


    private const MAX_COLOR:Number = 6538829;

    public function PetFeedProgressBar(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int, param7:int, param8:uint, param9:uint, param10:uint = 0) {
        super();
        this._componentWidth = param1;
        this._componentHeight = param2;
        this._abilityName = param3;
        this._maxValue = param4;
        this._currentValue = param5;
        var _loc11_:* = param6;
        this._currentLevel = _loc11_;
        this._previousLevel = _loc11_;
        this._maxLevel = param7;
        this._backgroundColor = param8;
        this._progressBarColor = param9;
        this._simulationColor = param10;
        this.init();
    }
    private var _componentWidth:int;
    private var _componentHeight:int;
    private var _abilityName:String;
    private var _currentValue:int;
    private var _previousLevel:int;
    private var _backgroundColor:uint;
    private var _progressBarColor:uint;
    private var _simulationColor:uint;
    private var _backgroundShape:Shape;
    private var _progressShape:Shape;
    private var _simulationShape:Shape;
    private var _maxShape:Shape;
    private var _useMaxColor:Boolean;
    private var _animateCurrentProgress:Boolean;
    private var _animateLevelProgress:Boolean;

    private var _maxValue:int;

    public function get maxValue():int {
        return this._maxValue;
    }

    public function set maxValue(param1:int):void {
        this._maxValue = param1;
    }

    private var _currentLevel:int;

    public function set currentLevel(param1:int):void {
        this._previousLevel = this._currentLevel;
        this._currentLevel = param1;
    }

    private var _maxLevel:int;

    public function set maxLevel(param1:int):void {
        this._maxLevel = param1;
    }

    private var _abilityLabel:UILabel;

    public function get abilityLabel():UILabel {
        return this._abilityLabel;
    }

    private var _levelLabel:UILabel;

    public function get levelLabel():UILabel {
        return this._levelLabel;
    }

    private var _maxLabel:UILabel;

    public function get maxLabel():UILabel {
        return this._maxLabel;
    }

    private var _simulatedValue:int;

    public function set simulatedValue(param1:int):void {
        this._simulatedValue = param1;
        this.render(this._currentValue, this._simulatedValue);
    }

    private var _showMaxLabel:Boolean;

    public function set showMaxLabel(param1:Boolean):void {
        if (param1 && !this._maxLabel.parent) {
            addChild(this._maxLabel);
        }
        if (!param1 && this._maxLabel.parent) {
            removeChild(this._maxLabel);
        }
        this._showMaxLabel = param1;
    }

    private var _simulatedValueTextFormat:TextFormat;

    public function set simulatedValueTextFormat(param1:TextFormat):void {
        this._simulatedValueTextFormat = param1;
    }

    public function get value():int {
        return this._currentValue;
    }

    public function set value(param1:int):void {
        if (!this._animateLevelProgress) {
            this._animateCurrentProgress = true;
            this.render(this._currentValue, this._currentValue);
            this._currentValue = param1;
            this._simulatedValue = param1;
        }
    }

    public function set maxColor(param1:uint):void {
        this._useMaxColor = true;
    }

    override public function resize(param1:int, param2:int = -1):void {
        this._componentWidth = param1;
        this.render(this._currentValue, this._simulatedValue);
    }

    private function init():void {
        this._abilityLabel = new UILabel();
        addChild(this._abilityLabel);
        this._abilityLabel.text = this._abilityName;
        this._maxLabel = new UILabel();
        this.createBarShapes();
        this.setLevelLabel(this._currentLevel);
    }

    private function createBarShapes():void {
        var _loc1_:int = 0;
        _loc1_ = 16;
        this._backgroundShape = new Shape();
        this._backgroundShape.graphics.clear();
        this._backgroundShape.graphics.beginFill(this._backgroundColor, 1);
        this._backgroundShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
        this._backgroundShape.y = _loc1_;
        addChild(this._backgroundShape);
        this._simulationShape = new Shape();
        this._simulationShape.graphics.beginFill(this._simulationColor, 1);
        this._simulationShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
        this._simulationShape.scaleX = 0;
        this._simulationShape.y = _loc1_;
        this._simulationShape.visible = false;
        addChild(this._simulationShape);
        this._progressShape = new Shape();
        this._progressShape.graphics.beginFill(this._progressBarColor, 1);
        this._progressShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
        this._progressShape.scaleX = 0;
        this._progressShape.y = _loc1_;
        addChild(this._progressShape);
        this._maxShape = new Shape();
        this._maxShape.graphics.beginFill(6538829, 1);
        this._maxShape.graphics.drawRect(0, 0, this._componentWidth, this._componentHeight);
        this._maxShape.scaleX = 0;
        this._maxShape.y = _loc1_;
        this._maxShape.visible = false;
        addChild(this._maxShape);
    }

    private function render(param1:int, param2:int):void {
        var _loc9_:int = 0;
        var _loc11_:int = 0;
        var _loc12_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc7_:Number = NaN;
        this._maxShape.visible = false;
        this._simulationShape.visible = false;
        this._progressShape.visible = true;
        this._animateLevelProgress = this._previousLevel < this._currentLevel;
        var _loc8_:* = param2 > param1;
        var _loc6_:int = this._maxValue - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel);
        var _loc3_:int = param1 - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel);
        var _loc10_:Number = this._currentLevel == this._maxLevel ? 1 : Number(_loc3_ / _loc6_);
        if (this._animateLevelProgress) {
            this.setLevelLabel(this._previousLevel);
            this.animateToCurrentLevel();
        } else {
            this.drawProgress(_loc10_);
        }
        if (_loc8_) {
            if (param2 >= this._maxValue) {
                _loc12_ = AbilitiesUtil.abilityPointsToLevel(param2);
                if (_loc12_ >= this._maxLevel) {
                    _loc12_ = this._maxLevel;
                    this.drawSimulatedProgress(this._componentWidth, 6538829);
                    this.setLevelLabel(_loc12_);
                } else {
                    _loc4_ = AbilitiesUtil.abilityPowerToMinPoints(_loc12_ + 1);
                    _loc5_ = AbilitiesUtil.abilityPowerToMinPoints(_loc12_);
                    _loc11_ = _loc4_ - _loc5_;
                    _loc9_ = param2 - _loc5_;
                    this.drawSimulatedProgress(_loc9_ / _loc11_);
                    this.setLevelLabel(_loc12_);
                }
            } else {
                _loc9_ = param2 - AbilitiesUtil.abilityPowerToMinPoints(this._currentLevel);
                _loc7_ = _loc9_ / _loc6_;
                this.drawSimulatedProgress(_loc7_, _loc10_);
            }
        }
        this._abilityLabel.x = -2;
    }

    private function animateToCurrentLevel():void {
        TweenMax.to(this._progressShape, 0.4, {
            "scaleX": 1,
            "ease": Linear.easeNone,
            "onComplete": this.onLevelUpComplete
        });
    }

    private function onLevelUpComplete():void {
        var _loc1_:* = this._previousLevel + 1;
        this._previousLevel++;
        this.setLevelLabel(_loc1_);
        if (this._previousLevel < this._currentLevel) {
            this._progressShape.scaleX = 0;
            this.animateToCurrentLevel();
        } else {
            this._progressShape.scaleX = 0;
            this._animateCurrentProgress = true;
            this._animateLevelProgress = false;
            this.render(this._currentValue, this._currentValue);
        }
    }

    private function onLevelUpdateComplete():void {
        this._animateCurrentProgress = false;
        this.render(this._currentValue, this._currentValue);
    }

    private function drawProgress(param1:Number):void {
        if (param1 > 1) {
            param1 = 1;
        }
        if (this._animateCurrentProgress) {
            TweenMax.to(this._progressShape, 0.6, {
                "scaleX": param1,
                "ease": Expo.easeOut,
                "onComplete": this.onLevelUpdateComplete
            });
        } else {
            this._progressShape.scaleX = param1;
            this.setLevelLabel(this._currentLevel);
        }
    }

    private function drawSimulatedProgress(param1:Number, param2:Number = 0):void {
        if (param2 == 0) {
            this._progressShape.visible = false;
        }
        this._simulationShape.visible = true;
        this._simulationShape.scaleX = param1;
    }

    private function setLevelLabel(param1:int):void {
        if (this._levelLabel != null) {
            removeChild(this._levelLabel);
        }
        this._levelLabel = new UILabel();
        addChild(this._levelLabel);
        if (param1 > this._currentLevel) {
            DefaultLabelFormat.petStatLabelRight(this._levelLabel, 6538829);
        } else {
            DefaultLabelFormat.petStatLabelRight(this._levelLabel, 16777215);
        }
        if (param1 < this._maxLevel) {
            this._levelLabel.text = param1.toString();
        } else {
            this._levelLabel.text = "MAX";
            this._maxShape.scaleX = 1;
            this._maxShape.visible = true;
            this._simulationShape.visible = false;
            this._progressShape.visible = false;
        }
        this._levelLabel.x = this._componentWidth - this._levelLabel.width + 2;
    }
}
}
