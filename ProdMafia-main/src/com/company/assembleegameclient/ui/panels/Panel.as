package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.AGameSprite;
   import flash.display.Sprite;
   
   public class Panel extends Sprite {
      
      public static const WIDTH:int = 188;
      
      public static const HEIGHT:int = 84;
       
      
      public var gs_:AGameSprite;
      
      public function Panel(param1:AGameSprite) {
         super();
         this.gs_ = param1;
      }
      
      public function draw() : void {
      }
   }
}
