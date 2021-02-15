package com.company.assembleegameclient.sound {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class SoundEffectLibrary {
      
      private static const URL_PATTERN:String = "{URLBASE}/sfx/{NAME}.mp3";
      
      public static var nameMap_:Dictionary = new Dictionary();
      
      private static var urlBase:String;
      
      private static var activeSfxList_:Dictionary = new Dictionary(true);
       
      
      public function SoundEffectLibrary() {
         super();
      }
      
      public static function load(param1:String) : Sound {
         var _loc2_:* = nameMap_[param1] || makeSound(param1);
         nameMap_[param1] = _loc2_;
         return _loc2_;
      }
      
      public static function makeSound(param1:String) : Sound {
         var _loc2_:Sound = new Sound();
         _loc2_.addEventListener("ioError",onIOError);
         _loc2_.load(makeSoundRequest(param1));
         return _loc2_;
      }
      
      public static function play(param1:String, param2:Number = 1, param3:Boolean = true) : void {
         if(!Parameters.data.playSFX && param3 || !param3 && !Parameters.data.playPewPew) {
            return;
         }
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:Sound = load(param1);
         var _loc6_:Number = Parameters.data.SFXVolume * param2;
         try {
            _loc4_ = new SoundTransform(_loc6_);
            _loc5_ = _loc7_.play(0,0,_loc4_);
            _loc5_.addEventListener("soundComplete",onSoundComplete,false,0,true);
            activeSfxList_[_loc5_] = _loc6_;
            return;
         }
         catch(error:Error) {
            return;
         }
      }
      
      public static function updateVolume(param1:Number) : void {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = activeSfxList_;
         var _loc7_:int = 0;
         var _loc6_:* = activeSfxList_;
         for each(_loc2_ in activeSfxList_) {
            activeSfxList_[_loc2_] = param1;
            _loc3_ = _loc2_.soundTransform;
            _loc3_.volume = !!Parameters.data.playSFX?activeSfxList_[_loc2_]:0;
            _loc2_.soundTransform = _loc3_;
         }
      }
      
      public static function updateTransform() : void {
         var _loc1_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = activeSfxList_;
         var _loc6_:int = 0;
         var _loc5_:* = activeSfxList_;
         for each(_loc1_ in activeSfxList_) {
            _loc3_ = _loc1_.soundTransform;
            _loc3_.volume = !!Parameters.data.playSFX?activeSfxList_[_loc1_]:0;
            _loc1_.soundTransform = _loc3_;
         }
      }
      
      private static function getUrlBase() : String {
         return "https://dangergun.github.io";
      }
      
      private static function makeSoundRequest(param1:String) : URLRequest {
         urlBase = urlBase || getUrlBase();
         var _loc2_:String = "{URLBASE}/sfx/{NAME}.mp3".replace("{URLBASE}",urlBase).replace("{NAME}",param1);
         return new URLRequest(_loc2_);
      }
      
      public static function onIOError(param1:IOErrorEvent) : void {
      }
      
      private static function onSoundComplete(param1:Event) : void {
         var _loc2_:SoundChannel = param1.target as SoundChannel;
      }
   }
}
