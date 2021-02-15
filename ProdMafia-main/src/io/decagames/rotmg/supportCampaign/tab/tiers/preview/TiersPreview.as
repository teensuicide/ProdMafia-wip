package io.decagames.rotmg.supportCampaign.tab.tiers.preview {
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class TiersPreview extends Sprite {
       
      
      private var background:DisplayObject;
      
      private var supportIcon:SliceScalingBitmap;
      
      private var donateButtonBackground:SliceScalingBitmap;
      
      private var _componentWidth:int;
      
      private var requiredPointsContainer:Sprite;
      
      private var _ranks:Array;
      
      private var selectTween:TimelineMax;
      
      private var _tier:int;
      
      private var _currentRank:int;
      
      private var _claimed:int;
      
      private var _leftArrow:SliceScalingButton;
      
      private var _rightArrow:SliceScalingButton;
      
      private var _startTier:int;
      
      private var _claimButton:SliceScalingButton;
      
      public function TiersPreview(param1:Array, param2:int) {
         super();
         this._ranks = param1;
         this._componentWidth = param2;
         this.init();
      }
      
      public function get leftArrow() : SliceScalingButton {
         return this._leftArrow;
      }
      
      public function get rightArrow() : SliceScalingButton {
         return this._rightArrow;
      }
      
      public function get startTier() : int {
         return this._currentRank;
      }
      
      public function get claimButton() : SliceScalingButton {
         return this._claimButton;
      }
      
      public function showTier(param1:int, param2:int, param3:int, param4:DisplayObject) : void {
         this._tier = param1;
         this._currentRank = param2;
         this._claimed = param3;
         if(this.background && this.background.parent) {
            removeChild(this.background);
         }
         this.background = param4;
         addChildAt(this.background,0);
         this.renderButtons(this._tier,this._currentRank,this._claimed);
      }
      
      public function selectAnimation() : void {
         if(!this.selectTween) {
            this.selectTween = new TimelineMax();
            this.selectTween.add(TweenMax.to(this,0.05,{"tint":16777215}));
            this.selectTween.add(TweenMax.to(this,0.3,{
               "tint":null,
               "ease":Expo.easeOut
            }));
         } else {
            this.selectTween.play(0);
         }
      }
      
      private function init() : void {
         this.createClaimButton();
         this.createArrows();
      }
      
      private function createClaimButton() : void {
         this._claimButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this._claimButton.setLabel("Claim",DefaultLabelFormat.defaultButtonLabel);
      }
      
      private function createArrows() : void {
         this._rightArrow = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","tier_arrow"));
         addChild(this._rightArrow);
         this._rightArrow.x = 533;
         this._rightArrow.y = 103;
         this._leftArrow = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","tier_arrow"));
         this._leftArrow.rotation = 180;
         this._leftArrow.x = -3;
         this._leftArrow.y = 133;
         addChild(this._leftArrow);
      }
      
      private function renderButtons(param1:int, param2:int, param3:int) : void {
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(this.donateButtonBackground && this.donateButtonBackground.parent) {
            removeChild(this.donateButtonBackground);
         }
         if(this._claimButton && this._claimButton.parent) {
            removeChild(this._claimButton);
         }
         if(this.requiredPointsContainer && this.requiredPointsContainer.parent) {
            removeChild(this.requiredPointsContainer);
         }
         if(param1 > param3 && param1 != this._ranks.length + 1) {
            this.donateButtonBackground = TextureParser.instance.getSliceScalingBitmap("UI","main_button_decoration_dark",160);
            this.donateButtonBackground.x = Math.round((this._componentWidth - this.donateButtonBackground.width) / 2);
            this.donateButtonBackground.y = 178;
            addChild(this.donateButtonBackground);
            if(param2 >= param1) {
               this._claimButton.width = this.donateButtonBackground.width - 48;
               this._claimButton.y = this.donateButtonBackground.y + 6;
               this._claimButton.x = this.donateButtonBackground.x + 24;
               addChild(this._claimButton);
            } else {
               this.requiredPointsContainer = new Sprite();
               _loc5_ = new UILabel();
               DefaultLabelFormat.createLabelFormat(_loc5_,22,15585539,"center",true);
               this.requiredPointsContainer.addChild(_loc5_);
               this.supportIcon = TextureParser.instance.getSliceScalingBitmap("UI","campaign_Points");
               this.requiredPointsContainer.addChild(this.supportIcon);
               _loc5_.text = this._ranks[param1 - 1].toString();
               _loc5_.x = this.donateButtonBackground.x + Math.round((this.donateButtonBackground.width - _loc5_.width) / 2) - 10;
               _loc5_.y = this.donateButtonBackground.y + 13;
               this.supportIcon.y = _loc5_.y + 3;
               this.supportIcon.x = _loc5_.x + _loc5_.width;
               addChild(this.requiredPointsContainer);
            }
         } else if(param3) {
            this.requiredPointsContainer = new Sprite();
            _loc4_ = new UILabel();
            DefaultLabelFormat.createLabelFormat(_loc4_,22,4958208,"center",true);
            this.requiredPointsContainer.addChild(_loc4_);
            _loc4_.text = "Claimed";
            _loc4_.x = Math.round((this._componentWidth - _loc4_.width) / 2);
            _loc4_.y = 190;
            addChild(this.requiredPointsContainer);
         }
      }
   }
}
