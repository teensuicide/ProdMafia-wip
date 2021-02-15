package io.decagames.rotmg.classes {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   import com.gskinner.motion.easing.Bounce;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import io.decagames.rotmg.ui.texture.TextureParser;
   
   public class NewClassUnlockNotification extends Sprite {
       
      
      private const WIDTH:int = 192;
      
      private const HEIGHT:int = 192;
      
      private const NEW_CLASS_UNLOCKED:String = "New Class Unlocked!";
      
      private var _contentContainer:Sprite;
      
      private var _whiteSplash:Shape;
      
      private var _newClass:Bitmap;
      
      private var _objectTypes:Array;
      
      private var _timeLineMax:TimelineMax;
      
      private var _characterName:UILabel;
      
      public function NewClassUnlockNotification() {
         super();
         this.init();
      }
      
      public function playNotification(param1:Array = null) : void {
         this._objectTypes = param1;
         this.createCharacter();
         this.playAnimation();
      }
      
      private function playAnimation() : void {
         if(!this._timeLineMax) {
            this._timeLineMax = new TimelineMax();
            this._timeLineMax.add(TweenMax.to(this._whiteSplash,0.1,{
               "autoAlpha":1,
               "transformAroundCenter":{
                  "scaleX":1,
                  "scaleY":1
               },
               "ease":Bounce.easeOut
            }));
            this._timeLineMax.add(TweenMax.to(this._whiteSplash,0.1,{
               "alpha":0.4,
               "tint":0,
               "ease":Expo.easeOut
            }));
            this._timeLineMax.add(TweenMax.to(this._contentContainer,0.2,{
               "autoAlpha":1,
               "ease":Bounce.easeOut
            }));
            this._timeLineMax.add(TweenMax.to(this._contentContainer,2,{"onComplete":this.resetAnimation}));
         } else {
            this._timeLineMax.play(0);
         }
      }
      
      private function resetAnimation() : void {
         if(this._objectTypes.length > 0) {
            this.createCharacter();
            this.playAnimation();
         } else {
            this._timeLineMax.reverse();
         }
      }
      
      private function createCharacter() : void {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(this._newClass) {
            this._contentContainer.removeChild(this._newClass);
            this._newClass.bitmapData.dispose();
            this._newClass = null;
         }
         var _loc5_:int = ObjectLibrary.playerChars_.length;
         var _loc1_:int = this._objectTypes.shift();
         while(_loc4_ < _loc5_) {
            _loc3_ = ObjectLibrary.playerChars_[_loc4_];
            _loc2_ = _loc3_.@type;
            if(_loc1_ == _loc2_) {
               this._newClass = new Bitmap(this.getImageBitmapData(_loc3_));
               break;
            }
            _loc4_++;
         }
         if(this._newClass) {
            this._newClass.x = (192 - this._newClass.width) / 2;
            this._newClass.y = (192 - this._newClass.height) / 2 - 20;
            this._contentContainer.addChild(this._newClass);
            if(!this._characterName) {
               this.createCharacterName();
            }
            this._characterName.text = _loc3_.@id;
            this._characterName.x = (192 - this._characterName.width) / 2;
            this._characterName.y = (192 - this._characterName.height) / 2 + 20;
         }
      }
      
      private function createCharacterName() : void {
         this._characterName = new UILabel();
         DefaultLabelFormat.notificationLabel(this._characterName,14,16777215,"center",true);
         this._contentContainer.addChild(this._characterName);
      }
      
      private function createCharacterBackground() : void {
         var _loc2_:* = null;
         var _loc1_:* = null;
         _loc2_ = new Shape();
         _loc2_.graphics.beginFill(5526612);
         _loc2_.graphics.drawRect(0,0,105,105);
         _loc2_.x = (192 - _loc2_.width) / 2;
         _loc2_.y = (192 - _loc2_.height) / 2 - 6;
         this._contentContainer.addChild(_loc2_);
         _loc1_ = TextureParser.instance.getSliceScalingBitmap("UI","popup_background_decoration");
         _loc1_.width = 105;
         _loc1_.height = 105;
         _loc1_.x = _loc2_.x;
         _loc1_.y = _loc2_.y;
         this._contentContainer.addChild(_loc1_);
      }
      
      private function getImageBitmapData(param1:XML) : BitmapData {
         return SavedCharacter.getImage(null,param1,2,0,0,true,false);
      }
      
      private function init() : void {
         this.createWhiteSplash();
         this.createContainers();
         this.createCharacterBackground();
         this.createClassUnlockLabel();
      }
      
      private function createClassUnlockLabel() : void {
         var _loc1_:* = null;
         _loc1_ = new UILabel();
         _loc1_.text = "New Class Unlocked!";
         DefaultLabelFormat.notificationLabel(_loc1_,18,65280,"center",true);
         _loc1_.width = 192;
         _loc1_.x = (192 - _loc1_.width) / 2;
         _loc1_.y = 192 - _loc1_.height - 12;
         this._contentContainer.addChild(_loc1_);
      }
      
      private function createWhiteSplash() : void {
         this._whiteSplash = new Shape();
         var _loc1_:Graphics = this._whiteSplash.graphics;
         _loc1_.beginFill(16777215);
         _loc1_.drawRect(0,0,192,192);
         this._whiteSplash.x = this._whiteSplash.width / 2;
         this._whiteSplash.y = this._whiteSplash.height / 2;
         this._whiteSplash.alpha = 0;
         this._whiteSplash.visible = false;
         this._whiteSplash.scaleY = 0;
         this._whiteSplash.scaleX = 0;
         addChild(this._whiteSplash);
      }
      
      private function createContainers() : void {
         this._contentContainer = new Sprite();
         this._contentContainer.alpha = 0;
         this._contentContainer.visible = false;
         addChild(this._contentContainer);
      }
   }
}
