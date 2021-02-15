package com.company.assembleegameclient.util {
   import com.company.assembleegameclient.objects.Player;
   
   public class PlayerUtil {
       
      
      public function PlayerUtil() {
         super();
      }
      
      public static function getPlayerNameColor(param1:Player) : Number {
         if(param1.isFellowGuild_) {
            return 10944349;
         }
         if(param1.hasSupporterFeature(2)) {
            return 13395711;
         }
         if(param1.nameChosen_) {
            return 16572160;
         }
         return 16777215;
      }
   }
}
