package io.decagames.rotmg.supportCampaign.tab.tiers.progressBar {
   import flash.display.Sprite;
   import io.decagames.rotmg.supportCampaign.data.vo.RankVO;
   import io.decagames.rotmg.supportCampaign.tab.tiers.button.TierButton;
   import io.decagames.rotmg.ui.ProgressBar;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class TiersProgressBar extends Sprite {
       
      
      private var _ranks:Vector.<RankVO>;
      
      private var _componentWidth:int;
      
      private var _currentRank:int;
      
      private var _claimed:int;
      
      private var buttonAreReady:Boolean;
      
      private var _buttons:Vector.<TierButton>;
      
      private var _progressBar:ProgressBar;
      
      private var _points:int;
      
      private var supportIcon:SliceScalingBitmap;
      
      public function TiersProgressBar(param1:Vector.<RankVO>, param2:int) {
         super();
         this._ranks = param1;
         this._componentWidth = param2;
         this._buttons = new Vector.<TierButton>();
         this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI","campaign_Points");
      }
      
      public function show(param1:int, param2:int, param3:int) : void {
         this._currentRank = param2;
         this._claimed = param3;
         this._points = param1;
         if(!this.buttonAreReady) {
            this.renderProgressBar();
            this.renderButtons();
         }
         this.updateProgressBar();
         this.updateButtons();
      }
      
      private function getStatusByTier(param1:int) : int {
         if(this._claimed >= param1) {
            return 2;
         }
         if(this._currentRank >= param1) {
            return 1;
         }
         return 0;
      }
      
      private function updateButtons() : void {
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc1_:* = null;
         var _loc3_:Boolean = false;
         var _loc2_:* = this._buttons;
         var _loc8_:int = 0;
         var _loc7_:* = this._buttons;
         for each(_loc1_ in this._buttons) {
            _loc1_.updateStatus(this.getStatusByTier(_loc1_.tier));
            if(!_loc3_ && this.getStatusByTier(_loc1_.tier) == 1) {
               _loc3_ = true;
               _loc1_.selected = true;
            } else {
               _loc1_.selected = false;
            }
         }
         if(!_loc3_) {
            if(this._currentRank != 0) {
               _loc4_ = 0;
               _loc6_ = this._buttons;
               var _loc10_:int = 0;
               var _loc9_:* = this._buttons;
               for each(_loc1_ in this._buttons) {
                  if(this._currentRank == _loc1_.tier) {
                     _loc3_ = true;
                     _loc1_.selected = true;
                  }
               }
            }
         }
         if(!_loc3_) {
            this._buttons[0].selected = true;
         }
      }
      
      private function updateProgressBar() : void {
         var _loc1_:int = this._points;
         if(this._progressBar.value != _loc1_) {
            if(_loc1_ > this._progressBar.maxValue - this._progressBar.minValue) {
               this._progressBar.value = this._progressBar.maxValue - this._progressBar.minValue;
            } else {
               this._progressBar.value = _loc1_;
            }
         }
      }
      
      private function renderProgressBar() : void {
         this._progressBar = new ProgressBar(this._componentWidth,4,"","",0,this._ranks[this._ranks.length - 1].points,0,5526612,1029573);
         this._progressBar.y = 7;
         this._progressBar.shouldAnimate = false;
         addChild(this._progressBar);
         this.supportIcon.x = -4;
         this.supportIcon.y = 5;
         addChild(this.supportIcon);
      }
      
      private function renderButtons() : void {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:* = null;
         var _loc8_:* = null;
         var _loc7_:int = 1;
         var _loc6_:* = this._ranks;
         var _loc12_:int = 0;
         var _loc11_:* = this._ranks;
         for each(_loc1_ in this._ranks) {
            _loc9_ = new TierButton(_loc7_,this.getStatusByTier(_loc7_));
            this._buttons.push(_loc9_);
            _loc7_++;
         }
         _loc4_ = this._buttons.length;
         _loc3_ = this._componentWidth / _loc4_;
         _loc5_ = 1;
         _loc10_ = _loc4_ - 1;
         while(_loc10_ >= 0) {
            _loc8_ = this._buttons[_loc10_];
            _loc8_.x = this._componentWidth - _loc5_ * _loc3_;
            addChild(_loc8_);
            _loc5_++;
            _loc10_--;
         }
         this.buttonAreReady = true;
      }
   }
}
