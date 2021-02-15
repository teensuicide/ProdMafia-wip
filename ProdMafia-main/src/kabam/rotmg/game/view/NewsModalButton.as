package kabam.rotmg.game.view {
   import com.company.assembleegameclient.game.events.DisplayAreaChangedSignal;
   import com.company.assembleegameclient.sound.SoundEffectLibrary;
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.news.model.NewsModel;
   import kabam.rotmg.news.view.NewsModal;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.ui.UIUtils;
   
   public class NewsModalButton extends Sprite {
      
      public static const IMAGE_NAME:String = "lofiObj2";
      
      public static const IMAGE_ID:int = 345;
      
      public static var showsHasUpdate:Boolean;
       
      
      private var bitmap:Bitmap;
      
      private var background:Sprite;
      
      private var background2:Sprite;
      
      private var icon:BitmapData;
      
      private var text:TextFieldDisplayConcrete;
      
      public function NewsModalButton() {
         super();
         mouseChildren = false;
         this.icon = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiObj2",345),40,true,0);
         this.bitmap = new Bitmap(this.icon);
         this.bitmap.x = -5;
         this.bitmap.y = -8;
         this.background = UIUtils.makeStaticHUDBackground();
         this.background2 = UIUtils.makeHUDBackground(31,25);
         this.text = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         this.text.setStringBuilder(new StaticStringBuilder("Update!"));
         this.text.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         this.text.setVerticalAlign("bottom");
         this.drawAsOpen();
         var _loc1_:Rectangle = this.bitmap.getBounds(this);
         this.text.x = _loc1_.right - 10;
         this.text.y = _loc1_.bottom - 10;
         addEventListener("click",this.onClick);
      }
      
      public function drawAsOpen() : void {
         var _loc1_:NewsModel = StaticInjectorContext.getInjector().getInstance(NewsModel);
         if(_loc1_.hasUpdates()) {
            showsHasUpdate = true;
            StaticInjectorContext.getInjector().getInstance(DisplayAreaChangedSignal).dispatch();
            addChild(this.background);
            addChild(this.text);
         } else {
            showsHasUpdate = false;
            StaticInjectorContext.getInjector().getInstance(DisplayAreaChangedSignal).dispatch();
            addChild(this.background2);
         }
         addChild(this.bitmap);
      }
      
      public function onClick(param1:MouseEvent) : void {
         var _loc2_:OpenDialogSignal = StaticInjectorContext.getInjector().getInstance(OpenDialogSignal);
         _loc2_.dispatch(new NewsModal());
         SoundEffectLibrary.play("button_click");
      }
   }
}
