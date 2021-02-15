package io.decagames.rotmg.social.commands {
   import com.company.util.MoreObjectUtil;
   import io.decagames.rotmg.social.config.FriendsActions;
   import io.decagames.rotmg.social.model.FriendRequestVO;
   import io.decagames.rotmg.ui.popups.modal.error.ErrorModal;
   import io.decagames.rotmg.ui.popups.signals.RemoveLockFade;
   import io.decagames.rotmg.ui.popups.signals.ShowPopupSignal;
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.appengine.api.AppEngineClient;
   import kabam.rotmg.chat.model.ChatMessage;
   import kabam.rotmg.game.signals.AddTextLineSignal;
   import kabam.rotmg.text.view.stringBuilder.LineBuilder;
   
   public class FriendActionCommand {
       
      
      [Inject]
      public var client:AppEngineClient;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var vo:FriendRequestVO;
      
      [Inject]
      public var showPopup:ShowPopupSignal;
      
      [Inject]
      public var removeFade:RemoveLockFade;
      
      [Inject]
      public var addTextLine:AddTextLineSignal;
      
      public function FriendActionCommand() {
         super();
      }
      
      public function execute() : void {
         if(this.vo.request == "/requestFriend") {
            this.addTextLine.dispatch(ChatMessage.make("","Friend request sent"));
         }
         var _loc2_:String = FriendsActions.getURL(this.vo.request);
         var _loc1_:Object = this.account.getCredentials();
         MoreObjectUtil.addToObject(_loc1_,this.account.getCredentials());
         _loc1_.game_net_user_id = this.account.gameNetworkUserId();
         _loc1_.game_net = this.account.gameNetwork();
         _loc1_.play_platform = this.account.playPlatform();
         _loc1_["targetName"] = this.vo.target;
         this.client.complete.addOnce(this.onComplete);
         this.client.sendRequest(_loc2_,_loc1_);
      }
      
      private function onComplete(param1:Boolean, param2:*) : void {
         if(this.vo.callback != null) {
            this.vo.callback(param1,param2,this.vo.target);
         } else if(!param1) {
            this.showPopup.dispatch(new ErrorModal(350,"Friends List Error",LineBuilder.getLocalizedStringFromKey(param2)));
            this.removeFade.dispatch();
         }
      }
   }
}
