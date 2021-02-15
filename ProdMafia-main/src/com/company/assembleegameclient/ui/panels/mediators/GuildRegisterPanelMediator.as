package com.company.assembleegameclient.ui.panels.mediators {
   import com.company.assembleegameclient.account.ui.CreateGuildFrame;
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.objects.Player;
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.assembleegameclient.ui.panels.GuildRegisterPanel;
   import flash.events.Event;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.ui.model.HUDModel;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class GuildRegisterPanelMediator extends Mediator {
       
      
      [Inject]
      public var view:GuildRegisterPanel;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var closeDialog:CloseDialogsSignal;
      
      [Inject]
      public var hudModel:HUDModel;
      
      public function GuildRegisterPanelMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.openCreateGuildFrame.add(this.onDispatchCreateGuildFrame);
         this.view.renounce.add(this.onRenounceClick);
      }
      
      override public function destroy() : void {
         this.view.openCreateGuildFrame.remove(this.onDispatchCreateGuildFrame);
         this.view.renounce.remove(this.onRenounceClick);
      }
      
      public function onRenounceClick() : void {
         var _loc2_:GameSprite = this.hudModel.gameSprite;
         if(_loc2_.map == null || _loc2_.map.player_ == null) {
            return;
         }
         var _loc1_:Player = _loc2_.map.player_;
         var _loc3_:Dialog = new Dialog("RenounceDialog.subTitle","RenounceDialog.title","RenounceDialog.cancel","RenounceDialog.accept","/renounceGuild");
         _loc3_.setTextParams("RenounceDialog.title",{"guildName":_loc1_.guildName_});
         _loc3_.addEventListener("dialogLeftButton",this.onRenounce);
         _loc3_.addEventListener("dialogRightButton",this.onCancel);
         this.openDialog.dispatch(_loc3_);
      }
      
      private function onDispatchCreateGuildFrame() : void {
         this.openDialog.dispatch(new CreateGuildFrame(this.hudModel.gameSprite));
      }
      
      private function onCancel(param1:Event) : void {
         this.closeDialog.dispatch();
      }
      
      private function onRenounce(param1:Event) : void {
         var _loc2_:GameSprite = this.hudModel.gameSprite;
         if(_loc2_.map == null || _loc2_.map.player_ == null) {
            return;
         }
         var _loc3_:Player = _loc2_.map.player_;
         _loc2_.gsc_.guildRemove(_loc3_.name_);
         this.closeDialog.dispatch();
      }
   }
}
