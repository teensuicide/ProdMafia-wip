package com.company.assembleegameclient.screens.charrects {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.objects.ObjectLibrary;
   import com.company.assembleegameclient.util.FameUtil;
   import com.company.util.BitmapUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class CreateNewCharacterRect extends CharacterRect {
       
      
      private var bitmap_:Bitmap;
      
      public function CreateNewCharacterRect(param1:PlayerModel) {
         var _loc2_:int = 0;
         super();
         super.className = new LineBuilder().setParams("CreateNewCharacterRect.newCharacter");
         super.color = 5526612;
         super.overColor = 7829367;
         super.init();
         this.makeBitmap();
         if(param1.getNumStars() != FameUtil.maxStars()) {
            _loc2_ = FameUtil.maxStars() - param1.getNumStars();
            super.makeTaglineIcon();
            super.makeTaglineText(new LineBuilder().setParams("CreateNewCharacterRect.tagline",{"remainingStars":_loc2_}));
            taglineText.x = taglineText.x + taglineIcon.width;
         }
      }
      
      public function makeBitmap() : void {
         var _loc2_:XML = ObjectLibrary.playerChars_[int(ObjectLibrary.playerChars_.length * Math.random())];
         var _loc1_:BitmapData = SavedCharacter.getImage(null,_loc2_,0,0,0,false,false);
         _loc1_ = BitmapUtil.cropToBitmapData(_loc1_,6,6,_loc1_.width - 12,_loc1_.height - 6);
         this.bitmap_ = new Bitmap();
         this.bitmap_.bitmapData = _loc1_;
         this.bitmap_.x = 8;
         this.bitmap_.y = 4;
         selectContainer.addChild(this.bitmap_);
      }
   }
}
