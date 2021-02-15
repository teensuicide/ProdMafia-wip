package io.decagames.rotmg.pets.components.caretaker {
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   
   public class CaretakerQueryDialogCaretaker extends Sprite {
       
      
      private const speechBubble:CaretakerQuerySpeechBubble = makeSpeechBubble();
      
      private const detailBubble:CaretakerQueryDetailBubble = makeDetailBubble();
      
      private const icon:Bitmap = makeCaretakerIcon();
      
      public function CaretakerQueryDialogCaretaker() {
         super();
      }
      
      public function showDetail(param1:String) : void {
         this.detailBubble.setText(param1);
         removeChild(this.speechBubble);
         addChild(this.detailBubble);
      }
      
      public function showSpeech() : void {
         removeChild(this.detailBubble);
         addChild(this.speechBubble);
      }
      
      public function setCaretakerIcon(param1:BitmapData) : void {
         this.icon.bitmapData = param1;
      }
      
      private function makeSpeechBubble() : CaretakerQuerySpeechBubble {
         var _loc1_:* = null;
         _loc1_ = new CaretakerQuerySpeechBubble("CaretakerQueryDialog.query");
         _loc1_.x = 60;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeDetailBubble() : CaretakerQueryDetailBubble {
         var _loc1_:CaretakerQueryDetailBubble = new CaretakerQueryDetailBubble();
         _loc1_.y = 60;
         return _loc1_;
      }
      
      private function makeCaretakerIcon() : Bitmap {
         var _loc1_:Bitmap = new Bitmap(this.makeDebugBitmapData());
         _loc1_.x = -16;
         _loc1_.y = -32;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeDebugBitmapData() : BitmapData {
         return new BitmapData(42,42,true,4278255360);
      }
   }
}
