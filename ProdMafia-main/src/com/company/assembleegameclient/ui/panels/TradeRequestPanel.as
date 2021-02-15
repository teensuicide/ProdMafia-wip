package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.DropShadowFilter;
   import flash.utils.Timer;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   
   public class TradeRequestPanel extends Panel {
       
      
      public var name_:String;
      
      private var title_:TextFieldDisplayConcrete;
      
      private var rejectButton_:DeprecatedTextButton;
      
      private var acceptButton_:DeprecatedTextButton;
      
      private var timer_:Timer;
      
      public function TradeRequestPanel(param1:AGameSprite, param2:String) {
         super(param1);
         this.name_ = param2;
         this.title_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setTextWidth(188);
         this.title_.setStringBuilder(new LineBuilder().setParams("TradeRequestPanel.wantsTrade",{"name":param2}));
         this.title_.setBold(true);
         this.title_.setWordWrap(true).setMultiLine(true);
         this.title_.setAutoSize("center");
         this.title_.filters = [new DropShadowFilter(0,0,0)];
         this.title_.y = 0;
         addChild(this.title_);
         this.rejectButton_ = new DeprecatedTextButton(16,"Trade.Reject");
         this.rejectButton_.addEventListener("click",this.onRejectClick,false,0,true);
         addChild(this.rejectButton_);
         this.acceptButton_ = new DeprecatedTextButton(16,"Trade.Accept");
         this.acceptButton_.addEventListener("click",this.onAcceptClick,false,0,true);
         addChild(this.acceptButton_);
         this.timer_ = new Timer(20000,1);
         this.timer_.start();
         this.timer_.addEventListener("timer",this.onTimer,false,0,true);
         var _loc3_:SignalWaiter = new SignalWaiter();
         _loc3_.pushArgs(this.rejectButton_.textChanged,this.acceptButton_.textChanged);
         _loc3_.complete.addOnce(this.onComplete);
         addEventListener("addedToStage",this.onAddedToStage,false,0,true);
         addEventListener("removedFromStage",this.onRemovedFromStage,false,0,true);
      }
      
      private function onComplete() : void {
         this.rejectButton_.x = 47 - this.rejectButton_.width / 2;
         this.acceptButton_.x = 141 - this.acceptButton_.width / 2;
         this.rejectButton_.y = 84 - this.rejectButton_.height - 4;
         this.acceptButton_.y = 84 - this.acceptButton_.height - 4;
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("keyDown",this.onKeyDown,false,0,true);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null) {
            dispatchEvent(new Event("complete"));
         }
      }
      
      private function onTimer(param1:TimerEvent) : void {
         dispatchEvent(new Event("complete"));
      }
      
      private function onRejectClick(param1:MouseEvent) : void {
         dispatchEvent(new Event("complete"));
      }
      
      private function onAcceptClick(param1:MouseEvent) : void {
         gs_.gsc_.requestTrade(this.name_);
         dispatchEvent(new Event("complete"));
      }
   }
}
