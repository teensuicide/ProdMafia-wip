package kabam.rotmg.arena.view {
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.arena.component.BattleSummaryText;
   import kabam.rotmg.editor.view.StaticTextButton;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.util.components.DialogBackground;
   import org.osflash.signals.Signal;
   
   public class BattleSummaryDialog extends Sprite {
       
      
      private const WIDTH:int = 264;
      
      private const HEIGHT:int = 302;
      
      public const close:Signal = new Signal();
      
      private const background:DialogBackground = makeBackground();
      
      private const splashArt:Class = makeSplashArt();
      
      private var leftSummary:BattleSummaryText;
      
      private var rightSummary:BattleSummaryText;
      
      private var titleText:StaticTextDisplay;
      
      private var closeButton:StaticTextButton;
      
      private var BattleSummarySplash:Class;
      
      public function BattleSummaryDialog() {
         BattleSummarySplash = BattleSummaryDialog_BattleSummarySplash;
         this.titleText = this.makeTitle();
         this.closeButton = this.makeButton();
         super();
         this.drawHorizontalDivide(25);
         this.drawHorizontalDivide(132);
         this.drawHorizontalDivide(252);
         this.makeVerticalDivide();
      }
      
      public function positionThis() : void {
         x = (stage.stageWidth - 264) * 0.5;
         y = (stage.stageHeight - 302) * 0.5;
      }
      
      public function setCurrentRun(param1:int, param2:int) : void {
         if(this.leftSummary) {
            removeChild(this.leftSummary);
         }
         this.leftSummary = new BattleSummaryText("BattleSummaryDialog.currentSubtitle",param1,param2);
         this.leftSummary.y = 60 - this.leftSummary.height / 2 + 132;
         this.leftSummary.x = 66 - this.leftSummary.width / 2;
         addChild(this.leftSummary);
      }
      
      public function setBestRun(param1:int, param2:int) : void {
         if(this.rightSummary) {
            removeChild(this.rightSummary);
         }
         this.rightSummary = new BattleSummaryText("BattleSummaryDialog.bestSubtitle",param1,param2);
         this.rightSummary.y = 60 - this.rightSummary.height / 2 + 132;
         this.rightSummary.x = 66 - this.rightSummary.width / 2 + 132;
         addChild(this.rightSummary);
      }
      
      private function makeBackground() : DialogBackground {
         var _loc1_:DialogBackground = new DialogBackground();
         _loc1_.draw(264,302);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeVerticalDivide() : void {
         this.background.graphics.lineStyle();
         this.background.graphics.beginFill(6710886,1);
         this.background.graphics.drawRect(132,132,2,120);
         this.background.graphics.endFill();
      }
      
      private function drawHorizontalDivide(param1:int) : void {
         this.background.graphics.lineStyle();
         this.background.graphics.beginFill(6710886,1);
         this.background.graphics.drawRect(1,param1,this.background.width - 2,2);
         this.background.graphics.endFill();
      }
      
      private function makeSplashArt() : Class {
         var _loc1_:Class = new this.BattleSummarySplash();
         _loc1_.y = 27;
         _loc1_.x = 2;
         addChild(_loc1_ as Sprite);
         return _loc1_;
      }
      
      private function makeTitle() : StaticTextDisplay {
         var _loc1_:* = null;
         _loc1_ = new StaticTextDisplay();
         _loc1_.setSize(18).setBold(true).setColor(11776947);
         _loc1_.setStringBuilder(new LineBuilder().setParams("BattleSummaryDialog.title"));
         _loc1_.filters = [new DropShadowFilter(0,0,0,1,8,8)];
         _loc1_.x = (264 - _loc1_.width) * 0.5;
         _loc1_.y = 3;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function makeButton() : StaticTextButton {
         var _loc1_:* = null;
         _loc1_ = new StaticTextButton(16,"BattleSummaryDialog.close",100);
         _loc1_.addEventListener("click",this.closeClicked);
         _loc1_.y = 302 - _loc1_.height - 10;
         _loc1_.x = 132 - _loc1_.width / 2;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function closeClicked(param1:MouseEvent) : void {
         this.closeButton.removeEventListener("click",this.closeClicked);
         this.close.dispatch();
      }
   }
}
