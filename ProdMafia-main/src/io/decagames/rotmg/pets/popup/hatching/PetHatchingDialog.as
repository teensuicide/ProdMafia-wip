package io.decagames.rotmg.pets.popup.hatching {
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.util.AnimatedChar;
   import com.company.assembleegameclient.util.AnimatedChars;
   import com.company.assembleegameclient.util.MaskedImage;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.assembleegameclient.util.redrawers.GlowRedrawer;
   import com.greensock.TimelineMax;
   import com.greensock.TweenLite;
   import com.greensock.plugins.TransformMatrixPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.gskinner.motion.easing.Sine;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import io.decagames.rotmg.pets.data.vo.SkinVO;
   import io.decagames.rotmg.ui.buttons.SliceScalingButton;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.popups.modal.ModalPopup;
   import io.decagames.rotmg.ui.sliceScaling.SliceScalingBitmap;
   import io.decagames.rotmg.ui.texture.TextureParser;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class PetHatchingDialog extends ModalPopup {
       
      
      private var contentInset:SliceScalingBitmap;
      
      private var eggImage:Bitmap;
      
      private var animationContainer:Sprite;
      
      private var animationTimeline:TimelineMax;
      
      private var petImage:Bitmap;
      
      private var eggSize:int = 80;
      
      private var unlockedSkin:Boolean;
      
      private var skinVO:SkinVO;
      
      private var petName:String;
      
      private var _petSkin:int;
      
      private var _okButton:SliceScalingButton;
      
      public function PetHatchingDialog(param1:String, param2:int, param3:int, param4:Boolean, param5:SkinVO) {
         var petName:String = param1;
         var petSkin:int = param2;
         var itemType:int = param3;
         var unlocked:Boolean = param4;
         var skinVO:SkinVO = param5;
         super(270,180,"Pet hatching!");
         this.unlockedSkin = unlocked;
         this._petSkin = petSkin;
         this.skinVO = skinVO;
         this.petName = petName;
         TweenPlugin.activate([TransformMatrixPlugin]);
         this.petImage = this.getTypeBitmap();
         this.animationContainer = new Sprite();
         this.contentInset = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",270);
         addChild(this.contentInset);
         this.contentInset.height = 130;
         this.contentInset.x = 0;
         this.contentInset.y = 0;
         this.animationContainer.x = this.contentInset.x;
         this.animationContainer.y = this.contentInset.y;
         addChild(this.animationContainer);
         var maskImage:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","popup_content_inset",this.contentInset.width);
         maskImage.height = this.contentInset.height;
         maskImage.x = this.contentInset.x;
         maskImage.y = this.contentInset.y;
         maskImage.cacheAsBitmap = true;
         this.animationContainer.cacheAsBitmap = true;
         addChild(maskImage);
         this.animationContainer.mask = maskImage;
         var texture:BitmapData = ObjectLibrary.getRedrawnTextureFromType(itemType,this.eggSize,true,false);
         this.eggImage = new Bitmap(texture);
         this.eggImage.x = this.contentInset.x + Math.round((this.contentInset.width - this.eggImage.width) / 2);
         this.eggImage.y = this.contentInset.y + Math.round((this.contentInset.height - this.eggImage.height) / 2);
         this.animationContainer.addChild(this.eggImage);
         this.animationTimeline = new TimelineMax();
         this.animateEgg(this.animationTimeline,this.eggImage,-20,0.1,0.5);
         this.animateEgg(this.animationTimeline,this.eggImage,20,0.1,0);
         this.animateEgg(this.animationTimeline,this.eggImage,0,0.1,0);
         this.animateEgg(this.animationTimeline,this.eggImage,20,0.1,0.3);
         this.animateEgg(this.animationTimeline,this.eggImage,-20,0.1,0);
         this.animateEgg(this.animationTimeline,this.eggImage,0,0.1,0,function():void {
            showPet();
         });
         this.animationTimeline.to(this.eggImage as DisplayObject,0.1,{"transformAroundPoint":{
            "point":new Point(this.eggImage.width / 2,this.eggImage.height / 2),
            "pointIsLocal":true,
            "scaleX":2,
            "scaleY":2
         }});
         this.animationTimeline.play();
         this._okButton = new SliceScalingButton(TextureParser.instance.getSliceScalingBitmap("UI","generic_green_button"));
         this._okButton.setLabel(LineBuilder.getLocalizedStringFromKey("Pets.sendToYard"),DefaultLabelFormat.questButtonCompleteLabel);
         this._okButton.width = 149;
         this._okButton.x = Math.round((_contentWidth - this._okButton.width) / 2);
         this._okButton.y = _contentHeight - this._okButton.height;
         addChild(this._okButton);
      }
      
      public function get petSkin() : int {
         return this._petSkin;
      }
      
      public function get okButton() : SliceScalingButton {
         return this._okButton;
      }
      
      private function getTypeBitmap() : Bitmap {
         var _loc4_:String = ObjectLibrary.getIdFromType(this._petSkin);
         var _loc1_:XML = ObjectLibrary.getXMLfromId(_loc4_);
         var _loc3_:String = _loc1_.AnimatedTexture.File;
         var _loc2_:int = _loc1_.AnimatedTexture.Index;
         var _loc5_:AnimatedChar = AnimatedChars.getAnimatedChar(_loc3_,_loc2_);
         var _loc7_:MaskedImage = _loc5_.imageFromAngle(0,0,0);
         var _loc6_:BitmapData = TextureRedrawer.resize(_loc7_.image_,_loc7_.mask_,this.eggSize,true,0,0);
         _loc6_ = GlowRedrawer.outlineGlow(_loc6_,0,6);
         return new Bitmap(_loc6_);
      }
      
      private function showPet() : void {
         var animationSpiral:SliceScalingBitmap = TextureParser.instance.getSliceScalingBitmap("UI","animation_spiral");
         animationSpiral.x = this.contentInset.x + Math.round((this.contentInset.width - animationSpiral.width) / 2);
         animationSpiral.y = this.contentInset.y + Math.round((this.contentInset.height - animationSpiral.height) / 2);
         var whiteRectangle:Sprite = new Sprite();
         whiteRectangle.graphics.beginFill(16777215);
         whiteRectangle.graphics.drawRect(0,0,this.contentInset.width,this.contentInset.height);
         whiteRectangle.graphics.endFill();
         whiteRectangle.alpha = 0;
         this.animationContainer.addChild(whiteRectangle);
         var flashDuration:Number = 0.3;
         var spinDuration:Number = 1.5;
         var spinAngle:int = 80;
         var hideDuration:Number = 0.1;
         TweenLite.to(whiteRectangle,0.1,{
            "alpha":1,
            "ease":Sine.easeIn,
            "onComplete":function():void {
               var textInfo:* = undefined;
               animationContainer.removeChild(eggImage);
               animationContainer.addChild(animationSpiral);
               petImage.x = contentInset.x + Math.round((contentInset.width - petImage.width) / 2);
               petImage.y = contentInset.y + Math.round((contentInset.height - petImage.height) / 2);
               animationContainer.addChild(petImage);
               var petNameLabel:* = new UILabel();
               DefaultLabelFormat.petNameLabel(petNameLabel,skinVO.rarity.color);
               petNameLabel.y = contentInset.y + 15;
               petNameLabel.width = _contentWidth;
               petNameLabel.wordWrap = true;
               petNameLabel.text = petName;
               animationContainer.addChild(petNameLabel);
               if(unlockedSkin) {
                  textInfo = new UILabel();
                  DefaultLabelFormat.newSkinHatched(textInfo);
                  textInfo.y = contentInset.y + contentInset.height - 30;
                  textInfo.width = _contentWidth;
                  textInfo.wordWrap = true;
                  textInfo.text = "New Pet Skin added to your Wardrobe!";
                  animationContainer.addChild(textInfo);
               }
               animationContainer.addChild(whiteRectangle);
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
                     animationContainer.removeChild(whiteRectangle);
                     animationContainer.removeChild(animationSpiral);
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
      
      private function animateEgg(param1:TimelineMax, param2:Bitmap, param3:Number, param4:Number, param5:Number, param6:Function = null) : void {
         param1.to(param2 as DisplayObject,param4,{
            "delay":param5,
            "transformAroundPoint":{
               "point":new Point(param2.width / 2,param2.height),
               "pointIsLocal":true,
               "rotation":param3
            },
            "onComplete":param6,
            "overwrite":false
         });
      }
   }
}
