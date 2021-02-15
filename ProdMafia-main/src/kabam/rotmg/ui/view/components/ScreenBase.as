package kabam.rotmg.ui.view.components {
   import com.company.assembleegameclient.ui.SoundIcon;
   import flash.display.Sprite;
   
   public class ScreenBase extends Sprite {
      
      public static var TitleScreenGraphic:Class = ScreenBase_TitleScreenBackground;
       
      
      public function ScreenBase() {
         super();
         addChild(new TitleScreenGraphic());
         addChild(new DarkLayer());
         addChild(new SoundIcon());
      }
   }
}
