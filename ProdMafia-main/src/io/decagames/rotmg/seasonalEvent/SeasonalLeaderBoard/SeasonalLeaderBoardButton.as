package io.decagames.rotmg.seasonalEvent.SeasonalLeaderBoard {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.UIUtils;
   
   public class SeasonalLeaderBoardButton extends Sprite {
      
      public static const IMAGE_NAME:String = "lofiObj4";
      
      public static const IMAGE_ID:int = 240;
      
      public static const NOTIFICATION_BACKGROUND_WIDTH:Number = 120;
      
      public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
       
      
      protected var _buttonMask:Sprite;
      
      private var bitmap:Bitmap;
      
      private var background:Sprite;
      
      private var icon:BitmapData;
      
      private var text:TextFieldDisplayConcrete;
      
      public function SeasonalLeaderBoardButton() {
         super();
         this.icon = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiObj4",240),40,true,0);
         this.background = UIUtils.makeHUDBackground(120,25);
         this.bitmap = new Bitmap(this.icon);
         this.bitmap.x = -5;
         this.bitmap.y = -8;
         this.text = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         this.text.setStringBuilder(new LineBuilder().setParams("Leaderboard"));
         this.text.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         this.text.setVerticalAlign("bottom");
         var _loc1_:Rectangle = this.bitmap.getBounds(this);
         this.text.x = _loc1_.right - 10;
         this.text.y = _loc1_.bottom - 10 - 3;
         this._buttonMask = new Sprite();
         this._buttonMask.graphics.beginFill(16711680,0);
         this._buttonMask.graphics.drawRect(0,0,120,25);
         this._buttonMask.graphics.endFill();
         addChild(this.background);
         addChild(this.text);
         addChild(this.bitmap);
         addChild(this._buttonMask);
         mouseEnabled = true;
      }
      
      public function get button() : Sprite {
         return this._buttonMask;
      }
   }
}
