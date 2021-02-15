package kabam.rotmg.game.view.components {
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class TabIconView extends TabView {
       
      
      private var background:Sprite;
      
      private var icon:Bitmap;
      
      public function TabIconView(param1:int, param2:Sprite, param3:Bitmap) {
         super(param1);
         this.initBackground(param2);
         if(param3) {
            this.initIcon(param3);
         }
      }
      
      override public function setSelected(param1:Boolean) : void {
         var _loc2_:ColorTransform = this.background.transform.colorTransform;
         _loc2_.color = !!param1?2368034:7039594;
         this.background.transform.colorTransform = _loc2_;
      }
      
      private function initBackground(param1:Sprite) : void {
         this.background = param1;
         addChild(param1);
      }
      
      private function initIcon(param1:Bitmap) : void {
         this.icon = param1;
         param1.x = param1.x - 5;
         param1.y = param1.y - 11;
         addChild(param1);
      }
   }
}
