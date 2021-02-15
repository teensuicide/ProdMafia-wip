package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.Portal;
   import com.company.assembleegameclient.objects.PortalNameParser;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.DeprecatedTextButton;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.text.view.stringBuilder.StringBuilder;
   import kabam.rotmg.ui.view.SignalWaiter;
   import org.osflash.signals.Signal;
   
   public class PortalPanel extends Panel {
       
      
      public const exitGameSignal:Signal = new Signal();
      
      private const waiter:SignalWaiter = new SignalWaiter();
      
      private const LOCKED:String = "Locked ";
      
      private const TEXT_PATTERN:RegExp = /\{"text":"(.+)"}/;
      
      public var owner_:Portal;
      
      private var nameText_:TextFieldDisplayConcrete;
      
      private var fullText_:TextFieldDisplayConcrete;
      
      private var warned:Boolean = false;
      
      private var _enterButton_:DeprecatedTextButton;
      
      public function PortalPanel(param1:GameSprite, param2:Portal) {
         super(param1);
         this.owner_ = param2;
         this.nameText_ = new TextFieldDisplayConcrete().setSize(18).setColor(16777215).setBold(true).setTextWidth(188).setWordWrap(true).setHorizontalAlign("center");
         this.nameText_.filters = [new DropShadowFilter(0,0,0)];
         addChild(this.nameText_);
         this.waiter.push(this.nameText_.textChanged);
         this._enterButton_ = new DeprecatedTextButton(16,"Panel.enter");
         addChild(this._enterButton_);
         this.waiter.push(this._enterButton_.textChanged);
         this.fullText_ = new TextFieldDisplayConcrete().setSize(18).setColor(16711680).setHTML(true).setBold(true).setAutoSize("center");
         var _loc3_:String = !!this.owner_.lockedPortal_?"PortalPanel.locked":"PortalPanel.full";
         this.fullText_.setStringBuilder(new LineBuilder().setParams(_loc3_).setPrefix("<p align=\"center\">").setPostfix("</p>"));
         this.fullText_.filters = [new DropShadowFilter(0,0,0)];
         this.fullText_.textChanged.addOnce(this.alignUI);
         addEventListener("addedToStage",this.onAddedToStage);
         addEventListener("removedFromStage",this.onRemovedFromStage);
         this.waiter.complete.addOnce(this.alignUI);
      }
      
      public function get enterButton_() : DeprecatedTextButton {
         return this._enterButton_;
      }
      
      override public function draw() : void {
         this.updateNameText();
         if(!this.owner_.lockedPortal_ && this.owner_.active_ && contains(this.fullText_)) {
            removeChild(this.fullText_);
            addChild(this._enterButton_);
         } else if((this.owner_.lockedPortal_ || !this.owner_.active_) && contains(this._enterButton_)) {
            removeChild(this._enterButton_);
            addChild(this.fullText_);
         }
      }
      
      private function alignUI() : void {
         this.nameText_.y = 6;
         this._enterButton_.x = 94 - this._enterButton_.width / 2;
         this._enterButton_.y = 84 - this._enterButton_.height - 4;
         this.fullText_.y = 54;
         this.fullText_.x = 94;
      }
      
      private function enterPortal() : void {
         gs_.gsc_.usePortal(this.owner_.objectId_);
         this.exitGameSignal.dispatch();
      }
      
      private function updateNameText() : void {
         var _loc2_:String = this.getName();
         var _loc1_:StringBuilder = new PortalNameParser().makeBuilder(_loc2_);
         this.nameText_.setStringBuilder(_loc1_);
         this.nameText_.x = (188 - this.nameText_.width) * 0.5;
         this.nameText_.y = this.nameText_.height > 30?0:6;
      }
      
      private function getName() : String {
         var _loc1_:String = this.owner_.getName();
         if(this.owner_.lockedPortal_ && _loc1_.indexOf("Locked ") == 0) {
            return _loc1_.substr(7);
         }
         return this.parseJson(_loc1_);
      }
      
      private function parseJson(param1:String) : String {
         var _loc2_:Array = param1.match(this.TEXT_PATTERN);
         return !!_loc2_?_loc2_[1]:param1;
      }
      
      public function onEnterSpriteClick(param1:MouseEvent) : void {
         this.enterPortal();
      }
      
      private function onAddedToStage(param1:Event) : void {
         stage.addEventListener("keyDown",this.onKeyDown);
      }
      
      private function onRemovedFromStage(param1:Event) : void {
         this._enterButton_.removeEventListener("click",this.onEnterSpriteClick);
         stage.removeEventListener("keyDown",this.onKeyDown);
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == Parameters.data.interact && stage.focus == null && !this.owner_.lockedPortal_) {
            this.enterPortal();
         }
      }
   }
}
