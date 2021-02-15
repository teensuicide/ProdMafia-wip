package kabam.rotmg.ui {
   import flash.display.Sprite;
   
   public class UIUtils {
      
      private static const NOTIFICATION_BACKGROUND_WIDTH:Number = 95;
      
      public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
      
      private static const NOTIFICATION_BACKGROUND_ALPHA:Number = 0.4;
      
      private static const NOTIFICATION_BACKGROUND_COLOR:Number = 0;
      
      public static const NOTIFICATION_SPACE:uint = 28;
      
      public static var SHOW_EXPERIMENTAL_MENU:Boolean = true;
       
      
      public function UIUtils() {
         super();
      }
      
      public static function makeStaticHUDBackground() : Sprite {
         return makeHUDBackground(95,25);
      }
      
      public static function makeHUDBackground(param1:Number, param2:Number) : Sprite {
         var _loc3_:Sprite = new Sprite();
         return drawHUDBackground(_loc3_,param1,param2);
      }
      
      public static function toggleQuality(param1:Boolean) : void {
         if(Main.STAGE != null) {
            Main.STAGE.quality = !!param1?"high":"low";
         }
      }
      
      private static function drawHUDBackground(param1:Sprite, param2:Number, param3:Number) : Sprite {
         param1.graphics.beginFill(0,0.4);
         param1.graphics.drawRoundRect(0,0,param2,param3,12,12);
         param1.graphics.endFill();
         return param1;
      }
   }
}
