package kabam.rotmg.death.view {
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import org.osflash.signals.Signal;
   
   public class ResurrectionView extends Sprite {
       
      
      public const showDialog:Signal = new Signal(Sprite);
      
      public const closed:Signal = new Signal();
      
      private const POPUP_BACKGROUND_COLOR:Number = 0;
      
      private const POPUP_LINE_COLOR:Number = 3881787;
      
      private const POPUP_WIDTH:Number = 300;
      
      private const POPUP_HEIGHT:Number = 400;
      
      private var popup:Dialog;
      
      public function ResurrectionView() {
         super();
      }
      
      public function init(param1:BitmapData) : void {
         this.createBackground(param1);
         this.createPopup();
      }
      
      public function createPopup() : void {
         this.popup = new Dialog("ResurrectionView.YouDied","ResurrectionView.deathText","ResurrectionView.SaveMe",null,null);
         this.popup.addEventListener("dialogLeftButton",this.onButtonClick);
         this.showDialog.dispatch(this.popup);
      }
      
      private function createBackground(param1:BitmapData) : void {
         var _loc3_:* = null;
         var _loc2_:* = [0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0.33,0.33,0.33,0,0,0.33,0.33,0.33,1,0];
         var _loc4_:ColorMatrixFilter = new ColorMatrixFilter(_loc2_);
         _loc3_ = new Bitmap(param1);
         _loc3_.filters = [_loc4_];
         addChild(_loc3_);
      }
      
      private function onButtonClick(param1:Event) : void {
         this.closed.dispatch();
      }
   }
}
