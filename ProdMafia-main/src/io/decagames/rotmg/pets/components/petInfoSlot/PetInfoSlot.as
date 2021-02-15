package io.decagames.rotmg.pets.components.petInfoSlot {
   import flash.display.Sprite;
   import io.decagames.rotmg.pets.components.petPortrait.PetPortrait;
   import io.decagames.rotmg.pets.components.petStatsGrid.PetFeedStatsGrid;
   import io.decagames.rotmg.pets.components.petStatsGrid.PetStatsGrid;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.ui.gird.UIGrid;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class PetInfoSlot extends Sprite {
      
      public static const INFO_HEIGHT:int = 207;
      
      public static const STATS_WIDTH:int = 150;
      
      public static const FEED_STATS_WIDTH:int = 195;
       
      
      private var petPortrait:PetPortrait;
      
      private var _switchable:Boolean;
      
      private var showStats:Boolean;
      
      private var animations:Boolean;
      
      private var isRarityLabelHidden:Boolean;
      
      private var showReleaseButton:Boolean;
      
      private var _useFeedStats:Boolean;
      
      private var _showFeedPower:Boolean;
      
      private var statsGrid:UIGrid;
      
      private var _slotWidth:int;
      
      private var _showCurrentPet:Boolean;
      
      private var _petVO:IPetVO;
      
      public function PetInfoSlot(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false) {
         super();
         this._switchable = param2;
         this._slotWidth = param1;
         this._showFeedPower = param8;
         this._showCurrentPet = param4;
         this.showStats = param3;
         this.animations = param5;
         this.showReleaseButton = param7;
         this.isRarityLabelHidden = param6;
         this._useFeedStats = param9;
         var _loc10_:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",param1);
         addChild(_loc10_);
         _loc10_.height = 207;
         _loc10_.x = 0;
         _loc10_.y = 0;
      }
      
      public function get slotWidth() : int {
         return this._slotWidth;
      }
      
      public function get showCurrentPet() : Boolean {
         return this._showCurrentPet;
      }
      
      public function get petVO() : IPetVO {
         return this._petVO;
      }
      
      public function showPetInfo(param1:IPetVO, param2:Boolean = true) : void {
         var _loc3_:int = 0;
         this._petVO = param1;
         if(!this.petPortrait) {
            this.petPortrait = new PetPortrait(this._slotWidth,param1,this._switchable,this._showCurrentPet,this.showReleaseButton,this._showFeedPower);
            this.petPortrait.enableAnimation = this.animations;
            addChild(this.petPortrait);
         } else {
            this.petPortrait.petVO = param1;
         }
         if(this.isRarityLabelHidden) {
            this.petPortrait.hideRarityLabel();
         }
         if(this.showStats && param2) {
            this.statsGrid = !!this._useFeedStats?new PetFeedStatsGrid(195,param1):new PetStatsGrid(150,param1);
            addChild(this.statsGrid);
            this.statsGrid.y = !!this._useFeedStats?132:Number(130);
            _loc3_ = !!this._useFeedStats?195:Number(150);
            this.statsGrid.x = Math.round((this._slotWidth - _loc3_) / 2);
         }
      }
   }
}
