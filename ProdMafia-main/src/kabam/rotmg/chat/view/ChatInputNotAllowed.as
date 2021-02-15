package kabam.rotmg.chat.view {
   import com.company.assembleegameclient.util.TextureRedrawer;
   import com.company.util.AssetLibrary;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import kabam.rotmg.chat.model.ChatModel;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class ChatInputNotAllowed extends Sprite {
      
      public static const IMAGE_NAME:String = "lofiInterfaceBig";
      
      public static const IMADE_ID:int = 21;
       
      
      public function ChatInputNotAllowed() {
         super();
         this.makeTextField();
         this.makeSpeechBubble();
      }
      
      public function setup(param1:ChatModel) : void {
         x = 0;
         y = param1.bounds.height - param1.lineHeight;
      }
      
      private function makeTextField() : TextFieldDisplayConcrete {
         var _loc2_:LineBuilder = new LineBuilder().setParams("chat.registertoChat");
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete();
         _loc1_.setStringBuilder(_loc2_);
         _loc1_.x = 29;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeSpeechBubble() : Bitmap {
         var _loc1_:* = null;
         var _loc2_:BitmapData = AssetLibrary.getImageFromSet("lofiInterfaceBig",21);
         _loc2_ = TextureRedrawer.redraw(_loc2_,20,true,0,false);
         _loc1_ = new Bitmap(_loc2_);
         _loc1_.x = -5;
         _loc1_.y = -10;
         addChild(_loc1_);
         return _loc1_;
      }
   }
}
