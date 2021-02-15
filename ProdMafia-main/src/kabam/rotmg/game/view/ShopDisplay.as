package kabam.rotmg.game.view {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.Rectangle;
   import io.decagames.rotmg.shop.ShopPopupView;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import io.decagames.rotmg.utils.colors.GreyScale;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.UIUtils;
   import org.swiftsuspenders.Injector;
   
   public class ShopDisplay extends Sprite {
      
      public static const IMAGE_NAME:String = "lofiObj4";
      
      public static const IMAGE_ID:int = 216;
      
      public static const NOTIFICATION_BACKGROUND_WIDTH:Number = 70;
      
      public static const NOTIFICATION_BACKGROUND_HEIGHT:Number = 25;
       
      
      protected var _shopMask:Sprite;
      
      private var bitmap:Bitmap;
      
      private var background:Sprite;
      
      private var indicator:Sprite;
      
      private var icon:BitmapData;
      
      private var text:TextFieldDisplayConcrete;
      
      private var isNew:Boolean;
      
      private var _isOnNexus:Boolean;
      
      public function ShopDisplay(param1:Boolean) {
         super();
         this._isOnNexus = param1;
         this.icon = TextureRedrawer.redraw(AssetLibrary.getImageFromSet("lofiObj4",216),40,true,0);
         this.background = UIUtils.makeHUDBackground(70,25);
         this.bitmap = new Bitmap(this.icon);
         this.bitmap.x = -5;
         this.bitmap.y = -8;
         this.text = new TextFieldDisplayConcrete().setSize(16).setColor(16777215);
         this.text.setStringBuilder(new LineBuilder().setParams("Shop"));
         this.text.filters = [new DropShadowFilter(0,0,0,1,4,4,2)];
         this.text.setVerticalAlign("bottom");
         var _loc2_:Rectangle = this.bitmap.getBounds(this);
         this.text.x = _loc2_.right - 10;
         this.text.y = _loc2_.bottom - 10 - 3;
         this._shopMask = new Sprite();
         this._shopMask.graphics.beginFill(16711680,0);
         this._shopMask.graphics.drawRect(0,0,70,25);
         this._shopMask.graphics.endFill();
         addChild(this.background);
         addChild(this.text);
         addChild(this.bitmap);
         addChild(this._shopMask);
         mouseEnabled = true;
         if(!param1) {
            GreyScale.greyScaleToDisplayObject(this,true);
         }
      }
      
      public function get isOnNexus() : Boolean {
         return this._isOnNexus;
      }
      
      public function get hasIndicator() : Boolean {
         return this.indicator && this.indicator.parent;
      }
      
      public function get shopButton() : Sprite {
         return this._shopMask;
      }
      
      public function newIndicator(param1:Boolean) : void {
         if(param1) {
            this.addIndicator();
         } else {
            this.resetIndicator();
         }
      }
      
      public function addIndicator() : void {
         this.background.graphics.clear();
         this.background.graphics.beginFill(823807,0.8);
         this.background.graphics.drawRoundRect(0,0,70,25,12,12);
         this.background.graphics.endFill();
      }
      
      private function resetIndicator() : void {
         this.background.graphics.clear();
         this.background.graphics.beginFill(0,0.4);
         this.background.graphics.drawRoundRect(0,0,70,25,12,12);
         this.background.graphics.endFill();
      }
      
      private function openShop() : void {
         var _loc2_:Injector = StaticInjectorContext.getInjector();
         var _loc1_:ShowPopupSignal = _loc2_.getInstance(ShowPopupSignal);
         _loc1_.dispatch(new ShopPopupView());
      }
      
      public function onShopClick(param1:MouseEvent) : void {
         if(this._isOnNexus) {
            this.openShop();
            this.newIndicator(false);
         }
      }
   }
}
