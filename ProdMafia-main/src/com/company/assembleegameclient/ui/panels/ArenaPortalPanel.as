package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.AGameSprite;
   import com.company.assembleegameclient.objects.ArenaPortal;
   import com.company.assembleegameclient.objects.Player;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import kabam.rotmg.text.view.StaticTextDisplay;
   import kabam.rotmg.text.view.TextFieldDisplayConcrete;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.util.components.LegacyBuyButton;
   import org.osflash.signals.Signal;
   
   public class ArenaPortalPanel extends Panel {
       
      
      public const purchase:Signal = new Signal(int);
      
      private var owner_:ArenaPortal;
      
      private var openContainer:Sprite;
      
      private var nameText_:StaticTextDisplay;
      
      private var goldButton:LegacyBuyButton;
      
      private var fameButton:LegacyBuyButton;
      
      private var closeContainer:Sprite;
      
      private var closeNameText:TextFieldDisplayConcrete;
      
      private var closedText:StaticTextDisplay;
      
      public function ArenaPortalPanel(param1:AGameSprite, param2:ArenaPortal) {
         openContainer = new Sprite();
         closeContainer = new Sprite();
         super(param1);
         this.owner_ = param2;
         addChild(this.openContainer);
         addChild(this.closeContainer);
         if(gs_.map == null || gs_.map.player_ == null) {
            return;
         }
         var _loc3_:Player = gs_.map.player_;
         this.nameText_ = this.makeTitle();
         this.openContainer.addChild(this.nameText_);
         this.goldButton = new LegacyBuyButton("",20,51,0);
         this.goldButton.addEventListener("click",this.onGoldClick,false,0,true);
         this.openContainer.addChild(this.goldButton);
         this.fameButton = new LegacyBuyButton("",20,250,1);
         if(_loc3_.fame_ < 250) {
            this.fameButton.setEnabled(false);
         } else {
            this.fameButton.addEventListener("click",this.onFameClick,false,0,true);
         }
         this.openContainer.addChild(this.fameButton);
         this.fameButton.readyForPlacement.addOnce(this.alignUI);
         this.closedText = new StaticTextDisplay();
         this.closedText.setSize(18).setColor(16711680).setTextWidth(188).setWordWrap(true).setMultiLine(true).setAutoSize("center").setBold(true).setHTML(true);
         this.closedText.setStringBuilder(new LineBuilder().setParams("PortalPanel.full").setPrefix("<p align=\"center\">").setPostfix("</p>"));
         this.closedText.filters = [new DropShadowFilter(0,0,0)];
         this.closedText.y = 39;
         this.closeContainer.addChild(this.closedText);
         this.closeNameText = this.makeTitle();
         this.closeContainer.addChild(this.closeNameText);
      }
      
      override public function draw() : void {
         this.openContainer.visible = this.owner_.active_;
         this.closeContainer.visible = !this.owner_.active_;
      }
      
      private function alignUI() : void {
         this.goldButton.x = 47 - this.goldButton.width / 2;
         this.goldButton.y = 84 - this.goldButton.height - 4;
         this.fameButton.x = 141 - this.fameButton.width / 2;
         this.fameButton.y = 84 - this.fameButton.height - 4;
      }
      
      private function makeTitle() : StaticTextDisplay {
         var _loc1_:* = null;
         _loc1_ = new StaticTextDisplay();
         _loc1_.setSize(18).setColor(16777215).setTextWidth(188).setWordWrap(true).setMultiLine(true).setAutoSize("center").setBold(true).setHTML(true);
         _loc1_.setStringBuilder(new LineBuilder().setParams("ArenaPortalPanel.title").setPrefix("<p align=\"center\">").setPostfix("</p>"));
         _loc1_.filters = [new DropShadowFilter(0,0,0)];
         _loc1_.y = 6;
         return _loc1_;
      }
      
      private function onGoldClick(param1:MouseEvent) : void {
         this.purchase.dispatch(0);
      }
      
      private function onFameClick(param1:MouseEvent) : void {
         this.purchase.dispatch(1);
      }
   }
}
