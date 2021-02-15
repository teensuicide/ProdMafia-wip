package com.company.assembleegameclient.background {
   import com.company.assembleegameclient.map.Camera;
   import flash.display.Sprite;
   
   public class Background extends Sprite {
      
      public static const NO_BACKGROUND:int = 0;
      
      public static const STAR_BACKGROUND:int = 1;
      
      public static const NEXUS_BACKGROUND:int = 2;
      
      public static const NUM_BACKGROUND:int = 3;
       
      
      public function Background() {
         super();
         visible = false;
      }
      
      public static function getBackground(param1:int) : Background {
         switch(int(param1) - 1) {
            case 0:
               return new StarBackground();
            case 1:
               return new NexusBackground();
            default:
               return null;
         }
      }
      
      public function draw(param1:Camera, param2:int) : void {
      }
   }
}
