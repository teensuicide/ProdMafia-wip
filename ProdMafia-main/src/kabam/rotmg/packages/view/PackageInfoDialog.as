package kabam.rotmg.packages.view {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.util.graphics.ButtonLayoutHelper;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class PackageInfoDialog extends Sprite {
      
      private static const TITLE_Y:int = 8;
      
      private static const BUTTON_WIDTH:int = 120;
      
      private static const BUTTON_FONT:int = 16;
      
      private static const DIALOG_WIDTH:int = 546;
      
      private static const INNER_WIDTH:int = 416;
      
      private static const BUTTON_Y:int = 368;
      
      private static const MESSAGE_TITLE_Y:int = 164;
      
      private static const MESSAGE_BODY_Y:int = 210;
       
      
      private const background:DisplayObject = makeBackground();
      
      private const title:TextFieldDisplayConcrete = makeTitle();
      
      private const messageTitle:TextFieldDisplayConcrete = makeMessageTitle();
      
      private const messageBody:TextFieldDisplayConcrete = makeMessageBody();
      
      private const close:DeprecatedTextButton = makeCloseButton();
      
      public const closed:Signal = new NativeMappedSignal(close,"click");
      
      public function PackageInfoDialog() {
         super();
         addEventListener("addedToStage",this.onAddedToStage);
      }
      
      public function setTitle(param1:String) : PackageInfoDialog {
         this.title.setStringBuilder(new LineBuilder().setParams(param1));
         return this;
      }
      
      public function setBody(param1:String, param2:String) : PackageInfoDialog {
         this.messageTitle.setStringBuilder(new LineBuilder().setParams(param1));
         this.messageBody.setStringBuilder(new LineBuilder().setParams(param2));
         return this;
      }
      
      private function makeBackground() : DisplayObject {
         var _loc1_:PackageBackground = new PackageBackground();
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(18).setColor(11974326).setTextWidth(546).setAutoSize("center").setBold(true);
         _loc1_.y = 8;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeMessageTitle() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(14).setColor(14864077).setTextWidth(416).setAutoSize("center").setBold(true);
         _loc1_.x = 65;
         _loc1_.y = 164;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeMessageBody() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(14).setColor(10914439).setTextWidth(416).setAutoSize("center");
         _loc1_.x = 65;
         _loc1_.y = 210;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeCloseButton() : DeprecatedTextButton {
         var _loc1_:* = null;
         _loc1_ = new DeprecatedTextButton(16,"Close.text",120);
         _loc1_.textChanged.addOnce(this.layoutButton);
         _loc1_.y = 368;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function layoutButton() : void {
         new ButtonLayoutHelper().layout(546,this.close);
      }
      
      private function onAddedToStage(param1:Event) : void {
         removeEventListener("addedToStage",this.onAddedToStage);
         x = (stage.stageWidth - width) / 2;
         y = (stage.stageHeight - height) / 2;
      }
   }
}
