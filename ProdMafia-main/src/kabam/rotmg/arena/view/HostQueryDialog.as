package kabam.rotmg.arena.view {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import kabam.rotmg.arena.component.ArenaQueryDialogHost;
   import kabam.rotmg.arena.util.ArenaViewAssetFactory;
   import kabam.rotmg.pets.view.components.PopupWindowBackground;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   import kabam.rotmg.util.graphics.ButtonLayoutHelper;
   import org.osflash.signals.natives.NativeSignal;
   
   public class HostQueryDialog extends Sprite {
      
      public static const WIDTH:int = 274;
      
      public static const HEIGHT:int = 338;
      
      public static const TITLE:String = "ArenaQueryPanel.title";
      
      public static const CLOSE:String = "Close.text";
      
      public static const QUERY:String = "ArenaQueryDialog.info";
      
      public static const BACK:String = "Screens.back";
       
      
      private const layoutWaiter:SignalWaiter = makeDeferredLayout();
      
      private const container:DisplayObjectContainer = makeContainer();
      
      private const background:PopupWindowBackground = makeBackground();
      
      private const host:ArenaQueryDialogHost = makeHost();
      
      private const title:TextFieldDisplayConcrete = makeTitle();
      
      private const backButton:DeprecatedTextButton = makeBackButton();
      
      public const backClick:NativeSignal = new NativeSignal(backButton,"click");
      
      public function HostQueryDialog() {
         super();
      }
      
      public function setHostIcon(param1:BitmapData) : void {
         this.host.setHostIcon(param1);
      }
      
      private function makeDeferredLayout() : SignalWaiter {
         var _loc1_:SignalWaiter = new SignalWaiter();
         _loc1_.complete.addOnce(this.onLayout);
         return _loc1_;
      }
      
      private function onLayout() : void {
         var _loc1_:ButtonLayoutHelper = new ButtonLayoutHelper();
         _loc1_.layout(274,this.backButton);
      }
      
      private function makeContainer() : DisplayObjectContainer {
         var _loc1_:* = null;
         _loc1_ = new Sprite();
         _loc1_.x = 263;
         _loc1_.y = 131;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeBackground() : PopupWindowBackground {
         var _loc1_:PopupWindowBackground = new PopupWindowBackground();
         _loc1_.draw(274,338);
         _loc1_.divide("HORIZONTAL_DIVISION",34);
         this.container.addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeHost() : ArenaQueryDialogHost {
         var _loc1_:* = null;
         _loc1_ = new ArenaQueryDialogHost();
         _loc1_.x = 20;
         _loc1_.y = 50;
         this.container.addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = ArenaViewAssetFactory.returnTextfield(16777215,18,true);
         _loc1_.setStringBuilder(new LineBuilder().setParams("ArenaQueryPanel.title"));
         _loc1_.setAutoSize("center");
         _loc1_.x = 137;
         _loc1_.y = 24;
         this.container.addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeBackButton() : DeprecatedTextButton {
         var _loc1_:* = null;
         _loc1_ = new DeprecatedTextButton(16,"Screens.back",80);
         this.container.addChild(_loc1_);
         this.layoutWaiter.push(_loc1_.textChanged);
         _loc1_.y = 292;
         return _loc1_;
      }
      
      private function makeCloseButton() : DeprecatedTextButton {
         var _loc1_:* = null;
         _loc1_ = new DeprecatedTextButton(16,"Close.text",110);
         _loc1_.y = 292;
         this.container.addChild(_loc1_);
         this.layoutWaiter.push(_loc1_.textChanged);
         return _loc1_;
      }
   }
}
