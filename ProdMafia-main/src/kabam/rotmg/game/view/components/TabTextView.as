package kabam.rotmg.game.view.components {
   import com.company.ui.BaseSimpleText;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class TabTextView extends TabView {
       
      
      private var background:Sprite;
      
      private var text:BaseSimpleText;
      
      private var badgeBG:Bitmap;
      
      private var badgeIcon:Bitmap;
      
      public function TabTextView(param1:int, param2:Sprite, param3:BaseSimpleText) {
         super(param1);
         this.initBackground(param2);
         if(param3) {
            this.initTabText(param3);
         }
      }
      
      override public function setSelected(param1:Boolean) : void {
         var _loc2_:ColorTransform = this.background.transform.colorTransform;
         _loc2_.color = !!param1?2368034:7039594;
         this.background.transform.colorTransform = _loc2_;
      }
      
      public function setBadge(param1:int) : void {
         var _loc2_:* = undefined;
         if(this.badgeIcon == null) {
            this.badgeIcon = new Bitmap();
            this.badgeIcon.bitmapData = AssetLibrary.getImageFromSet("lofiInterface",110);
            this.badgeIcon.x = this.x - 10;
            this.badgeIcon.y = 5;
            _loc2_ = 1.5;
            this.badgeIcon.scaleY = _loc2_;
            this.badgeIcon.scaleX = _loc2_;
            addChild(this.badgeIcon);
            this.badgeBG = new Bitmap();
            this.badgeBG.bitmapData = AssetLibrary.getImageFromSet("lofiInterface",110);
            this.badgeBG.x = this.x - 12;
            this.badgeBG.y = 3;
            _loc2_ = 2;
            this.badgeBG.scaleY = _loc2_;
            this.badgeBG.scaleX = _loc2_;
            addChild(this.badgeBG);
         }
         _loc2_ = param1 > 0;
         this.badgeBG.visible = _loc2_;
         this.badgeIcon.visible = _loc2_;
      }
      
      private function initBackground(param1:Sprite) : void {
         this.background = param1;
         addChild(param1);
      }
      
      private function initTabText(param1:BaseSimpleText) : void {
         this.text = param1;
         param1.x = 5;
         addChild(param1);
      }
   }
}
