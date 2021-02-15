package com.company.assembleegameclient.sound {
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   public class Music {
      
      private static const MUSIC_URL:String = "https://dangergun.github.io/sfx/music/sorc%20prod.mp3";
      
      private static var music_:Sound = null;
      
      private static var musicVolumeTransform:SoundTransform;
      
      private static var musicChannel_:SoundChannel = null;
      
      private static var volume:Number = 0.3;
       
      
      public function Music() {
         super();
      }
      
      public static function load() : void {
         volume = Parameters.data.musicVolume;
         musicVolumeTransform = new SoundTransform(volume);
         if(Parameters.data.playMusic) {
            if(!music_) {
               music_ = new Sound();
               music_.load(new URLRequest("https://dangergun.github.io/sfx/music/sorc%20prod.mp3"));
            }
            musicChannel_ = music_.play(0,2147483647,musicVolumeTransform);
         }
      }
      
      public static function setPlayMusic(param1:Boolean) : void {
         Parameters.data.playMusic = param1;
         Parameters.save();
         if(Parameters.data.playMusic) {
            if(!music_) {
               music_ = new Sound();
               music_.load(new URLRequest("https://dangergun.github.io/sfx/music/sorc%20prod.mp3"));
            }
            musicChannel_ = music_.play(0,2147483647,musicVolumeTransform);
         } else {
            musicChannel_.stop();
            music_.close();
         }
         musicVolumeTransform.volume = volume;
         musicChannel_.soundTransform = musicVolumeTransform;
      }
      
      public static function setMusicVolume(param1:Number) : void {
         Parameters.data.musicVolume = param1;
         Parameters.save();
         if(!Parameters.data.playMusic) {
            return;
         }
         if(musicVolumeTransform) {
            musicVolumeTransform.volume = param1;
         } else {
            musicVolumeTransform = new SoundTransform(param1);
         }
         musicChannel_.soundTransform = musicVolumeTransform;
      }
   }
}
