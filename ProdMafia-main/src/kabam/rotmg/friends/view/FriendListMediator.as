package kabam.rotmg.friends.view {
   import com.company.assembleegameclient.appengine.SavedCharacter;
   import com.company.assembleegameclient.parameters.Parameters;
   import com.company.assembleegameclient.ui.dialogs.ErrorDialog;
   import io.decagames.rotmg.social.model.FriendRequestVO;
   import io.decagames.rotmg.social.model.SocialModel;
   import io.decagames.rotmg.social.signals.FriendActionSignal;
   import kabam.rotmg.chat.control.ShowChatInputSignal;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.game.signals.PlayGameSignal;
   import kabam.rotmg.ui.signals.EnterGameSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class FriendListMediator extends Mediator {
       
      
      [Inject]
      public var view:FriendListView;
      
      [Inject]
      public var model:SocialModel;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var closeDialog:CloseDialogsSignal;
      
      [Inject]
      public var actionSignal:FriendActionSignal;
      
      [Inject]
      public var chatSignal:ShowChatInputSignal;
      
      [Inject]
      public var enterGame:EnterGameSignal;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var playGame:PlayGameSignal;
      
      public function FriendListMediator() {
         super();
      }
      
      override public function initialize() : void {
         this.view.actionSignal.add(this.onFriendActed);
         this.view.tabSignal.add(this.onTabSwitched);
         this.model.socialDataSignal.add(this.initView);
         this.model.loadFriendsData();
      }
      
      override public function destroy() : void {
         this.view.actionSignal.removeAll();
         this.view.tabSignal.removeAll();
      }
      
      private function initView(param1:Boolean = false) : void {
         if(param1) {
            this.view.init(this.model.friendsList,this.model.getAllInvitations(),this.model.getCurrentServerName());
         }
      }
      
      private function reportError(param1:String) : void {
         this.openDialog.dispatch(new ErrorDialog(param1));
      }
      
      private function onTabSwitched(param1:String) : void {
         var _loc2_:* = param1;
         var _loc3_:* = _loc2_;
         switch(_loc3_) {
            case "Friends":
               this.view.updateFriendTab(this.model.friendsList,this.model.getCurrentServerName());
               return;
            case "Invitations":
               this.view.updateInvitationTab(this.model.getAllInvitations());
               return;
            default:
               return;
         }
      }
      
      private function onFriendActed(param1:String, param2:String) : void {
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc6_:FriendRequestVO = new FriendRequestVO(param1,param2);
         var _loc4_:* = param1;
         var _loc7_:* = _loc4_;
         switch(_loc7_) {
            case "searchFriend":
               if(param2 != null && param2 != "") {
                  this.view.updateFriendTab(this.model.getFilterFriends(param2),this.model.getCurrentServerName());
               } else if(param2 == "") {
                  this.view.updateFriendTab(this.model.friendsList,this.model.getCurrentServerName());
               }
               return;
            case "/requestFriend":
               if(this.model.ifReachMax()) {
                  this.view.updateInput("Friend.ReachCapacity");
                  return;
               }
               _loc6_.callback = this.inviteFriendCallback;
            case "/removeFriend":
               _loc6_.callback = this.removeFriendCallback;
               _loc5_ = "Friend.RemoveTitle";
               _loc3_ = "Friend.RemoveText";
               this.openDialog.dispatch(new FriendUpdateConfirmDialog(_loc5_,_loc3_,"Frame.cancel","Friend.RemoveRight",_loc6_,{"name":_loc6_.target}));
               return;
            case "/acceptRequest":
               _loc6_.callback = this.acceptInvitationCallback;
            case "/rejectRequest":
               _loc6_.callback = this.rejectInvitationCallback;
            default:
               this.actionSignal.dispatch(_loc6_);
               return;
            case "/blockRequest":
               _loc6_.callback = this.blockInvitationCallback;
               _loc5_ = "Friend.BlockTitle";
               _loc3_ = "Friend.BlockText";
               this.openDialog.dispatch(new FriendUpdateConfirmDialog(_loc5_,_loc3_,"Frame.cancel","Friend.BlockRight",_loc6_,{"name":_loc6_.target}));
               return;
            case "Whisper":
               this.whisperCallback(param2);
               return;
            case "JumpServer":
               this.jumpCallback(param2);
               return;
         }
      }
      
      private function inviteFriendCallback(param1:Boolean, param2:String, param3:String) : void {
         if(param1) {
            this.view.updateInput("Friend.SentInvitationText",{"name":param3});
         } else if(param2 == "Blocked") {
            this.view.updateInput("Friend.SentInvitationText",{"name":param3});
         } else {
            this.view.updateInput(param2);
         }
      }
      
      private function removeFriendCallback(param1:Boolean, param2:String, param3:String) : void {
         if(param1) {
            this.model.removeFriend(param3);
         } else {
            this.reportError(param2);
         }
      }
      
      private function acceptInvitationCallback(param1:Boolean, param2:String, param3:String) : void {
         if(param1) {
            this.model.seedFriends(XML(param2));
            if(this.model.removeInvitation(param3)) {
               this.view.updateInvitationTab(this.model.getAllInvitations());
            }
         } else {
            this.reportError(param2);
         }
      }
      
      private function rejectInvitationCallback(param1:Boolean, param2:String, param3:String) : void {
         if(param1) {
            if(this.model.removeInvitation(param3)) {
               this.view.updateInvitationTab(this.model.getAllInvitations());
            }
         } else {
            this.reportError(param2);
         }
      }
      
      private function blockInvitationCallback(param1:String) : void {
         this.model.removeInvitation(param1);
      }
      
      private function whisperCallback(param1:String) : void {
         this.chatSignal.dispatch(true,"/tell " + param1 + " ");
         this.view.getCloseSignal().dispatch();
      }
      
      private function jumpCallback(param1:String) : void {
         var _loc4_:SavedCharacter = this.playerModel.getCharacterById(this.playerModel.currentCharId);
         Parameters.data.preferredServer = param1;
         Parameters.save();
         this.enterGame.dispatch();
         var _loc3_:GameInitData = new GameInitData();
         _loc3_.createCharacter = false;
         _loc3_.charId = _loc4_.charId();
         _loc3_.isNewGame = true;
         this.playGame.dispatch(_loc3_);
         this.closeDialog.dispatch();
      }
   }
}
