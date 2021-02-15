package io.decagames.rotmg.shop.genericBox {
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import io.decagames.rotmg.ui.defaults.DefaultLabelFormat;
   import io.decagames.rotmg.ui.labels.UILabel;
   import kabam.rotmg.assets.services.IconFactory;
   
   public class SalePriceTag extends Sprite {
       
      
      private var coinBitmap:Bitmap;
      
      public function SalePriceTag(param1:int, param2:int) {
         var _loc4_:* = null;
         super();
         var _loc5_:UILabel = new UILabel();
         DefaultLabelFormat.originalPriceButtonLabel(_loc5_);
         _loc5_.text = param1.toString();
         _loc4_ = new Sprite();
         var _loc3_:BitmapData = param2 == 0?IconFactory.makeCoin(35):IconFactory.makeFame(35);
         this.coinBitmap = new Bitmap(_loc3_);
         this.coinBitmap.y = 0;
         addChild(this.coinBitmap);
         addChild(_loc5_);
         this.coinBitmap.x = _loc5_.textWidth + 5;
         addChild(_loc4_);
         _loc4_.graphics.lineStyle(2,16711722,0.6);
         _loc4_.graphics.lineTo(this.width,0);
         _loc4_.y = (_loc5_.textHeight + 2) / 2;
      }
      
      public function dispose() : void {
         this.coinBitmap.bitmapData.dispose();
      }
   }
}
