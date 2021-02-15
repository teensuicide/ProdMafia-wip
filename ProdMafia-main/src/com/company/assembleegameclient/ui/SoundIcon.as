package com.company.assembleegameclient.ui {
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.sound.Music;
   import com.company.assembleegameclient.sound.SFX;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   
   public class SoundIcon extends Sprite {
       
      
      private var bitmap_:Bitmap;
      
      public function SoundIcon() {
         bitmap_ = new Bitmap();
         super();
         addChild(this.bitmap_);
         this.bitmap_.scaleX = 2;
         this.bitmap_.scaleY = 2;
         this.setBitmap();
         addEventListener("click",this.onIconClick,false,0,true);
         filters = [new GlowFilter(0,1,4,4,2,1)];
      }
      
      private function setBitmap() : void {
         this.bitmap_.bitmapData = Parameters.data.playMusic || Parameters.data.playSFX?AssetLibrary.getImageFromSet("lofiInterfaceBig",3):AssetLibrary.getImageFromSet("lofiInterfaceBig",4);
      }
      
      private function onIconClick(param1:MouseEvent) : void {
         var _loc2_:* = !(Parameters.data.playMusic || Parameters.data.playSFX);
         Music.setPlayMusic(_loc2_);
         SFX.setPlaySFX(_loc2_);
         Parameters.data.playPewPew = _loc2_;
         Parameters.save();
         this.setBitmap();
      }
   }
}
