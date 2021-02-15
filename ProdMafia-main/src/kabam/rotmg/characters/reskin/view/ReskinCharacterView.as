package kabam.rotmg.characters.reskin.view {
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import kabam.rotmg.classes.view.CharacterSkinListView;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   import kabam.rotmg.util.components.DialogBackground;
   import kabam.rotmg.util.graphics.ButtonLayoutHelper;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class ReskinCharacterView extends Sprite {
      
      private static const MARGIN:int = 10;
      
      private static const DIALOG_WIDTH:int = 462;
      
      private static const BUTTON_WIDTH:int = 120;
      
      private static const BUTTON_FONT:int = 16;
      
      private static const BUTTONS_HEIGHT:int = 40;
      
      private static const TITLE_OFFSET:int = 27;
       
      
      private const layoutListener:SignalWaiter = makeLayoutWaiter();
      
      private const background:DialogBackground = makeBackground();
      
      private const title:TextFieldDisplayConcrete = makeTitle();
      
      private const list:CharacterSkinListView = makeListView();
      
      private const cancel:DeprecatedTextButton = makeCancelButton();
      
      private const select:DeprecatedTextButton = makeSelectButton();
      
      public const cancelled:Signal = new NativeMappedSignal(cancel,"click");
      
      public const selected:Signal = new NativeMappedSignal(select,"click");
      
      public var viewHeight:int;
      
      public function ReskinCharacterView() {
         super();
      }
      
      public function setList(param1:Vector.<DisplayObject>) : void {
         this.list.setItems(param1);
         this.getDialogHeight();
         this.resizeBackground();
         this.positionButtons();
      }
      
      private function makeLayoutWaiter() : SignalWaiter {
         var _loc1_:SignalWaiter = new SignalWaiter();
         _loc1_.complete.add(this.positionButtons);
         return _loc1_;
      }
      
      private function makeBackground() : DialogBackground {
         var _loc1_:DialogBackground = new DialogBackground();
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:TextFieldDisplayConcrete = new TextFieldDisplayConcrete().setSize(18).setColor(11974326).setTextWidth(462);
         _loc1_.setAutoSize("center").setBold(true);
         _loc1_.setStringBuilder(new LineBuilder().setParams("ReskinCharacterView.title"));
         _loc1_.y = 5;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeListView() : CharacterSkinListView {
         var _loc1_:* = null;
         _loc1_ = new CharacterSkinListView();
         _loc1_.x = 10;
         _loc1_.y = 37;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeCancelButton() : DeprecatedTextButton {
         var _loc1_:DeprecatedTextButton = new DeprecatedTextButton(16,"ReskinCharacterView.cancel",120);
         addChild(_loc1_);
         this.layoutListener.push(_loc1_.textChanged);
         return _loc1_;
      }
      
      private function makeSelectButton() : DeprecatedTextButton {
         var _loc1_:DeprecatedTextButton = new DeprecatedTextButton(16,"ReskinCharacterView.select",120);
         addChild(_loc1_);
         this.layoutListener.push(_loc1_.textChanged);
         return _loc1_;
      }
      
      private function getDialogHeight() : void {
         this.viewHeight = Math.min(410,this.list.getListHeight());
         this.viewHeight = this.viewHeight + 87;
      }
      
      private function resizeBackground() : void {
         this.background.draw(462,this.viewHeight);
         this.background.graphics.lineStyle(2,5987163,1,false,"none","none","bevel");
         this.background.graphics.moveTo(1,27);
         this.background.graphics.lineTo(461,27);
      }
      
      private function positionButtons() : void {
         var _loc1_:ButtonLayoutHelper = new ButtonLayoutHelper();
         _loc1_.layout(462,this.cancel,this.select);
         var _loc2_:* = this.viewHeight - 40;
         this.select.y = _loc2_;
         this.cancel.y = _loc2_;
      }
   }
}
