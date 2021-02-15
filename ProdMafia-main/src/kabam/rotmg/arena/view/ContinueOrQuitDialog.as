package kabam.rotmg.arena.view {
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.editor.view.StaticTextButton;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StaticStringBuilder;
   import kabam.rotmg.util.components.DialogBackground;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import org.osflash.signals.Signal;
   
   public class ContinueOrQuitDialog extends Sprite {
       
      
      public const quit:Signal = new Signal();
      
      public const buyContinue:Signal = new Signal(int,int);
      
      private const WIDTH:int = 350;
      
      private const HEIGHT:int = 150;
      
      private const background:DialogBackground = makeBackground();
      
      private const title:StaticTextDisplay = makeTitle();
      
      private const quitSubtitle:StaticTextDisplay = makeSubtitle();
      
      private const quitButton:StaticTextButton = makeQuitButton();
      
      private const continueButton:LegacyBuyButton = makeContinueButton();
      
      private const restartSubtitle:StaticTextDisplay = makeSubtitle();
      
      private const processingText:StaticTextDisplay = makeSubtitle();
      
      private var cost:int;
      
      public function ContinueOrQuitDialog(param1:int, param2:Boolean) {
         super();
         this.cost = param1;
         this.continueButton.setPrice(param1,0);
         this.setProcessing(param2);
      }
      
      public function init(param1:int, param2:int) : void {
         this.positionThis();
         this.quitButton.addEventListener("click",this.onQuit);
         this.continueButton.addEventListener("click",this.onBuyContinue);
         this.quitSubtitle.setStringBuilder(new LineBuilder().setParams("ContinueOrQuitDialog.quitSubtitle"));
         this.restartSubtitle.setStringBuilder(new LineBuilder().setParams("ContinueOrQuitDialog.continueSubtitle",{"waveNumber":param1.toString()}));
         this.processingText.setStringBuilder(new StaticStringBuilder("Processing"));
         this.processingText.visible = false;
         this.align();
         this.makeHorizontalLine();
         this.makeVerticalLine();
      }
      
      public function setProcessing(param1:Boolean) : void {
         this.processingText.visible = param1;
         this.continueButton.visible = !param1;
      }
      
      public function destroy() : void {
         this.quitButton.removeEventListener("click",this.onQuit);
         this.continueButton.removeEventListener("click",this.onBuyContinue);
      }
      
      private function align() : void {
         this.quitSubtitle.x = 70 - this.quitSubtitle.width / 2;
         this.quitSubtitle.y = 85;
         this.quitButton.x = 70 - this.quitButton.width / 2;
         this.quitButton.y = 110;
         this.restartSubtitle.x = 105 - this.restartSubtitle.width / 2 + 140;
         this.restartSubtitle.y = 85;
         this.continueButton.x = 105 - this.continueButton.width / 2 + 140;
         this.continueButton.y = 110;
         this.processingText.x = 105 - this.processingText.width / 2 + 140;
         this.processingText.y = 110;
      }
      
      private function positionThis() : void {
         x = (stage.stageWidth - 350) * 0.5;
         y = (stage.stageHeight - 150) * 0.5;
      }
      
      private function makeBackground() : DialogBackground {
         var _loc1_:DialogBackground = new DialogBackground();
         _loc1_.draw(350,150);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeTitle() : StaticTextDisplay {
         var _loc1_:StaticTextDisplay = new StaticTextDisplay();
         _loc1_.setSize(20).setBold(true).setColor(11776947);
         _loc1_.setStringBuilder(new LineBuilder().setParams("ContinueOrQuitDialog.title"));
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         _loc1_.x = (350 - _loc1_.width) * 0.5;
         _loc1_.y = 25;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeHorizontalLine() : void {
         this.background.graphics.lineStyle();
         this.background.graphics.beginFill(6710886,1);
         this.background.graphics.drawRect(1,70,this.background.width - 2,2);
         this.background.graphics.endFill();
      }
      
      private function makeVerticalLine() : void {
         this.background.graphics.lineStyle();
         this.background.graphics.beginFill(6710886,1);
         this.background.graphics.drawRect(140,70,2,84);
         this.background.graphics.endFill();
      }
      
      private function makeQuitButton() : StaticTextButton {
         var _loc1_:StaticTextButton = new StaticTextButton(15,"ContinueOrQuitDialog.exit");
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeContinueButton() : LegacyBuyButton {
         var _loc1_:LegacyBuyButton = new LegacyBuyButton("",15,this.cost,0);
         _loc1_.readyForPlacement.addOnce(this.align);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeSubtitle() : StaticTextDisplay {
         var _loc1_:StaticTextDisplay = new StaticTextDisplay();
         _loc1_.setSize(15).setColor(16777215).setBold(true);
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function onQuit(param1:MouseEvent) : void {
         this.quit.dispatch();
      }
      
      private function onBuyContinue(param1:MouseEvent) : void {
         this.buyContinue.dispatch(0,this.cost);
      }
   }
}
