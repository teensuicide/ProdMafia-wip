package io.decagames.rotmg.pets.components.petStatsGrid {
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
   import io.decagames.rotmg.pets.data.vo.AbilityVO;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.ui.PetFeedProgressBar;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.labels.UILabel;
   
   public class PetFeedStatsGrid extends UIGrid {
       
      
      private var abilityBars:Vector.<PetFeedProgressBar>;
      
      private var _labelContainer:Sprite;
      
      private var _plusLabels:Vector.<UILabel>;
      
      private var _currentLevels:Vector.<int>;
      
      private var _maxLevel:int;
      
      private var _petVO:IPetVO;
      
      public function PetFeedStatsGrid(param1:int, param2:IPetVO) {
         super(param1,1,3);
         this._petVO = param2;
         this.init();
      }
      
      public function get petVO() : IPetVO {
         return this._petVO;
      }
      
      public function renderSimulation(param1:Array) : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = param1;
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(_loc3_ in param1) {
            this.renderAbilitySimulation(_loc3_,_loc2_);
            _loc2_++;
         }
      }
      
      public function updateVO(param1:IPetVO) : void {
         if(this._petVO != param1) {
            this.abilityBars.length = 0;
            this._labelContainer.visible = false;
            clearGrid();
         }
         this._petVO = param1;
         if(this._petVO != null) {
            this.refreshAbilities(param1);
         }
      }
      
      private function init() : void {
         this.abilityBars = new Vector.<PetFeedProgressBar>();
         this._currentLevels = new Vector.<int>(0);
         this._labelContainer = new Sprite();
         this._labelContainer.x = -2;
         this._labelContainer.y = -13;
         this._labelContainer.visible = false;
         addChild(this._labelContainer);
         this.createLabels();
         this.createPlusLabels();
         if(this._petVO) {
            this._maxLevel = this._petVO.maxAbilityPower;
            this.refreshAbilities(this._petVO);
         }
      }
      
      private function createPlusLabels() : void {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         this._plusLabels = new Vector.<UILabel>(0);
         _loc2_ = 0;
         while(_loc2_ < 3) {
            _loc1_ = new UILabel();
            DefaultLabelFormat.petStatLabelRight(_loc1_,6538829);
            _loc1_.x = 203;
            _loc1_.y = _loc2_ * 23;
            _loc1_.visible = false;
            addChild(_loc1_);
            this._plusLabels.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function createLabels() : void {
         var _loc1_:* = null;
         var _loc2_:UILabel = new UILabel();
         DefaultLabelFormat.petStatLabelLeftSmall(_loc2_,10658466);
         _loc2_.text = "Ability";
         _loc2_.y = -3;
         this._labelContainer.addChild(_loc2_);
         _loc1_ = new UILabel();
         DefaultLabelFormat.petStatLabelRightSmall(_loc1_,10658466);
         _loc1_.text = "Level";
         _loc1_.x = 195 - _loc1_.width + 4;
         _loc1_.y = -3;
         this._labelContainer.addChild(_loc1_);
      }
      
      private function refreshAbilities(param1:IPetVO) : void {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         this._currentLevels.length = 0;
         this._maxLevel = this._petVO.maxAbilityPower;
         this._labelContainer.visible = true;
         _loc2_ = 0;
         var _loc4_:* = param1.abilityList;
         var _loc7_:int = 0;
         var _loc6_:* = param1.abilityList;
         for each(_loc3_ in param1.abilityList) {
            this._currentLevels.push(_loc3_.level);
            this._plusLabels[_loc2_].text = "";
            this._plusLabels[_loc2_].visible = false;
            this.renderAbility(_loc3_,_loc2_);
            _loc2_++;
         }
      }
      
      private function renderAbilitySimulation(param1:AbilityVO, param2:int) : void {
         var _loc3_:* = null;
         if(param1.getUnlocked()) {
            _loc3_ = this.abilityBars[param2];
            _loc3_.maxLevel = this._maxLevel;
            _loc3_.simulatedValue = param1.points;
            if(param1.level - this._currentLevels[param2] > 0) {
               this._plusLabels[param2].text = "+" + (param1.level - this._currentLevels[param2]);
               this._plusLabels[param2].visible = true;
            } else {
               this._plusLabels[param2].visible = false;
            }
         }
      }
      
      private function renderAbility(param1:AbilityVO, param2:int) : void {
         var _loc4_:* = null;
         var _loc3_:int = AbilitiesUtil.abilityPowerToMinPoints(param1.level + 1);
         if(this.abilityBars.length > param2) {
            _loc4_ = this.abilityBars[param2];
            if(param1.getUnlocked()) {
               if(_loc4_.maxValue != _loc3_ || _loc4_.value != param1.points) {
                  this.updateProgressBarValues(_loc4_,param1,_loc3_);
               }
            }
         } else {
            _loc4_ = new PetFeedProgressBar(195,4,param1.name,_loc3_,!param1.getUnlocked()?0:param1.points,param1.level,this._maxLevel,5526612,15306295,6538829);
            _loc4_.showMaxLabel = true;
            _loc4_.maxColor = 6538829;
            DefaultLabelFormat.petStatLabelLeft(_loc4_.abilityLabel,16777215);
            DefaultLabelFormat.petStatLabelRight(_loc4_.levelLabel,16777215);
            DefaultLabelFormat.petStatLabelRight(_loc4_.maxLabel,6538829,true);
            _loc4_.simulatedValueTextFormat = DefaultLabelFormat.createTextFormat(12,6538829,"right",true);
            this.abilityBars.push(_loc4_);
            addGridElement(_loc4_);
         }
         if(!param1.getUnlocked()) {
            _loc4_.alpha = 0.4;
         } else {
            if(_loc4_.alpha != 1) {
               _loc4_.maxValue = _loc3_;
               _loc4_.value = param1.points;
            }
            _loc4_.alpha = 1;
         }
      }
      
      private function updateProgressBarValues(param1:PetFeedProgressBar, param2:AbilityVO, param3:int) : void {
         param1.maxLevel = this._maxLevel;
         param1.currentLevel = param2.level;
         param1.maxValue = param3;
         param1.value = param2.points;
      }
   }
}
