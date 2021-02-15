package com.company.assembleegameclient.ui.panels {
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.IInteractiveObject;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.objects.PremiumVaultContainer;
   import com.company.assembleegameclient.objects.VaultContainer;
   import com.company.assembleegameclient.objects.VaultGiftContainer;
   import com.company.assembleegameclient.ui.panels.itemgrids.ItemGrid;
   import com.company.assembleegameclient.ui.vault.VaultView;
   import flash.display.Sprite;
   import flash.events.Event;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import org.swiftsuspenders.Injector;
   
   public class InteractPanel extends Sprite {
      
      public static const MAX_DIST:Number = 1;
       
      
      public var gs_:GameSprite;
      
      public var player_:Player;
      
      public var w_:int;
      
      public var h_:int;
      
      public var currentPanel:Panel = null;
      
      public var currObj_:IInteractiveObject = null;
      
      public var partyPanel_:PartyPanel;
      
      public var requestInteractive:Function;
      
      private var overridePanel_:Panel;
      
      private var vaultView:Sprite;
      
      private var giftView:Sprite;
      
      private var potView:Sprite;
      
      private var openDialogSignal:OpenDialogSignal;
      
      public function InteractPanel(param1:GameSprite, param2:Player, param3:int, param4:int) {
         super();
         this.gs_ = param1;
         this.player_ = param2;
         this.w_ = param3;
         this.h_ = param4;
         this.partyPanel_ = new PartyPanel(param1);
         var _loc5_:Injector = StaticInjectorContext.getInjector();
         this.openDialogSignal = _loc5_.getInstance(OpenDialogSignal);
      }
      
      public function dispose() : void {
         this.gs_ = null;
         this.player_ = null;
         this.currObj_ = null;
         this.partyPanel_.dispose();
         this.partyPanel_ = null;
         this.overridePanel_ = null;
      }
      
      public function setOverride(param1:Panel) : void {
         if(this.overridePanel_ != null) {
            this.overridePanel_.removeEventListener("complete",this.onComplete);
         }
         this.overridePanel_ = param1;
         this.overridePanel_.addEventListener("complete",this.onComplete);
      }
      
      public function redraw() : void {
         this.currentPanel.draw();
      }
      
      public function draw() : void {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.overridePanel_) {
            this.setPanel(this.overridePanel_);
            this.currentPanel.draw();
            return;
         }
         _loc2_ = this.requestInteractive();
         if(this.currentPanel == null || _loc2_ != this.currObj_) {
            this.currObj_ = _loc2_;
            this.partyPanel_ = new PartyPanel(this.gs_);
            if(this.currObj_) {
               if(this.currObj_ is VaultContainer) {
                  if(!this.vaultView) {
                     this.vaultView = new VaultView("Vault",_loc2_,this.gs_.map.player_);
                     this.vaultView.x = -600;
                     this.gs_.hudView.addChild(this.vaultView);
                  }
                  this.vaultView.visible = true;
               }
               if(this.currObj_ is VaultGiftContainer) {
                  if(!this.giftView) {
                     this.giftView = new VaultView("Gifts",_loc2_,this.gs_.map.player_);
                     this.giftView.x = -600;
                     this.gs_.hudView.addChild(this.giftView);
                  }
                  this.giftView.visible = true;
               }
               if(this.currObj_ is PremiumVaultContainer) {
                  if(!this.potView) {
                     this.potView = new VaultView("Potions",_loc2_,this.gs_.map.player_);
                     this.potView.x = -600;
                     this.gs_.hudView.addChild(this.potView);
                  }
                  this.potView.visible = true;
               }
               _loc1_ = this.currObj_.getPanel(this.gs_);
            } else {
               if(this.vaultView) {
                  this.vaultView.visible = false;
               }
               if(this.giftView) {
                  this.giftView.visible = false;
               }
               if(this.potView) {
                  this.potView.visible = false;
               }
               _loc1_ = this.partyPanel_;
            }
            this.setPanel(_loc1_);
         }
         if(this.currentPanel) {
            this.currentPanel.draw();
         }
      }
      
      public function setPanel(param1:Panel) : void {
         if(param1 != this.currentPanel) {
            this.currentPanel && removeChild(this.currentPanel);
            this.currentPanel = param1;
            this.currentPanel && this.positionPanelAndAdd();
         }
      }
      
      private function positionPanelAndAdd() : void {
         if(this.currentPanel is ItemGrid) {
            this.currentPanel.x = (this.w_ - this.currentPanel.width) * 0.5;
            this.currentPanel.y = 8;
         } else {
            this.currentPanel.x = 6;
            this.currentPanel.y = 8;
         }
         addChild(this.currentPanel);
      }
      
      private function onComplete(param1:Event) : void {
         if(this.overridePanel_) {
            this.overridePanel_.removeEventListener("complete",this.onComplete);
            this.overridePanel_ = null;
         }
         this.setPanel(null);
         this.draw();
      }
   }
}
