package kabam.rotmg.characters.reskin.view {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import com.company.assembleegameclient.ui.panels.Panel;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import org.osflash.signals.Signal;
   import org.osflash.signals.natives.NativeMappedSignal;
   
   public class ReskinPanel extends Panel {
       
      
      private const title:TextFieldDisplayConcrete = makeTitle();
      
      private const button:DeprecatedTextButton = makeButton();
      
      private const click:Signal = new NativeMappedSignal(button,"click");
      
      public const reskin:Signal = new Signal();
      
      public function ReskinPanel(param1:GameSprite = null) {
         super(param1);
         this.click.add(this.onClick);
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
      }
      
      private function onClick() : void {
         this.reskin.dispatch();
      }
      
      private function makeTitle() : TextFieldDisplayConcrete {
         var _loc1_:* = null;
         _loc1_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setAutoSize("center");
         _loc1_.x = 94;
         _loc1_.y = 6;
         _loc1_.setBold(true);
         _loc1_.filters = [new DropShadowFilter(0,0,0)];
         _loc1_.setStringBuilder(new LineBuilder().setParams("ReskinPanel.changeSkin"));
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeButton() : DeprecatedTextButton {
         var _loc1_:DeprecatedTextButton = new DeprecatedTextButton(16,"ReskinPanel.choose");
         _loc1_.textChanged.addOnce(this.onTextSet);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function onTextSet() : void {
         this.button.x = 94 - this.button.width * 0.5;
         this.button.y = 84 - this.button.height - 4;
      }
      
      private function onAddedToStage(param1:Event) : void {
         removeEventListener("addedToStage",this.onAddedToStage);
         stage.addEventListener("keyDown",this.onKeyDown);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         removeEventListener("removedFromStage",this.onRemovedFromStage);
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            this.reskin.dispatch();
         }
      }
   }
}
