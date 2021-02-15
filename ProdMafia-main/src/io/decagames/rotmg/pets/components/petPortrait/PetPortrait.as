package io.decagames.rotmg.pets.components.petPortrait {
   import com.company.assembleegameclient.ui.icons.IconButton;
   import com.company.assembleegameclient.ui.icons.IconButtonFactory;
   import com.company.util.AssetLibrary;
   import com.greensock.TweenLite;
   import com.greensock.plugins.TransformMatrixPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.gskinner.motion.easing.Sine;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.pets.components.petIcon.PetIconFactory;
   import io.decagames.rotmg.pets.components.petSkinSlot.PetSkinSlot;
   import io.decagames.rotmg.pets.data.ability.AbilitiesUtil;
   import io.decagames.rotmg.pets.data.family.PetFamilyColors;
   import io.decagames.rotmg.pets.data.vo.IPetVO;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import io.decagames.rotmg.utils.colors.Tint;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   
   public class PetPortrait extends Sprite {
      
      public static const INFO_HEIGHT:int = 207;
      
      public static const BASE_POS_Y:int = 15;
       
      
      public var releaseSignal:Signal;
      
      private var petName:UILabel;
      
      private var petSwitch:UILabel;
      
      private var petRarity:UILabel;
      
      private var contentDividerTitle:SliceScalingBitmap;
      
      private var petFamily:UILabel;
      
      private var slotWidth:int;
      
      private var isAnimating:Boolean;
      
      private var animationWaitCounter:int = 0;
      
      private var _releaseButton:IconButton;
      
      private var showReleaseButton:Boolean;
      
      private var showFeedPower:Boolean;
      
      private var _petVO:IPetVO;
      
      private var _switchable:Boolean;
      
      private var _petSkin:PetSkinSlot;
      
      private var _showCurrentPet:Boolean;
      
      private var _enableAnimation:Boolean;
      
      public function PetPortrait(param1:int, param2:IPetVO, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false) {
         releaseSignal = new Signal();
         super();
         TweenPlugin.activate([TransformMatrixPlugin]);
         this._petVO = param2;
         this._switchable = param3;
         this.showReleaseButton = param5;
         this.slotWidth = param1;
         this.showFeedPower = param6;
         this._showCurrentPet = param4;
         this.petName = new UILabel();
         addChild(this.petName);
         this.petName.y = 15;
         if(param3) {
            this.petSwitch = new UILabel();
            this.petSwitch.text = "Click to switch Pet";
            DefaultLabelFormat.petInfoLabel(this.petSwitch,6842472);
            addChild(this.petSwitch);
            this.petSwitch.y = 35;
            this.petSwitch.x = param1 / 2 - this.petSwitch.width / 2;
         }
         this.petRarity = new UILabel();
         DefaultLabelFormat.petInfoLabel(this.petRarity,16777215);
         addChild(this.petRarity);
         this.petRarity.y = !param3?85:95;
         this.petFamily = new UILabel();
         this.contentDividerTitle = TextureParser.instance.getSliceScalingBitmap("UI","content_divider_smalltitle_white",320);
         addChild(this.contentDividerTitle);
         this.contentDividerTitle.y = !param3?100:110;
         addChild(this.petFamily);
         this.petFamily.y = !param3?100:110;
         this._petSkin = new PetSkinSlot(param2,false);
         this._petSkin.x = param1 / 2 - 20;
         this._petSkin.y = !this._switchable?42:52;
         addChild(this._petSkin);
         this.render();
      }
      
      public function get petVO() : IPetVO {
         return this._petVO;
      }
      
      public function set petVO(param1:IPetVO) : void {
         this._petVO = param1;
         this.render();
         this._petSkin.skinVO = param1;
      }
      
      public function get switchable() : Boolean {
         return this._switchable;
      }
      
      public function get petSkin() : PetSkinSlot {
         return this._petSkin;
      }
      
      public function get showCurrentPet() : Boolean {
         return this._showCurrentPet;
      }
      
      public function get enableAnimation() : Boolean {
         return this._enableAnimation;
      }
      
      public function set enableAnimation(param1:Boolean) : void {
         this._petSkin.manualUpdate = param1;
         this._enableAnimation = param1;
      }
      
      public function hideRarityLabel() : void {
         this.petRarity.alpha = 0;
      }
      
      public function dispose() : void {
         if(this._releaseButton) {
            this._releaseButton.removeEventListener("click",this.onReleaseClickHandler);
         }
      }
      
      public function simulateFeed(param1:Array, param2:int) : void {
         this.updateFeedPowerInfo(this.getCurrentPointsFromAbilitiesList() + param2,this.getMaxPointsFromAbilitiesList(),param2 != 0);
      }
      
      private function startAnimation() : void {
         if(this.isAnimating) {
            return;
         }
         this.animationWaitCounter = 0;
         this.isAnimating = true;
         var animationSpiral:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","animation_spiral");
         animationSpiral.x = Math.round((this.slotWidth - animationSpiral.width) / 2);
         animationSpiral.y = Math.round((207 - animationSpiral.height) / 2);
         var whiteRectangle:Sprite = new Sprite();
         whiteRectangle.graphics.beginFill(16777215);
         whiteRectangle.graphics.drawRect(0,0,this.slotWidth,207);
         whiteRectangle.graphics.endFill();
         whiteRectangle.alpha = 0;
         addChild(whiteRectangle);
         var flashDuration:Number = 0.3;
         var spinDuration:Number = 1.5;
         var spinAngle:int = 80;
         var hideDuration:Number = 0.3;
         TweenLite.to(whiteRectangle,flashDuration,{
            "alpha":1,
            "ease":Sine.easeIn,
            "onComplete":function():void {
               applyPetChange();
               _petSkin.addSkin(StaticInjectorContext.getInjector().getInstance(PetIconFactory).getPetSkinTexture(_petVO,50));
               addChildAt(animationSpiral,0);
               TweenLite.to(animationSpiral as Shape,spinDuration,{
                  "transformAroundCenter":{"rotation":spinAngle},
                  "ease":Sine.easeOut
               });
               TweenLite.to(animationSpiral,hideDuration,{
                  "alpha":0,
                  "delay":spinDuration - 0.2,
                  "overwrite":false,
                  "ease":Sine.easeIn,
                  "onComplete":function():void {
                     removeChild(whiteRectangle);
                     removeChild(animationSpiral);
                     isAnimating = false;
                  }
               });
            }
         });
         TweenLite.to(whiteRectangle,flashDuration,{
            "alpha":0,
            "delay":flashDuration,
            "ease":Sine.easeOut,
            "overwrite":false
         });
      }
      
      private function render() : void {
         if(this._petVO) {
            if(this._enableAnimation && (this.petName.text != "" && this.petName.text != this.petVO.name || this.petFamily.text != "" && this.petFamily.text != this.petVO.family)) {
               this.startAnimation();
            } else {
               this.applyPetChange();
            }
         } else {
            this.petName.text = "";
            this.petRarity.text = "";
            this.petFamily.text = "";
            if(this.contentDividerTitle.parent) {
               removeChild(this.contentDividerTitle);
            }
            if(this._releaseButton) {
               this._releaseButton.removeEventListener("click",this.onReleaseClickHandler);
               removeChild(this._releaseButton);
               this._releaseButton = null;
            }
         }
      }
      
      private function applyPetChange() : void {
         var _loc1_:* = null;
         Tint.add(this.contentDividerTitle,PetFamilyColors.getColorByFamilyKey(this.petVO.family),1);
         this.petFamily.text = this.petVO.family;
         this.petRarity.text = LineBuilder.getLocalizedStringFromKey(this.petVO.rarity.rarityKey);
         DefaultLabelFormat.petFamilyLabel(this.petFamily,16777215);
         this.petName.text = this.petVO.name;
         this.petName.y = !this.showFeedPower?15:8;
         this.contentDividerTitle.width = this.petFamily.width + 20;
         this.contentDividerTitle.x = this.slotWidth / 2 - this.contentDividerTitle.width / 2;
         if(!this.contentDividerTitle.parent) {
            addChild(this.contentDividerTitle);
            addChild(this.petFamily);
         }
         DefaultLabelFormat.petNameLabel(this.petName,this.petVO.rarity.color);
         if(this.petName.textWidth >= this.slotWidth) {
            DefaultLabelFormat.petNameLabelSmall(this.petName,this.petVO.rarity.color);
         }
         this.petRarity.x = this.slotWidth / 2 - this.petRarity.width / 2;
         this.petFamily.x = this.slotWidth / 2 - this.petFamily.width / 2;
         this.petName.x = this.slotWidth / 2 - this.petName.width / 2;
         if(this.showReleaseButton && !this._releaseButton) {
            _loc1_ = StaticInjectorContext.getInjector().getInstance(IconButtonFactory);
            this._releaseButton = _loc1_.create(AssetLibrary.getImageFromSet("lofiInterfaceBig",42),"","","");
            this._releaseButton.x = 10;
            this._releaseButton.y = 10;
            this._releaseButton.addEventListener("click",this.onReleaseClickHandler);
            addChild(this._releaseButton);
         }
         if(this._releaseButton) {
            this._releaseButton.setToolTipText("Release " + this.petVO.name);
         }
         if(this.showFeedPower) {
            this.updateFeedPowerInfo(this.getCurrentPointsFromAbilitiesList(),this.getMaxPointsFromAbilitiesList(),false);
         }
      }
      
      private function getMaxPointsFromAbilitiesList() : int {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = this._petVO.abilityList;
         var _loc6_:int = 0;
         var _loc5_:* = this._petVO.abilityList;
         for each(_loc1_ in this._petVO.abilityList) {
            if(_loc1_.getUnlocked()) {
               _loc3_ = _loc3_ + AbilitiesUtil.abilityPowerToMinPoints(this._petVO.maxAbilityPower);
            }
         }
         return _loc3_;
      }
      
      private function getCurrentPointsFromAbilitiesList() : int {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:* = this._petVO.abilityList;
         var _loc6_:int = 0;
         var _loc5_:* = this._petVO.abilityList;
         for each(_loc1_ in this._petVO.abilityList) {
            if(_loc1_.getUnlocked()) {
               _loc3_ = _loc3_ + _loc1_.points;
            }
         }
         return _loc3_;
      }
      
      private function updateFeedPowerInfo(param1:int, param2:int, param3:Boolean) : void {
      }
      
      private function onReleaseClickHandler(param1:MouseEvent) : void {
         this.releaseSignal.dispatch();
      }
   }
}
