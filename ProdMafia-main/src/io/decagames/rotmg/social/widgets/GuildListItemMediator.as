package io.decagames.rotmg.social.widgets {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.game.events.GuildResultEvent;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.dialogs.Dialog;
   import com.company.assembleegameclient.util.GuildUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.social.model.SocialModel;
   import io.decagames.rotmg.social.signals.RefreshListSignal;
   import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
   import kabam.rotmg.chat.control.ShowChatInputSignal;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.game.signals.PlayGameSignal;
   import kabam.rotmg.messaging.impl.GameServerConnection;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.model.HUDModel;
   import kabam.rotmg.ui.signals.EnterGameSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class GuildListItemMediator extends Mediator {
       
      
      [Inject]
      public var view:GuildListItem;
      
      [Inject]
      public var enterGame:EnterGameSignal;
      
      [Inject]
      public var socialModel:SocialModel;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var playGame:PlayGameSignal;
      
      [Inject]
      public var chatSignal:ShowChatInputSignal;
      
      [Inject]
      public var closeCurrentPopup:CloseCurrentPopupSignal;
      
      [Inject]
      public var refreshSignal:RefreshListSignal;
      
      [Inject]
      public var openDialogSignal:OpenDialogSignal;
      
      [Inject]
      public var closeDialogsSignal:CloseDialogsSignal;
      
      [Inject]
      public var hudModel:HUDModel;
      
      private var _gameServerConnection:GameServerConnection;
      
      private var _gameSprite:GameSprite;
      
      public function GuildListItemMediator() {
         super();
      }
      
      override public function initialize() : void {
         this._gameSprite = this.hudModel.gameSprite;
         this._gameServerConnection = this._gameSprite.gsc_;
         if(this.view.removeButton) {
            this.view.removeButton.addEventListener("click",this.onRemoveClick);
         }
         if(this.view.messageButton) {
            this.view.messageButton.addEventListener("click",this.onMessageClick);
         }
         if(this.view.teleportButton) {
            this.view.teleportButton.addEventListener("click",this.onTeleportClick);
         }
         if(this.view.promoteButton) {
            this.view.promoteButton.addEventListener("click",this.onPromoteClick);
         }
         if(this.view.demoteButton) {
            this.view.demoteButton.addEventListener("click",this.onDemoteClick);
         }
      }
      
      private function onRemoveClick(param1:MouseEvent) : void {
         var _loc2_:Dialog = new Dialog("","","Guild.RemoveLeft","Guild.RemoveRight","/removeFromGuild");
         _loc2_.setTextParams("Guild.RemoveText",{"name":this.view.getLabelText()});
         _loc2_.setTitleStringBuilder(new LineBuilder().setParams("Guild.RemoveTitle",{"name":this.view.getLabelText()}));
         _loc2_.addEventListener("dialogLeftButton",this.onCancelDialog);
         _loc2_.addEventListener("dialogRightButton",this.onVerifiedRemove);
         this.openDialogSignal.dispatch(_loc2_);
      }
      
      private function onVerifiedRemove(param1:Event) : void {
         this.closeDialogsSignal.dispatch();
         this._gameSprite.addEventListener("GUILDRESULTEVENT",this.onRemoveResult);
         this._gameServerConnection.guildRemove(this.view.getLabelText());
      }
      
      private function onRemoveResult(param1:GuildResultEvent) : void {
         this._gameSprite.removeEventListener("GUILDRESULTEVENT",this.onRemoveResult);
         if(param1.success_) {
            this.socialModel.removeGuildMember(this.view.getLabelText());
            this.refreshSignal.dispatch("RefreshListSignal.CONTEXT_GUILD_LIST",param1.success_);
         }
      }
      
      private function onCancelDialog(param1:Event) : void {
         this.closeDialogsSignal.dispatch();
      }
      
      private function onTeleportClick(param1:MouseEvent) : void {
         var _loc4_:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
         Parameters.data.preferredServer = this.view.guildMemberVO.serverName;
         Parameters.save();
         this.enterGame.dispatch();
         var _loc3_:GameInitData = new GameInitData();
         _loc3_.createCharacter = false;
         _loc3_.charId = _loc4_.charId();
         _loc3_.isNewGame = true;
         this.playGame.dispatch(_loc3_);
         this.closeCurrentPopup.dispatch();
      }
      
      private function onMessageClick(param1:MouseEvent) : void {
         this.chatSignal.dispatch(true,"/tell " + this.view.getLabelText() + " ");
         this.closeCurrentPopup.dispatch();
      }
      
      private function onPromoteClick(param1:MouseEvent) : void {
         var _loc2_:String = GuildUtil.rankToString(GuildUtil.promotedRank(this.view.guildMemberVO.rank));
         var _loc3_:Dialog = new Dialog("","","Guild.PromoteLeftButton","Guild.PromoteRightButton","/promote");
         _loc3_.setTextParams("Guild.PromoteText",{
            "name":this.view.getLabelText(),
            "rank":_loc2_
         });
         _loc3_.setTitleStringBuilder(new LineBuilder().setParams("Guild.PromoteTitle",{"name":this.view.getLabelText()}));
         _loc3_.addEventListener("dialogLeftButton",this.onCancelDialog);
         _loc3_.addEventListener("dialogRightButton",this.onVerifiedPromote);
         this.openDialogSignal.dispatch(_loc3_);
      }
      
      private function onVerifiedPromote(param1:Event) : void {
         this.closeDialogsSignal.dispatch();
         this._gameSprite.addEventListener("GUILDRESULTEVENT",this.onSetRankResult);
         this._gameServerConnection.changeGuildRank(this.view.getLabelText(),GuildUtil.promotedRank(this.view.guildMemberVO.rank));
      }
      
      private function onSetRankResult(param1:GuildResultEvent) : void {
         this._gameSprite.removeEventListener("GUILDRESULTEVENT",this.onSetRankResult);
         if(param1.success_) {
            this.socialModel.loadGuildData();
         }
      }
      
      private function onDemoteClick(param1:MouseEvent) : void {
         var _loc2_:String = GuildUtil.rankToString(GuildUtil.demotedRank(this.view.guildMemberVO.rank));
         var _loc3_:Dialog = new Dialog("","","Guild.DemoteLeft","Guild.DemoteRight","/demote");
         _loc3_.setTextParams("Guild.DemoteText",{
            "name":this.view.getLabelText(),
            "rank":_loc2_
         });
         _loc3_.setTitleStringBuilder(new LineBuilder().setParams("Guild.DemoteTitle",{"name":this.view.getLabelText()}));
         _loc3_.addEventListener("dialogLeftButton",this.onCancelDialog);
         _loc3_.addEventListener("dialogRightButton",this.onVerifiedDemote);
         this.openDialogSignal.dispatch(_loc3_);
      }
      
      private function onVerifiedDemote(param1:Event) : void {
         this.closeDialogsSignal.dispatch();
         this._gameSprite.addEventListener("GUILDRESULTEVENT",this.onSetRankResult);
         this._gameServerConnection.changeGuildRank(this.view.getLabelText(),GuildUtil.demotedRank(this.view.guildMemberVO.rank));
      }
   }
}
