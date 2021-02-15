package io.decagames.rotmg.social.widgets {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import flash.events.MouseEvent;
   import io.decagames.rotmg.social.model.FriendRequestVO;
   import io.decagames.rotmg.social.model.SocialModel;
   import io.decagames.rotmg.social.signals.FriendActionSignal;
   import io.decagames.rotmg.social.signals.RefreshListSignal;
   import io.decagames.rotmg.ui.buttons.BaseButton;
   import io.decagames.rotmg.ui.popups.modal.ConfirmationModal;
   import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
   import io.decagames.rotmg.ui.popups.signals.CloseCurrentPopupSignal;
   import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.chat.control.ShowChatInputSignal;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.game.signals.PlayGameSignal;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   import kabam.rotmg.ui.signals.EnterGameSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class FriendListItemMediator extends Mediator {
       
      
      [Inject]
      public var view:FriendListItem;
      
      [Inject]
      public var showPopupSignal:ShowPopupSignal;
      
      [Inject]
      public var showFade:ShowLockFade;
      
      [Inject]
      public var friendsAction:FriendActionSignal;
      
      [Inject]
      public var showPopup:ShowPopupSignal;
      
      [Inject]
      public var removeFade:RemoveLockFade;
      
      [Inject]
      public var model:SocialModel;
      
      [Inject]
      public var refreshSignal:RefreshListSignal;
      
      [Inject]
      public var chatSignal:ShowChatInputSignal;
      
      [Inject]
      public var closeCurrentPopup:CloseCurrentPopupSignal;
      
      [Inject]
      public var enterGame:EnterGameSignal;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var playGame:PlayGameSignal;
      
      public function FriendListItemMediator() {
         super();
      }
      
      override public function initialize() : void {
         if(this.view.removeButton) {
            this.view.removeButton.addEventListener("click",this.onRemoveClick);
         }
         if(this.view.acceptButton) {
            this.view.acceptButton.addEventListener("click",this.onAcceptClick);
         }
         if(this.view.rejectButton) {
            this.view.rejectButton.addEventListener("click",this.onRejectClick);
         }
         if(this.view.messageButton) {
            this.view.messageButton.addEventListener("click",this.onMessageClick);
         }
         if(this.view.teleportButton) {
            this.view.teleportButton.addEventListener("click",this.onTeleportClick);
         }
         if(this.view.blockButton) {
            this.view.blockButton.addEventListener("click",this.onBlockClick);
         }
      }
      
      override public function destroy() : void {
         if(this.view.removeButton) {
            this.view.removeButton.removeEventListener("click",this.onRemoveClick);
         }
         if(this.view.acceptButton) {
            this.view.acceptButton.removeEventListener("click",this.onAcceptClick);
         }
         if(this.view.rejectButton) {
            this.view.rejectButton.removeEventListener("click",this.onRejectClick);
         }
         if(this.view.messageButton) {
            this.view.messageButton.removeEventListener("click",this.onMessageClick);
         }
         if(this.view.teleportButton) {
            this.view.teleportButton.removeEventListener("click",this.onTeleportClick);
         }
         if(this.view.blockButton) {
            this.view.blockButton.removeEventListener("click",this.onBlockClick);
         }
      }
      
      private function onRemoveConfirmed(param1:BaseButton) : void {
         var _loc2_:FriendRequestVO = new FriendRequestVO("/removeFriend",this.view.getLabelText(),this.onRemoveCallback);
         this.friendsAction.dispatch(_loc2_);
         this.showFade.dispatch();
      }
      
      private function onBlockConfirmed(param1:BaseButton) : void {
         var _loc2_:FriendRequestVO = new FriendRequestVO("/blockRequest",this.view.getLabelText(),this.onBlockCallback);
         this.friendsAction.dispatch(_loc2_);
         this.showFade.dispatch();
      }
      
      private function onRemoveCallback(param1:Boolean, param2:Object, param3:String) : void {
         if(param1) {
            this.model.removeFriend(param3);
         } else {
            this.showPopup.dispatch(new ErrorModal(350,"Friends List Error",LineBuilder.getLocalizedStringFromKey(String(param2))));
         }
         this.removeFade.dispatch();
         this.refreshSignal.dispatch("RefreshListSignal.CONTEXT_FRIENDS_LIST",param1);
      }
      
      private function onBlockCallback(param1:Boolean, param2:Object, param3:String) : void {
         if(param1) {
            this.model.removeInvitation(param3);
         } else {
            this.showPopup.dispatch(new ErrorModal(350,"Friends List Error",LineBuilder.getLocalizedStringFromKey(String(param2))));
         }
         this.removeFade.dispatch();
         this.refreshSignal.dispatch("RefreshListSignal.CONTEXT_FRIENDS_LIST",param1);
      }
      
      private function onAcceptCallback(param1:Boolean, param2:Object, param3:String) : void {
         if(param1) {
            this.model.removeInvitation(param3);
            this.model.seedFriends(XML(param2));
         } else {
            this.showPopup.dispatch(new ErrorModal(350,"Friends List Error",LineBuilder.getLocalizedStringFromKey(String(param2))));
         }
         this.removeFade.dispatch();
         this.refreshSignal.dispatch("RefreshListSignal.CONTEXT_FRIENDS_LIST",param1);
      }
      
      private function onRejectCallback(param1:Boolean, param2:Object, param3:String) : void {
         if(param1) {
            this.model.removeInvitation(param3);
         } else {
            this.showPopup.dispatch(new ErrorModal(350,"Friends List Error",LineBuilder.getLocalizedStringFromKey(String(param2))));
         }
         this.removeFade.dispatch();
         this.refreshSignal.dispatch("RefreshListSignal.CONTEXT_FRIENDS_LIST",param1);
      }
      
      private function onMessageClick(param1:MouseEvent) : void {
         this.chatSignal.dispatch(true,"/tell " + this.view.getLabelText() + " ");
         this.closeCurrentPopup.dispatch();
      }
      
      private function onTeleportClick(param1:MouseEvent) : void {
         var _loc3_:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
         Parameters.data.preferredServer = this.view.vo.getServerName();
         Parameters.save();
         this.enterGame.dispatch();
         var _loc2_:GameInitData = new GameInitData();
         _loc2_.createCharacter = false;
         _loc2_.charId = _loc3_.charId();
         _loc2_.isNewGame = true;
         this.playGame.dispatch(_loc2_);
         this.closeCurrentPopup.dispatch();
      }
      
      private function onRemoveClick(param1:MouseEvent) : void {
         var _loc2_:ConfirmationModal = new ConfirmationModal(350,LineBuilder.getLocalizedStringFromKey("Friend.RemoveTitle"),LineBuilder.getLocalizedStringFromKey("Friend.RemoveText",{"name":this.view.getLabelText()}),LineBuilder.getLocalizedStringFromKey("Friend.RemoveRight"),LineBuilder.getLocalizedStringFromKey("Frame.cancel"),130);
         _loc2_.confirmButton.clickSignal.addOnce(this.onRemoveConfirmed);
         this.showPopupSignal.dispatch(_loc2_);
      }
      
      private function onAcceptClick(param1:MouseEvent) : void {
         var _loc2_:FriendRequestVO = new FriendRequestVO("/acceptRequest",this.view.getLabelText(),this.onAcceptCallback);
         this.friendsAction.dispatch(_loc2_);
         this.showFade.dispatch();
      }
      
      private function onRejectClick(param1:MouseEvent) : void {
         var _loc2_:FriendRequestVO = new FriendRequestVO("/rejectRequest",this.view.getLabelText(),this.onRejectCallback);
         this.friendsAction.dispatch(_loc2_);
         this.showFade.dispatch();
      }
      
      private function onBlockClick(param1:MouseEvent) : void {
         var _loc2_:ConfirmationModal = new ConfirmationModal(350,LineBuilder.getLocalizedStringFromKey("Friend.BlockTitle"),LineBuilder.getLocalizedStringFromKey("Friend.BlockText",{"name":this.view.getLabelText()}),LineBuilder.getLocalizedStringFromKey("Friend.BlockRight"),LineBuilder.getLocalizedStringFromKey("Frame.cancel"),130);
         _loc2_.confirmButton.clickSignal.addOnce(this.onBlockConfirmed);
         this.showPopupSignal.dispatch(_loc2_);
      }
   }
}
