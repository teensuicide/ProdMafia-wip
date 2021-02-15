package com.company.util {
   import flash.display.BitmapData;
   import flash.media.Sound;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   
   public class AssetLibrary {
      public static var imageSets_:Dictionary = new Dictionary();
      public static var images:Dictionary = new Dictionary();
      private static var sounds_:Dictionary = new Dictionary();
      
      public function AssetLibrary(param1:StaticEnforcer_1918) {
         super();
      }
      
      public static function addImageSet(param1:String, param2:ImageSet) : void {
         imageSets_[param1] = param2;
      }

      public static function addImage(imageName:String, bmpd:BitmapData) : void {
         images[imageName] = bmpd;
      }
      
      public static function addToImageSet(param1:String, param2:BitmapData) : void {
         var _loc3_:ImageSet = imageSets_[param1];
         if(_loc3_ == null) {
            _loc3_ = new ImageSet();
            imageSets_[param1] = _loc3_;
         }
         _loc3_.add(param2);
      }
      
      public static function addSound(param1:String, param2:Class) : void {
         var _loc3_:Array = sounds_[param1];
         if(_loc3_ == null) {
            sounds_[param1] = [];
         }
         sounds_[param1].push(param2);
      }
      
      public static function getImageSet(param1:String) : ImageSet {
         return imageSets_[param1];
      }

      public static function getImage(imageName:String) : BitmapData {
         return images[imageName];
      }

      public static function getImageFromSet(param1:String, param2:int) : BitmapData {
         var _loc3_:ImageSet = imageSets_[param1];
         if(!_loc3_) {
            _loc3_ = imageSets_["lofiObj3"];
         }
         return _loc3_.images.length > param2?_loc3_.images[param2]:_loc3_.images[0];
      }
      
      public static function getSound(param1:String) : Sound {
         var _loc2_:Array = sounds_[param1];
         var _loc3_:int = Math.random() * _loc2_.length;
         return new sounds_[param1][_loc3_]();
      }
      
      public static function playSound(param1:String, param2:Number = 1) : void {
         var _loc6_:* = null;
         var _loc4_:Array = sounds_[param1];
         var _loc5_:int = Math.random() * _loc4_.length;
         var _loc3_:Sound = new sounds_[param1][_loc5_]();
         if(param2 != 1) {
            _loc6_ = new SoundTransform(param2);
         }
         _loc3_.play(0,0,_loc6_);
      }
   }
}

class StaticEnforcer_1918 {
    
   
   function StaticEnforcer_1918() {
      super();
   }
}
