package kabam.rotmg.packages.view {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import com.company.util.BitmapUtil;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   
   public class BasePackageButton extends Sprite {
      
      public static const IMAGE_NAME:String = "redLootBag";
      
      public static const IMAGE_ID:int = 0;
       
      
      public function BasePackageButton() {
         super();
      }
      
      protected static function makeIcon() : DisplayObject {
         var _loc1_:* = null;
         var _loc2_:BitmapData = AssetLibrary.getImageFromSet("redLootBag",0);
         _loc2_ = TextureRedrawer.redraw(_loc2_,40,true,0);
         _loc2_ = BitmapUtil.cropToBitmapData(_loc2_,10,10,_loc2_.width - 20,_loc2_.height - 20);
         _loc1_ = new Bitmap(_loc2_);
         _loc1_.x = 3;
         _loc1_.y = 3;
         return _loc1_;
      }
      
      protected function positionText(param1:DisplayObject, param2:TextFieldDisplayConcrete) : void {
         var _loc3_:Number = NaN;
         var _loc4_:Rectangle = param1.getBounds(this);
         _loc3_ = _loc4_.top + _loc4_.height / 2;
         param2.x = _loc4_.right;
         param2.y = _loc3_ - param2.height / 2;
      }
   }
}
