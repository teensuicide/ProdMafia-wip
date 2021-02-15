package kabam.rotmg.ui.view {
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import kabam.rotmg.ui.model.Key;
   
   public class KeysView extends Sprite {
      
      private static var keyBackgroundPng:Class = KeysView_keyBackgroundPng;
      
      private static var greenKeyPng:Class = KeysView_greenKeyPng;
      
      private static var redKeyPng:Class = KeysView_redKeyPng;
      
      private static var yellowKeyPng:Class = KeysView_yellowKeyPng;
      
      private static var purpleKeyPng:Class = KeysView_purpleKeyPng;
       
      
      private var base:Bitmap;
      
      private var keys:Vector.<Bitmap>;
      
      public function KeysView() {
         super();
         this.base = new keyBackgroundPng();
         addChild(this.base);
         this.keys = new Vector.<Bitmap>(4,true);
         this.keys[0] = new purpleKeyPng();
         this.keys[0].x = 12;
         this.keys[0].y = 12;
         this.keys[1] = new greenKeyPng();
         this.keys[1].x = 52;
         this.keys[1].y = 12;
         this.keys[2] = new redKeyPng();
         this.keys[2].x = 92;
         this.keys[2].y = 12;
         this.keys[3] = new yellowKeyPng();
         this.keys[3].x = 132;
         this.keys[3].y = 12;
      }
      
      public function showKey(param1:Key) : void {
         var _loc2_:Bitmap = this.keys[param1.position];
         if(!contains(_loc2_)) {
            addChild(_loc2_);
         }
      }
      
      public function hideKey(param1:Key) : void {
         var _loc2_:Bitmap = this.keys[param1.position];
         if(contains(_loc2_)) {
            removeChild(_loc2_);
         }
      }
   }
}
